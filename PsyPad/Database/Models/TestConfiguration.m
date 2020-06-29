#import "TestConfiguration.h"
#import "TestSequence.h"
#import <AFNetworking/AFNetworking.h>
#import "NSURL+CommonURLs.h"
#import "DatabaseManager.h"
#import "TestSequenceFolder.h"

@interface TestConfiguration ()

// Private interface goes here.

@end

@implementation TestConfiguration

- (int)countQuestions
{
    int total = 0;
    if (self.sequence)
    {
        NSArray *folders = [self.questions_per_folder componentsSeparatedByString:@","];
        for (NSString *folder in folders)
        {
            NSArray *components = [folder componentsSeparatedByString:@":"];
            //NSString *folderName = [components objectAtIndex:0];
            int count = [[components objectAtIndex:1] intValue];

            total += count;
        }
    }
    return total;
}

- (int)questions_in_folder:(NSString *)name
{
    if (self.sequence)
    {
        NSArray *folders = [self.questions_per_folder componentsSeparatedByString:@","];
        for (NSString *folder in folders)
        {
            NSArray *components = [folder componentsSeparatedByString:@":"];
            NSString *folderName = [components objectAtIndex:0];
            int count = [[components objectAtIndex:1] intValue];

            if ([folderName isEqualToString:name])
                return count;
        }
    }

    return 0;
}

- (void)installSequenceWithURL:(NSString *)url
                        params:(NSDictionary *)params
                          data:(NSDictionary *)data
                      progress:(void (^)(NSString *status, float _progress))progress
                          sema:(dispatch_semaphore_t)sema
                           MOC:(NSManagedObjectContext *)MOC;
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TestSequence"];
    request.predicate = [NSPredicate predicateWithFormat:@"(url = %@)", url];

    NSArray *array = [MOC executeFetchRequest:request error:nil];
    if (array.count > 0)
    {
        progress(@"Installing sequence...", 1);

        TestSequence *sequence = [array objectAtIndex:0];
        if (!self.sequence || self.sequence.url != sequence.url)
        {
            [self installSequence:[NSURL fileURLWithPath:sequence.path] name:sequence.name data:data MOC:MOC];
            self.sequence.url = url;
        }
        
        dispatch_semaphore_signal(sema);
    }
    else
    {
        progress(@"Downloading sequence...", 0);

        __block NSString *completeURL = url;
        
        if ([completeURL containsString:@"?"])
            completeURL = [completeURL stringByAppendingString:@"&"];
        else
            completeURL = [completeURL stringByAppendingString:@"?"];
        
        [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop)
        {
            completeURL = [completeURL stringByAppendingFormat:@"%@=%@&", key, value];
        }];
        
        completeURL = [completeURL stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"&"]];
        
        NSMutableURLRequest *_request = [[NSMutableURLRequest alloc] init];
        [_request setURL:[NSURL URLWithString:completeURL]];
        
        NSURL *documentsDirectory = [NSURL documentsDirectory];
        NSString *templateString = [NSString stringWithFormat:@"%@/XXXXXX", [documentsDirectory path]];

        char template[templateString.length + 1];
        strcpy(template, [templateString cStringUsingEncoding:NSASCIIStringEncoding]);
        char *filename = mktemp(template);

        NSURL *newURL = [NSURL fileURLWithPath:[[NSString stringWithCString:filename encoding:NSASCIIStringEncoding] stringByAppendingString:@".set"]];

        [[NSFileManager defaultManager] createFileAtPath:newURL.path contents:nil attributes:nil];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"application/octet-stream"];
        NSLog(@"Completeurl: %@",completeURL);
        [manager GET:completeURL
          parameters:nil
             headers:nil
            progress:nil
             success:^(NSURLSessionTask *task, id responseObject) {
            progress(@"Installing sequence...", 1);
            dispatch_semaphore_t sequence_sema = dispatch_semaphore_create(0);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^
                           {
                [self installSequence:[NSURL fileURLWithPath:newURL.path] name:@"sequence" data:data MOC:MOC];
                dispatch_semaphore_signal(sequence_sema);
            });
            dispatch_semaphore_wait(sequence_sema, DISPATCH_TIME_FOREVER);
            self.sequence.url = url;
#warning can't do this at the moment!
            //[MOC MR_saveToPersistentStoreAndWait];
            [[NSFileManager defaultManager] createFileAtPath:newURL.path contents:responseObject attributes:nil];
            
            dispatch_semaphore_signal(sema);
        }
             failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            dispatch_semaphore_signal(sema);
            
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Download Error"
                                         message:[NSString stringWithFormat:@"%@", error.description]
                                         preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil]];
            
            UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
            if ( viewController.presentedViewController && !viewController.presentedViewController.isBeingDismissed ) {
                viewController = viewController.presentedViewController;
            }
            
            NSLayoutConstraint *constraint = [NSLayoutConstraint
                                              constraintWithItem:alert.view
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationLessThanOrEqual
                                              toItem:nil
                                              attribute:NSLayoutAttributeNotAnAttribute
                                              multiplier:1
                                              constant:viewController.view.frame.size.height*2.0f];
            
            [alert.view addConstraint:constraint];
            [viewController presentViewController:alert animated:YES completion:^{}];
            
        }];
    }
}

- (void)installSequence:(NSURL *)sequenceURL name:(NSString *)name data:(NSDictionary *)data MOC:(NSManagedObjectContext *)MOC
{
    NSMutableOrderedSet *createdFolders = [NSMutableOrderedSet orderedSet];

    NSNumber *background_length = nil;
    NSNumber *background_start = nil;
    
    if (data[@"bg_l"] && data[@"bg_s"])
    {
        background_length = data[@"bg_l"];
        background_start = data[@"bg_s"];
    }
    
    NSNumber *title_length = nil;
    NSNumber *title_start = nil;
    
    if (data[@"t_l"] && data[@"t_s"])
    {
        title_length = data[@"t_l"];
        title_start = data[@"t_s"];
    }
    
    NSNumber *correct_wav_length = nil;
    NSNumber *correct_wav_start = nil;
    
    if (data[@"c_l"] && data[@"c_s"])
    {
        correct_wav_length = data[@"c_l"];
        correct_wav_start = data[@"c_s"];
    }
    
    NSNumber *incorrect_wav_length = nil;
    NSNumber *incorrect_wav_start = nil;
    
    if (data[@"i_l"] && data[@"i_s"])
    {
        incorrect_wav_length = data[@"i_l"];
        incorrect_wav_start = data[@"i_s"];
    }
    
    NSNumber *on_wav_length = nil;
    NSNumber *on_wav_start = nil;
    
    if (data[@"on_l"] && data[@"on_s"])
    {
        on_wav_length = data[@"on_l"];
        on_wav_start = data[@"on_s"];
    }
    
    NSNumber *off_wav_length = nil;
    NSNumber *off_wav_start = nil;
    
    if (data[@"off_l"] && data[@"off_s"])
    {
        off_wav_length = data[@"off_l"];
        off_wav_start = data[@"off_s"];
    }
    
    NSNumber *timeout_wav_length = nil;
    NSNumber *timeout_wav_start = nil;
    
    if (data[@"to_l"] && data[@"to_s"])
    {
        timeout_wav_length = data[@"to_l"];
        timeout_wav_start = data[@"to_s"];
    }
    
    NSNumber *button1_image_length = nil;
    NSNumber *button1_image_start = nil;
    
    if (data[@"b1_l"] && data[@"b1_s"])
    {
        button1_image_length = data[@"b1_l"];
        button1_image_start = data[@"b1_s"];
    }
    
    NSNumber *button2_image_length = nil;
    NSNumber *button2_image_start = nil;
    
    if (data[@"b2_l"] && data[@"b2_s"])
    {
        button2_image_length = data[@"b2_l"];
        button2_image_start = data[@"b2_s"];
    }
    
    NSNumber *button3_image_length = nil;
    NSNumber *button3_image_start = nil;
    
    if (data[@"b3_l"] && data[@"b3_s"])
    {
        button3_image_length = data[@"b3_l"];
        button3_image_start = data[@"b3_s"];
    }
    
    NSNumber *button4_image_length = nil;
    NSNumber *button4_image_start = nil;
    
    if (data[@"b4_l"] && data[@"b4_s"])
    {
        button4_image_length = data[@"b4_l"];
        button4_image_start = data[@"b4_s"];
    }
    
    NSNumber *secondary_button1_image_length = nil;
    NSNumber *secondary_button1_image_start = nil;
    
    if (data[@"sb1_l"] && data[@"sb1_s"])
    {
        secondary_button1_image_length = data[@"sb1_l"];
        secondary_button1_image_start = data[@"sb1_s"];
    }
    
    NSNumber *secondary_button2_image_length = nil;
    NSNumber *secondary_button2_image_start = nil;
    
    if (data[@"sb2_l"] && data[@"sb2_s"])
    {
        secondary_button2_image_length = data[@"sb2_l"];
        secondary_button2_image_start = data[@"sb2_s"];
    }
    
    NSNumber *secondary_button3_image_length = nil;
    NSNumber *secondary_button3_image_start = nil;
    
    if (data[@"sb3_l"] && data[@"sb3_s"])
    {
        secondary_button3_image_length = data[@"sb3_l"];
        secondary_button3_image_start = data[@"sb3_s"];
    }
    
    NSNumber *secondary_button4_image_length = nil;
    NSNumber *secondary_button4_image_start = nil;
    
    if (data[@"sb4_l"] && data[@"sb4_s"])
    {
        secondary_button4_image_length = data[@"sb4_l"];
        secondary_button4_image_start = data[@"sb4_s"];
    }
    
    NSNumber *secondary_image1_length = nil;
    NSNumber *secondary_image1_start = nil;
    
    if (data[@"si1_l"] && data[@"si1_s"])
    {
        secondary_image1_length = data[@"si1_l"];
        secondary_image1_start = data[@"si1_s"];
    }
    
    NSNumber *secondary_image2_length = nil;
    NSNumber *secondary_image2_start = nil;
    
    if (data[@"si2_l"] && data[@"si2_s"])
    {
        secondary_image2_length = data[@"si2_l"];
        secondary_image2_start = data[@"si2_s"];
    }
    
    NSNumber *secondary_image3_length = nil;
    NSNumber *secondary_image3_start = nil;
    
    if (data[@"si3_l"] && data[@"si3_s"])
    {
        secondary_image3_length = data[@"si3_l"];
        secondary_image3_start = data[@"si3_s"];
    }
    
    NSNumber *secondary_image4_length = nil;
    NSNumber *secondary_image4_start = nil;
    
    if (data[@"si4_l"] && data[@"si4_s"])
    {
        secondary_image4_length = data[@"si4_l"];
        secondary_image4_start = data[@"si4_s"];
    }
    
    NSArray *folders = data[@"g"];
    for (NSDictionary *group in [folders sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *a, NSDictionary *b)
    {
        return [a[@"n"] compare:b[@"n"]];
    }])
    {
        NSString *groupName = group[@"n"];
        NSArray *images = group[@"i"];
        
        NSLog(@"Found group: %@", groupName);

        NSMutableOrderedSet *createdImages = [NSMutableOrderedSet orderedSet];

        for (NSDictionary *image in [images sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *a, NSDictionary *b)
        {
            return [a[@"n"] compare:b[@"n"]];
        }])
        {
            BOOL animated = [image[@"a"] boolValue];
            NSString *imageName = image[@"n"];
            NSArray *frames = image[@"f"];
            
            if (!animated)
            {
                TestSequenceImage *createdImage = [TestSequenceImage MR_createEntityInContext:MOC];
                createdImage.name = imageName;
                createdImage.is_animated = @NO;

                createdImage.start = frames[0][@"s"];
                createdImage.length = frames[0][@"l"];

                [createdImages addObject:createdImage];
            }
            else
            {
                TestSequenceImage *createdImage = [TestSequenceImage MR_createEntityInContext:MOC];
                createdImage.name = imageName;
                createdImage.is_animated = @YES;
                createdImage.animated_images = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:frames options:0 error:nil] encoding:NSUTF8StringEncoding];

                [createdImages addObject:createdImage];
            }
        }

        TestSequenceFolder *createdFolder = [TestSequenceFolder MR_createEntityInContext:MOC];
        createdFolder.name = groupName;
        [createdFolder addImages:createdImages];

        [createdFolders addObject:createdFolder];
    }

    TestSequence *newSequence = [TestSequence MR_createEntityInContext:MOC];
    newSequence.name = name;
    newSequence.path = sequenceURL.path;
    newSequence.background_length = background_length;
    newSequence.background_start = background_start;
    newSequence.title_length = title_length;
    newSequence.title_start = title_start;
    newSequence.correct_wav_length = correct_wav_length;
    newSequence.correct_wav_start = correct_wav_start;
    newSequence.incorrect_wav_length = incorrect_wav_length;
    newSequence.incorrect_wav_start = incorrect_wav_start;
    newSequence.on_wav_length = on_wav_length;
    newSequence.on_wav_start = on_wav_start;
    newSequence.off_wav_length = off_wav_length;
    newSequence.off_wav_start = off_wav_start;
    newSequence.timeout_wav_length = timeout_wav_length;
    newSequence.timeout_wav_start = timeout_wav_start;
    
    newSequence.button1_image_start = button1_image_start;
    newSequence.button1_image_length = button1_image_length;
    newSequence.button2_image_start = button2_image_start;
    newSequence.button2_image_length = button2_image_length;
    newSequence.button3_image_start = button3_image_start;
    newSequence.button3_image_length = button3_image_length;
    newSequence.button4_image_start = button4_image_start;
    newSequence.button4_image_length = button4_image_length;
    
    newSequence.secondary_button1_image_start = secondary_button1_image_start;
    newSequence.secondary_button1_image_length = secondary_button1_image_length;
    newSequence.secondary_button2_image_start = secondary_button2_image_start;
    newSequence.secondary_button2_image_length = secondary_button2_image_length;
    newSequence.secondary_button3_image_start = secondary_button3_image_start;
    newSequence.secondary_button3_image_length = secondary_button3_image_length;
    newSequence.secondary_button4_image_start = secondary_button4_image_start;
    newSequence.secondary_button4_image_length = secondary_button4_image_length;
    
    newSequence.secondary_image1_start = secondary_image1_start;
    newSequence.secondary_image1_length = secondary_image1_length;
    newSequence.secondary_image2_start = secondary_image2_start;
    newSequence.secondary_image2_length = secondary_image2_length;
    newSequence.secondary_image3_start = secondary_image3_start;
    newSequence.secondary_image3_length = secondary_image3_length;
    newSequence.secondary_image4_start = secondary_image4_start;
    newSequence.secondary_image4_length = secondary_image4_length;
    
    [newSequence addFolders:createdFolders];

    if (self.sequence)
    {
        [self.sequence MR_deleteEntity];
        self.sequence = nil;
    }

    self.sequence = newSequence;

#warning can't do this at the moment!
    //[MOC MR_saveToPersistentStoreAndWait];

    NSLog(@"Saved to database.");
}

- (void)copyFromConfiguration:(TestConfiguration *)configuration
{
    NSDictionary *data = [configuration serialise];
    [self loadData:data];

    self.sequence = configuration.sequence;
}

- (void)loadData:(NSDictionary *)data
{
    NSArray *keys = @[
        @"name",
        @"title",
        @"configuration_description",
        @"enabled",
        @"is_practice",
        @"is_gallery_configuration",
        @"day_of_week_mon",
        @"day_of_week_tue",
        @"day_of_week_wed",
        @"day_of_week_thu",
        @"day_of_week_fri",
        @"day_of_week_sat",
        @"day_of_week_sun",
        //@"image_set_url",
        @"loop_animations",
        @"animation_frame_rate",
        @"use_staircase_method",
        @"number_of_staircases",
        @"start_level",
        @"number_of_reversals",
        @"hits_to_finish",
        @"minimum_level",
        @"maximum_level",
        @"delta_values",
        @"num_wrong_to_get_easier",
        @"num_correct_to_get_harder",
        @"questions_per_folder",
        @"background_colour",
        @"show_exit_button",
        @"exit_button_bg",
        @"exit_button_fg",
        @"exit_button_h",
        @"exit_button_w",
        @"exit_button_x",
        @"exit_button_y",
        @"num_buttons",
        @"num_secondary_buttons",
        @"button_presentation_delay",
        @"button1_bg",
        @"button1_fg",
        @"button1_h",
        @"button1_text",
        @"button1_w",
        @"button1_x",
        @"button1_y",
        @"button2_bg",
        @"button2_fg",
        @"button2_h",
        @"button2_text",
        @"button2_w",
        @"button2_x",
        @"button2_y",
        @"button3_bg",
        @"button3_fg",
        @"button3_h",
        @"button3_text",
        @"button3_w",
        @"button3_x",
        @"button3_y",
        @"button4_bg",
        @"button4_fg",
        @"button4_h",
        @"button4_text",
        @"button4_w",
        @"button4_x",
        @"button4_y",
        @"secondary_button1_bg",
        @"secondary_button1_fg",
        @"secondary_button1_h",
        @"secondary_button1_text",
        @"secondary_button1_w",
        @"secondary_button1_x",
        @"secondary_button1_y",
        @"secondary_button2_bg",
        @"secondary_button2_fg",
        @"secondary_button2_h",
        @"secondary_button2_text",
        @"secondary_button2_w",
        @"secondary_button2_x",
        @"secondary_button2_y",
        @"secondary_button3_bg",
        @"secondary_button3_fg",
        @"secondary_button3_h",
        @"secondary_button3_text",
        @"secondary_button3_w",
        @"secondary_button3_x",
        @"secondary_button3_y",
        @"secondary_button4_bg",
        @"secondary_button4_fg",
        @"secondary_button4_h",
        @"secondary_button4_text",
        @"secondary_button4_w",
        @"secondary_button4_x",
        @"secondary_button4_y",
        @"require_next",
        @"time_between_question_mean",
        @"time_between_question_plusminus",
        @"infinite_presentation_time",
        @"finite_presentation_time",
        @"infinite_response_window",
        @"finite_response_window",
        @"use_specified_seed",
        @"specified_seed",
        @"attempt_facial_recognition",
        @"enable_secondary_stimuli"
    ];
    
    for (NSString *key in keys)
    {
        id value = data[key];
        if ([value isEqual:[NSNull null]])
            value = nil;
        
        if ([value isKindOfClass:[NSString class]])
        {
            NSEntityDescription *desc = [TestConfiguration MR_entityDescription];
            NSAttributeDescription *attr = desc.attributesByName[key];
            
            NSString *str = value;
            switch (attr.attributeType)
            {
                case NSInteger16AttributeType: { value = @((short)[str intValue]); } break;
                case NSInteger32AttributeType: { value = @([str intValue]); } break;
                case NSInteger64AttributeType: { value = @([str longLongValue]); } break;
                case NSDoubleAttributeType   : { value = @([str doubleValue]); } break;
                case NSFloatAttributeType    : { value = @([str floatValue]); } break;
                case NSBooleanAttributeType  : { value = @([str boolValue]); } break;
                case NSDateAttributeType     : {
                    NSDateFormatter *df = [[NSDateFormatter alloc] init];
                    df.dateFormat = @"yyyy-MM-dd HH:mm:ss ZZZ";
                    value = [df dateFromString:str];
                } break;
                default: break;
            }
        }
        
        [self setValue:value forKey:key];
    };
}

- (NSDictionary *)serialise
{
    NSArray *keys = @[
        @"name",
        @"title",
        @"configuration_description",
        @"enabled",
        @"is_practice",
        @"is_gallery_configuration",
        @"day_of_week_mon",
        @"day_of_week_tue",
        @"day_of_week_wed",
        @"day_of_week_thu",
        @"day_of_week_fri",
        @"day_of_week_sat",
        @"day_of_week_sun",
        //@"image_set_url",
        @"loop_animations",
        @"animation_frame_rate",
        @"use_staircase_method",
        @"number_of_staircases",
        @"start_level",
        @"number_of_reversals",
        @"hits_to_finish",
        @"minimum_level",
        @"maximum_level",
        @"delta_values",
        @"num_wrong_to_get_easier",
        @"num_correct_to_get_harder",
        @"questions_per_folder",
        @"background_colour",
        @"show_exit_button",
        @"exit_button_bg",
        @"exit_button_fg",
        @"exit_button_h",
        @"exit_button_w",
        @"exit_button_x",
        @"exit_button_y",
        @"num_buttons",
        @"num_secondary_buttons",
        @"button_presentation_delay",
        @"button1_bg",
        @"button1_fg",
        @"button1_h",
        @"button1_text",
        @"button1_w",
        @"button1_x",
        @"button1_y",
        @"button2_bg",
        @"button2_fg",
        @"button2_h",
        @"button2_text",
        @"button2_w",
        @"button2_x",
        @"button2_y",
        @"button3_bg",
        @"button3_fg",
        @"button3_h",
        @"button3_text",
        @"button3_w",
        @"button3_x",
        @"button3_y",
        @"button4_bg",
        @"button4_fg",
        @"button4_h",
        @"button4_text",
        @"button4_w",
        @"button4_x",
        @"button4_y",
        @"secondary_button1_bg",
        @"secondary_button1_fg",
        @"secondary_button1_h",
        @"secondary_button1_text",
        @"secondary_button1_w",
        @"secondary_button1_x",
        @"secondary_button1_y",
        @"secondary_button2_bg",
        @"secondary_button2_fg",
        @"secondary_button2_h",
        @"secondary_button2_text",
        @"secondary_button2_w",
        @"secondary_button2_x",
        @"secondary_button2_y",
        @"secondary_button3_bg",
        @"secondary_button3_fg",
        @"secondary_button3_h",
        @"secondary_button3_text",
        @"secondary_button3_w",
        @"secondary_button3_x",
        @"secondary_button3_y",
        @"secondary_button4_bg",
        @"secondary_button4_fg",
        @"secondary_button4_h",
        @"secondary_button4_text",
        @"secondary_button4_w",
        @"secondary_button4_x",
        @"secondary_button4_y",
        @"require_next",
        @"time_between_question_mean",
        @"time_between_question_plusminus",
        @"infinite_presentation_time",
        @"finite_presentation_time",
        @"infinite_response_window",
        @"finite_response_window",
        @"use_specified_seed",
        @"specified_seed",
        @"attempt_facial_recognition",
        @"enable_secondary_stimuli"
    ];
    
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    for (NSString *key in keys)
        [data setValue:[self valueForKey:key] forKey:key];

    if (self.sequence && self.sequence.url)
        [data setObject:self.sequence.url forKey:@"image_set_url"];

    return data;
}

@end
