//
//  TestConfiguration.m
//  PsyPad
//
//  Created by David Lawson on 5/12/12.
//

#import "TestConfiguration.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "TestSequence.h"
#import "TestSequenceFolder.h"
#import "AppDelegate.h"
#import "TestSequenceImage.h"

@implementation TestConfiguration

@dynamic animation_frame_rate;
@dynamic background_colour;
@dynamic button_text_four;
@dynamic button_text_one;
@dynamic button_text_three;
@dynamic button_text_two;
@dynamic button1_bg;
@dynamic button1_fg;
@dynamic button1_h;
@dynamic button1_w;
@dynamic button1_x;
@dynamic button1_y;
@dynamic button2_bg;
@dynamic button2_fg;
@dynamic button2_h;
@dynamic button2_w;
@dynamic button2_x;
@dynamic button2_y;
@dynamic button3_bg;
@dynamic button3_fg;
@dynamic button3_h;
@dynamic button3_w;
@dynamic button3_x;
@dynamic button3_y;
@dynamic button4_bg;
@dynamic button4_fg;
@dynamic button4_h;
@dynamic button4_w;
@dynamic button4_x;
@dynamic button4_y;
@dynamic day_of_week_fri;
@dynamic day_of_week_mon;
@dynamic day_of_week_sat;
@dynamic day_of_week_sun;
@dynamic day_of_week_thu;
@dynamic day_of_week_tue;
@dynamic day_of_week_wed;
@dynamic enabled;
@dynamic exit_button_bg;
@dynamic exit_button_fg;
@dynamic exit_button_h;
@dynamic exit_button_w;
@dynamic exit_button_x;
@dynamic exit_button_y;
@dynamic images_together_presentation_time;
@dynamic images_together_presentation_time_is_infinite;
@dynamic loop_animated_images;
@dynamic name;
@dynamic num_staircases_interleaved;
@dynamic number_of_buttons;
@dynamic practice_configuration;
@dynamic questions_per_folder;
@dynamic randomisation_specified_seed;
@dynamic randomisation_use_specified_seed;
@dynamic require_next;
@dynamic show_exit_button;
@dynamic staircase_deltas;
@dynamic staircase_floor_ceiling_hits;
@dynamic staircase_max_level;
@dynamic staircase_min_level;
@dynamic staircase_num_correct_to_get_harder;
@dynamic staircase_num_incorrect_to_get_easier;
@dynamic staircase_num_reversals;
@dynamic staircase_start_level;
@dynamic time_between_question_mean;
@dynamic time_between_question_plusminus;
@dynamic use_staircase_method;
@dynamic sequence;
@dynamic user;

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

/*- (void) installPreloadedSequence:(NSString *)sequenceName
{
    NSURL *sequenceFolder = [[APP_DELEGATE applicationDocumentsDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"Sequences/%@", sequenceName]];
    [self installSequence:sequenceFolder name:sequenceName preloaded:YES];
}*/

- (void)installSequenceWithURL:(NSString *)url data:(NSDictionary *)data progress:(void (^)(NSString *status, float _progress))progress sema:(dispatch_semaphore_t)sema;
{
    NSManagedObjectContext *MOC = [APP_DELEGATE managedObjectContext];
    //NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"TestSequence" inManagedObjectContext:MOC];

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TestSequence"];
    request.predicate = [NSPredicate predicateWithFormat:@"(url = %@)", url];

    NSArray *array = [MOC executeFetchRequest:request error:nil];
    if (array.count > 0)
    {
        progress(@"Installing sequence...", 0);

        TestSequence *sequence = [array objectAtIndex:0];
        if (!self.sequence || self.sequence.url != sequence.url)
        {
            [self installSequence:[NSURL fileURLWithPath:sequence.path] name:sequence.name data:data];
            self.sequence.url = url;
        }
        dispatch_semaphore_signal(sema);
    }
    else
    {
        progress(@"Downloading sequence...", 0);

        NSMutableURLRequest *_request = [[NSMutableURLRequest alloc] init];
        [_request setURL:[NSURL URLWithString:url]];

        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:_request];

        operation.responseSerializer = [AFHTTPResponseSerializer serializer];

        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long int totalBytesRead, long long int totalBytesExpectedToRead)
        {
            progress(@"Downloading sequence...", (float)totalBytesRead/(float)totalBytesExpectedToRead);
        }];

        NSURL *documentsDirectory = [APP_DELEGATE applicationDocumentsDirectory];
        NSString *templateString = [NSString stringWithFormat:@"%@/XXXXXX", [documentsDirectory path]];

        char template[templateString.length + 1];
        strcpy(template, [templateString cStringUsingEncoding:NSASCIIStringEncoding]);
        char *filename = mktemp(template);

        NSURL *newURL = [NSURL fileURLWithPath:[[NSString stringWithCString:filename encoding:NSASCIIStringEncoding] stringByAppendingString:@".set"]];

        [[NSFileManager defaultManager] createFileAtPath:newURL.path contents:nil attributes:nil];

        operation.outputStream = [NSOutputStream outputStreamToFileAtPath:newURL.path append:NO];

        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *_operation, id responseObject)
        {
            [self installSequence:[NSURL fileURLWithPath:newURL.path] name:@"sequence" data:data];
            self.sequence.url = url;
            [APP_DELEGATE saveContext];

            dispatch_semaphore_signal(sema);

        } failure:^(AFHTTPRequestOperation *_operation, NSError *error)
        {
            dispatch_semaphore_signal(sema);

            [[[UIAlertView alloc] initWithTitle:@"Download Error"
                                        message:[NSString stringWithFormat:@"%@", error.description]
                                       delegate:nil
                              cancelButtonTitle:@"Close"
                              otherButtonTitles:nil] show];

            NSLog(@"%@", error.description);
        }];

        [operation start];
        NSLog(@"Started operation");
    }
}

- (void)installSequence:(NSURL *)sequenceURL name:(NSString *)name data:(NSDictionary *)data
{
    NSMutableOrderedSet *folders = [NSMutableOrderedSet orderedSet];

    NSDictionary *folderNames = data;
    for (NSString *folderName in [folderNames.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *a, NSString *b)
    {
        return [a compare:b];
    }])
    {
        NSLog(@"Found folder: %@", folderName);

        NSMutableOrderedSet *images = [NSMutableOrderedSet orderedSet];

        NSDictionary *imageNames = [data objectForKey:folderName];

        for (NSString *imageName in [imageNames.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *a, NSString *b)
        {
            return [a compare:b];
        }])
        {
            id image_data = [imageNames objectForKey:imageName];

            if ([image_data isKindOfClass:[NSArray class]])
            {
                TestSequenceImage *image = [NSEntityDescription insertNewObjectForEntityForName:@"TestSequenceImage" inManagedObjectContext:APP_DELEGATE.managedObjectContext];
                image.name = imageName;
                image.is_animated = [NSNumber numberWithBool:NO];

                NSArray *image_data_array = image_data;
                NSString *image_data_start = [image_data_array objectAtIndex:0];
                NSString *image_data_length = [image_data_array objectAtIndex:1];

                image.start = @((long)image_data_start.longLongValue);
                image.length = @(image_data_length.intValue);

                [images addObject:image];
            }
            else
            {
                TestSequenceImage *image = [NSEntityDescription insertNewObjectForEntityForName:@"TestSequenceImage" inManagedObjectContext:APP_DELEGATE.managedObjectContext];
                image.name = imageName;
                image.is_animated = [NSNumber numberWithBool:YES];
                image.animated_images = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:image_data options:nil error:nil] encoding:NSASCIIStringEncoding];

                [images addObject:image];
            }
        }

        TestSequenceFolder *folder = [NSEntityDescription insertNewObjectForEntityForName:@"TestSequenceFolder" inManagedObjectContext:APP_DELEGATE.managedObjectContext];
        folder.name = folderName;
        [folder addImages:images];

        [folders addObject:folder];
    }

    TestSequence *newSequence = [NSEntityDescription insertNewObjectForEntityForName:@"TestSequence" inManagedObjectContext:APP_DELEGATE.managedObjectContext];
    newSequence.name = name;
    newSequence.path = sequenceURL.path;
    [newSequence addFolders:folders];

    if (self.sequence)
    {
        [APP_DELEGATE.managedObjectContext deleteObject:self.sequence];
        self.sequence = nil;
    }

    self.sequence = newSequence;

    [APP_DELEGATE saveContext];

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
    NSMutableDictionary *fixed_data = [data mutableCopy];
    for (NSString *key in data.allKeys)
    {
        if ([[fixed_data objectForKey:key] isKindOfClass:[NSNumber class]])
            [fixed_data setObject:[(NSNumber *)[data objectForKey:key] stringValue] forKey:key];
    }

    data = fixed_data;

    self.name = [data objectForKey:@"name"];

    if ([(NSString *)[data objectForKey:@"enabled"] isEqualToString:@"1"])
        self.enabled = @YES;
    else
        self.enabled = @NO;

    if ([(NSString *)[data objectForKey:@"practice_configuration"] isEqualToString:@"1"])
        self.practice_configuration = @YES;
    else
        self.practice_configuration = @NO;

    if ([(NSString *)[data objectForKey:@"day_of_week_mon"] isEqualToString:@"1"])
        self.day_of_week_mon = @YES;
    else
        self.day_of_week_mon = @NO;

    if ([(NSString *)[data objectForKey:@"day_of_week_tue"] isEqualToString:@"1"])
        self.day_of_week_tue = @YES;
    else
        self.day_of_week_tue = @NO;

    if ([(NSString *)[data objectForKey:@"day_of_week_wed"] isEqualToString:@"1"])
        self.day_of_week_wed = @YES;
    else
        self.day_of_week_wed = @NO;

    if ([(NSString *)[data objectForKey:@"day_of_week_thu"] isEqualToString:@"1"])
        self.day_of_week_thu = @YES;
    else
        self.day_of_week_thu = @NO;

    if ([(NSString *)[data objectForKey:@"day_of_week_fri"] isEqualToString:@"1"])
        self.day_of_week_fri = @YES;
    else
        self.day_of_week_fri = @NO;

    if ([(NSString *)[data objectForKey:@"day_of_week_sat"] isEqualToString:@"1"])
        self.day_of_week_sat = @YES;
    else
        self.day_of_week_sat = @NO;

    if ([(NSString *)[data objectForKey:@"day_of_week_sun"] isEqualToString:@"1"])
        self.day_of_week_sun = @YES;
    else
        self.day_of_week_sun = @NO;

    if ([(NSString *)[data objectForKey:@"loop_animated_images"] isEqualToString:@"1"])
        self.loop_animated_images = @YES;
    else
        self.loop_animated_images = @NO;

    self.animation_frame_rate =
            @([(NSString *)[data objectForKey:@"animation_frame_rate"] intValue]);

    if ([(NSString *)[data objectForKey:@"use_staircase_method"] isEqualToString:@"1"])
        self.use_staircase_method = @YES;
    else
        self.use_staircase_method = @NO;

    self.num_staircases_interleaved =
            @([(NSString *)[data objectForKey:@"number_of_staircases"] intValue]);

    self.staircase_start_level = [data objectForKey:@"staircase_start_level"];
    self.staircase_num_reversals = [data objectForKey:@"number_of_reversals"];
    self.staircase_floor_ceiling_hits = [data objectForKey:@"hits_to_finish"];
    self.staircase_min_level = [data objectForKey:@"staircase_min_level"];
    self.staircase_max_level = [data objectForKey:@"staircase_max_level"];
    self.staircase_deltas = [data objectForKey:@"delta_values"];
    self.questions_per_folder = [data objectForKey:@"questions_per_folder"];
    self.staircase_num_correct_to_get_harder = [data objectForKey:@"num_correct_to_get_harder"];
    self.staircase_num_incorrect_to_get_easier = [data objectForKey:@"num_wrong_to_get_easier"];

    self.background_colour = [data objectForKey:@"background_colour"];

    if ([(NSString *)[data objectForKey:@"show_exit_button"] isEqualToString:@"1"])
        self.show_exit_button = @YES;
    else
        self.show_exit_button = @NO;

    self.exit_button_x =
            @([(NSString *)[data objectForKey:@"exit_button_x"] intValue]);

    self.exit_button_y =
            @([(NSString *)[data objectForKey:@"exit_button_y"] intValue]);

    self.exit_button_w =
            @([(NSString *)[data objectForKey:@"exit_button_w"] intValue]);

    self.exit_button_h =
            @([(NSString *)[data objectForKey:@"exit_button_h"] intValue]);

    self.exit_button_fg = [data objectForKey:@"exit_button_fg"];
    self.exit_button_bg = [data objectForKey:@"exit_button_bg"];

    self.number_of_buttons =
            @([(NSString *)[data objectForKey:@"num_buttons"] intValue]);

    self.button_text_one = [data objectForKey:@"button1_text"];
    self.button_text_two = [data objectForKey:@"button2_text"];
    self.button_text_three = [data objectForKey:@"button3_text"];
    self.button_text_four = [data objectForKey:@"button4_text"];

    self.button1_bg = [data objectForKey:@"button1_bg"];
    self.button2_bg = [data objectForKey:@"button2_bg"];
    self.button3_bg = [data objectForKey:@"button3_bg"];
    self.button4_bg = [data objectForKey:@"button4_bg"];

    self.button1_fg = [data objectForKey:@"button1_fg"];
    self.button2_fg = [data objectForKey:@"button2_fg"];
    self.button3_fg = [data objectForKey:@"button3_fg"];
    self.button4_fg = [data objectForKey:@"button4_fg"];

    self.button1_x =
            @([(NSString *)[data objectForKey:@"button1_x"] intValue]);
    self.button1_y =
            @([(NSString *)[data objectForKey:@"button1_y"] intValue]);
    self.button1_w =
            @([(NSString *)[data objectForKey:@"button1_w"] intValue]);
    self.button1_h =
            @([(NSString *)[data objectForKey:@"button1_h"] intValue]);

    self.button2_x =
            @([(NSString *)[data objectForKey:@"button2_x"] intValue]);
    self.button2_y =
            @([(NSString *)[data objectForKey:@"button2_y"] intValue]);
    self.button2_w =
            @([(NSString *)[data objectForKey:@"button2_w"] intValue]);
    self.button2_h =
            @([(NSString *)[data objectForKey:@"button2_h"] intValue]);

    self.button3_x =
            @([(NSString *)[data objectForKey:@"button3_x"] intValue]);
    self.button3_y =
            @([(NSString *)[data objectForKey:@"button3_y"] intValue]);
    self.button3_w =
            @([(NSString *)[data objectForKey:@"button3_w"] intValue]);
    self.button3_h =
            @([(NSString *)[data objectForKey:@"button3_h"] intValue]);

    self.button4_x =
            @([(NSString *)[data objectForKey:@"button4_x"] intValue]);
    self.button4_y =
            @([(NSString *)[data objectForKey:@"button4_y"] intValue]);
    self.button4_w =
            @([(NSString *)[data objectForKey:@"button4_w"] intValue]);
    self.button4_h =
            @([(NSString *)[data objectForKey:@"button4_h"] intValue]);

    if ([(NSString *)[data objectForKey:@"require_next"] isEqualToString:@"1"])
        self.require_next = @YES;
    else
        self.require_next = @NO;

    self.time_between_question_mean =
            @([(NSString *)[data objectForKey:@"time_between_each_question_mean"] floatValue]);

    self.time_between_question_plusminus =
            @([(NSString *)[data objectForKey:@"time_between_each_question_plusminus"] floatValue]);

    if ([(NSString *)[data objectForKey:@"infinite_presentation_time"] isEqualToString:@"1"])
        self.images_together_presentation_time_is_infinite = @YES;
    else
        self.images_together_presentation_time_is_infinite = @NO;

    self.images_together_presentation_time =
            @([(NSString *)[data objectForKey:@"presentation_time"] floatValue]);

    if ([(NSString *)[data objectForKey:@"use_specified_seed"] isEqualToString:@"1"])
        self.randomisation_use_specified_seed = @YES;
    else
        self.randomisation_use_specified_seed = @NO;

    self.randomisation_specified_seed =
            @([(NSString *)[data objectForKey:@"specified_seed"] intValue]);
}

- (NSDictionary *)serialise
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];

    [data setObject:self.name forKey:@"name"];
    [data setObject:self.enabled forKey:@"enabled"];

    [data setObject:self.practice_configuration forKey:@"practice_configuration"];

    [data setObject:self.day_of_week_mon forKey:@"day_of_week_mon"];
    [data setObject:self.day_of_week_tue forKey:@"day_of_week_tue"];
    [data setObject:self.day_of_week_wed forKey:@"day_of_week_wed"];
    [data setObject:self.day_of_week_thu forKey:@"day_of_week_thu"];
    [data setObject:self.day_of_week_fri forKey:@"day_of_week_fri"];
    [data setObject:self.day_of_week_sat forKey:@"day_of_week_sat"];
    [data setObject:self.day_of_week_sun forKey:@"day_of_week_sun"];

    if (self.sequence && self.sequence.url)
        [data setObject:self.sequence.url forKey:@"imageset_url"];

    [data setObject:self.loop_animated_images forKey:@"loop_animated_images"];

    [data setObject:self.animation_frame_rate forKey:@"animation_frame_rate"];
    [data setObject:self.use_staircase_method forKey:@"use_staircase_method"];

    [data setObject:self.num_staircases_interleaved forKey:@"number_of_staircases"];

    [data setObject:self.staircase_start_level forKey:@"staircase_start_level"];
    [data setObject:self.staircase_num_reversals forKey:@"number_of_reversals"];
    [data setObject:self.staircase_floor_ceiling_hits forKey:@"hits_to_finish"];
    [data setObject:self.staircase_min_level forKey:@"staircase_min_level"];
    [data setObject:self.staircase_max_level forKey:@"staircase_max_level"];
    [data setObject:self.staircase_deltas forKey:@"delta_values"];
    [data setObject:self.questions_per_folder forKey:@"questions_per_folder"];
    [data setObject:self.staircase_num_correct_to_get_harder forKey:@"num_correct_to_get_harder"];
    [data setObject:self.staircase_num_incorrect_to_get_easier forKey:@"num_wrong_to_get_easier"];

    [data setObject:self.background_colour forKey:@"background_colour"];

    [data setObject:self.show_exit_button forKey:@"show_exit_button"];
    [data setObject:self.exit_button_x forKey:@"exit_button_x"];
    [data setObject:self.exit_button_y forKey:@"exit_button_y"];
    [data setObject:self.exit_button_w forKey:@"exit_button_w"];
    [data setObject:self.exit_button_h forKey:@"exit_button_h"];
    [data setObject:self.exit_button_fg forKey:@"exit_button_fg"];
    [data setObject:self.exit_button_bg forKey:@"exit_button_bg"];

    [data setObject:self.number_of_buttons forKey:@"num_buttons"];
    [data setObject:self.button_text_one forKey:@"button1_text"];
    [data setObject:self.button_text_two forKey:@"button2_text"];
    [data setObject:self.button_text_three forKey:@"button3_text"];
    [data setObject:self.button_text_four forKey:@"button4_text"];

    [data setObject:self.button1_bg forKey:@"button1_bg"];
    [data setObject:self.button2_bg forKey:@"button2_bg"];
    [data setObject:self.button3_bg forKey:@"button3_bg"];
    [data setObject:self.button4_bg forKey:@"button4_bg"];

    [data setObject:self.button1_fg forKey:@"button1_fg"];
    [data setObject:self.button2_fg forKey:@"button2_fg"];
    [data setObject:self.button3_fg forKey:@"button3_fg"];
    [data setObject:self.button4_fg forKey:@"button4_fg"];

    [data setObject:self.button1_x forKey:@"button1_x"];
    [data setObject:self.button1_y forKey:@"button1_y"];
    [data setObject:self.button1_w forKey:@"button1_w"];
    [data setObject:self.button1_h forKey:@"button1_h"];

    [data setObject:self.button2_x forKey:@"button2_x"];
    [data setObject:self.button2_y forKey:@"button2_y"];
    [data setObject:self.button2_w forKey:@"button2_w"];
    [data setObject:self.button2_h forKey:@"button2_h"];

    [data setObject:self.button3_x forKey:@"button3_x"];
    [data setObject:self.button3_y forKey:@"button3_y"];
    [data setObject:self.button3_w forKey:@"button3_w"];
    [data setObject:self.button3_h forKey:@"button3_h"];

    [data setObject:self.button4_x forKey:@"button4_x"];
    [data setObject:self.button4_y forKey:@"button4_y"];
    [data setObject:self.button4_w forKey:@"button4_w"];
    [data setObject:self.button4_h forKey:@"button4_h"];

    [data setObject:self.require_next forKey:@"require_next"];
    [data setObject:self.time_between_question_mean forKey:@"time_between_each_question_mean"];
    [data setObject:self.time_between_question_plusminus forKey:@"time_between_each_question_plusminus"];
    [data setObject:self.images_together_presentation_time_is_infinite forKey:@"infinite_presentation_time"];
    [data setObject:self.images_together_presentation_time forKey:@"presentation_time"];
    [data setObject:self.randomisation_use_specified_seed forKey:@"use_specified_seed"];
    [data setObject:self.randomisation_specified_seed forKey:@"specified_seed"];

    NSLog(@"%@", data);

    return data;
}

@end
