//
//  TestViewController.m
//  PsyPad
//
//  Created by David Lawson on 5/12/12.
//

#import "TestViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "AppDelegate.h"
#import "TestConfiguration.h"
#import "TestSequence.h"
#import "User.h"
#import "TestSequenceFolder.h"
#import "Random.h"
#import "TestSequenceImage.h"
#import "TestLog.h"
#import "TestImageButton.h"
#import "UIView+Positioning.h"
#import "TestButton.h"
#import "TestLogItem.h"
#import "NSObject+DelayBlock.h"
#import "Staircase.h"
#import "NSString+getNumberFromString.h"
#import "NSArray+GetRandom.h"
#import "AppConfiguration.h"

#import "UIColor+Hex.h"
#import "DistanceDetector.h"
#import "APIController.h"

#import "NSObject+DelayBlock.h"

// Shortcuts for the view size
#define VIEW_HEIGHT self.view.bounds.size.height
#define VIEW_WIDTH self.view.bounds.size.width

@interface TestViewController ()

@end

@implementation TestViewController

#pragma mark - Initial setup

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.questionNumber = 0;
    }

    return self;
}

- (TestConfiguration *)firstConfiguration
{
    return [self.configurations objectAtIndex:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];

    self.questionLabel.hidden = YES;
    self.configurationNameLabel.hidden = YES;
    self.beginConfigurationButton.hidden = YES;

    [self.configurationNameLabel moveToX:0 y:327];
    [self.beginConfigurationButton moveToX:441 y:387];

    self.view.backgroundColor = [UIColor colorWithHexString:self.firstConfiguration.background_colour];

    if (self.currentConfiguration.show_exit_button.boolValue)
    {
        self.exitButton.hidden = NO;
        [self.exitButton setTitleColor:[UIColor colorWithHexString:self.firstConfiguration.exit_button_fg] forState:UIControlStateNormal];
        self.exitButton.backgroundColor = [UIColor colorWithHexString:self.firstConfiguration.exit_button_bg];
        [self.exitButton setWidth:self.firstConfiguration.exit_button_w.intValue height:self.firstConfiguration.exit_button_h.intValue];
        [self.exitButton moveToX:self.firstConfiguration.exit_button_x.intValue y:self.firstConfiguration.exit_button_y.intValue];
    }
    else
    {
        self.exitButton.hidden = YES;
    }

    self.distanceDetector = [[DistanceDetector alloc] init];

    [[UIScreen mainScreen] setBrightness:1.0];
}

#pragma mark - UIViewController delegate methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIDeviceOrientationIsLandscape(toInterfaceOrientation);
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - User interaction

- (IBAction)pressBeginButton:(id)sender
{
     self.beginTestButton.hidden = YES;

     self.currentConfiguration = [self nextConfiguration];

     if (self.configurations.count == 1)
     {
         [self beginConfiguration];
     }
     else if (self.configurations.count > 1)
     {
         [self presentConfiguration];
     }
}

- (TestConfiguration *)nextConfiguration
{
    if (!self.currentConfiguration && self.configurations.count > 0)
    {
        self.questionNumber = 0;
        return [self.configurations objectAtIndex:0];
    }
    else if (self.currentConfiguration)
    {
        int curIndex = [self.configurations indexOfObject:self.currentConfiguration];
        if (curIndex + 1 <= self.configurations.count - 1)
        {
            self.questionNumber = 0;
            return [self.configurations objectAtIndex:(NSUInteger)(curIndex + 1)];
        }
    }

    return NULL;
}

- (void)presentConfiguration
{
    self.configurationNameLabel.text = self.currentConfiguration.name;

    self.view.backgroundColor = [UIColor colorWithHexString:self.currentConfiguration.background_colour];
    self.backgroundImageView.image = nil;

    if (self.currentConfiguration.show_exit_button.boolValue)
    {
        self.exitButton.hidden = NO;
        [self.exitButton setTitleColor:[UIColor colorWithHexString:self.currentConfiguration.exit_button_fg] forState:UIControlStateNormal];
        self.exitButton.backgroundColor = [UIColor colorWithHexString:self.currentConfiguration.exit_button_bg];
        [self.exitButton setWidth:self.currentConfiguration.exit_button_w.intValue height:self.currentConfiguration.exit_button_h.intValue];
        [self.exitButton moveToX:self.currentConfiguration.exit_button_x.intValue y:self.currentConfiguration.exit_button_y.intValue];
    }
    else
    {
        self.exitButton.hidden = YES;
    }

    self.configurationNameLabel.hidden = NO;
    self.beginConfigurationButton.hidden = NO;
}

- (IBAction)beginConfiguration
{
    [self createTestLog];

    [self setupRandomGenerator];

    if (self.currentConfiguration.use_staircase_method.boolValue)
    {
        [self setupStaircase];
    }
    else
    {
        [self setupImageCollection];
    }

    [self logConfiguration];

    [self.currentConfiguration.sequence reset];

    //TestSequenceImage *image = [self.currentConfiguration.sequence nextImage:self.seedState];
    //UIImage *img = image.image;

    self.configurationNameLabel.hidden = YES;
    self.beginConfigurationButton.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:self.currentConfiguration.background_colour];
    UIImage *bgImage = self.currentConfiguration.sequence.backgroundImage;
    self.backgroundImageView.image = bgImage;

    if (self.currentConfiguration.show_exit_button.boolValue)
    {
        self.exitButton.hidden = NO;
        [self.exitButton setTitleColor:[UIColor colorWithHexString:self.currentConfiguration.exit_button_fg] forState:UIControlStateNormal];
        self.exitButton.backgroundColor = [UIColor colorWithHexString:self.currentConfiguration.exit_button_bg];
        [self.exitButton setWidth:self.currentConfiguration.exit_button_w.intValue height:self.currentConfiguration.exit_button_h.intValue];
        [self.exitButton moveToX:self.currentConfiguration.exit_button_x.intValue y:self.currentConfiguration.exit_button_y.intValue];
    }
    else
    {
        self.exitButton.hidden = YES;
    }

    [self performBlock:^
    {
        if (self.currentConfiguration.use_staircase_method.boolValue)
            [self presentNextQuestionStaircase];
        else
            [self presentNextQuestion];
    }
            afterDelay:1.0];
}

- (void)setupStaircase
{
    self.staircases = [NSMutableArray array];

    for (int i = 0; i < self.currentConfiguration.num_staircases_interleaved.intValue; i++)
    {
        Staircase *staircase = [[Staircase alloc] init];
        staircase.currentLevel = [self.currentConfiguration.staircase_start_level getNumberInGroup:i element:0];
        staircase.currentReversal = 0;
        staircase.maxReversals = [self.currentConfiguration.staircase_num_reversals getNumberInGroup:i element:0];

        staircase.deltaValues = [NSMutableArray array];
        for (int j = 0; j < staircase.maxReversals; j++)
        {
            NSNumber *number = [NSNumber numberWithInt:[self.currentConfiguration.staircase_deltas getNumberInGroup:i element:j]];
            [staircase.deltaValues addObject:number];
        }

        staircase.lastReversalType = -1;
        staircase.numHits = 0;
        staircase.numTimesCorrectToGetHarder = [self.currentConfiguration.staircase_num_correct_to_get_harder getNumberInGroup:i element:0];
        staircase.numTimesCorrect = 0;
        staircase.numTimesIncorrectToGetEasier = [self.currentConfiguration.staircase_num_incorrect_to_get_easier getNumberInGroup:i element:0];
        staircase.numTimesIncorrect = 0;
        staircase.floorCeilingHits = [self.currentConfiguration.staircase_floor_ceiling_hits getNumberInGroup:i element:0];
        staircase.minLevel = [self.currentConfiguration.staircase_min_level getNumberInGroup:i element:0];
        staircase.maxLevel = [self.currentConfiguration.staircase_max_level getNumberInGroup:i element:0];
        staircase.id = i;
        [self.staircases addObject:staircase];
    }
}

- (void)setupImageCollection
{
    self.imageCollection = [NSMutableArray array];

    for (TestSequenceFolder *folder in self.currentConfiguration.sequence.folders)
    {
        int num_questions = [self.currentConfiguration questions_in_folder:folder.name];
        for (int i = 0; i < num_questions; i++)
        {
            [self.imageCollection addObject:[folder nextImage:self.seedState]];
        }
    }

    for (int i = self.imageCollection.count - 1; i >= 0; i--)
    {
        int j = [Random randiFrom:0 to:i withState:self.seedState];

        [self.imageCollection exchangeObjectAtIndex:(NSUInteger)i withObjectAtIndex:(NSUInteger)j];
    }

}

- (void)logConfiguration
{
    NSDictionary *data = self.currentConfiguration.serialise;
    NSData *jsonified = [NSJSONSerialization dataWithJSONObject:data options:nil error:nil];
    NSString *string = [[NSString alloc] initWithData:jsonified encoding:NSASCIIStringEncoding];
    [self log:@"test_begin" info:string];
}

- (IBAction)pressExitButton:(id)sender
{
    self.questionLabel.hidden = YES;

    [self.image removeFromSuperview];

    for (TestButton *button in self.buttons)
    {
        [button removeFromSuperview];
    }

    if ((self.currentConfiguration = [self nextConfiguration]))
    {
        [self presentConfiguration];
    }
    else
    {
        [self log:@"exit_test" info:nil];

        [self uploadData];

        // Time between each question
        [UIView cancelPreviousPerformRequestsWithTarget:self];

        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)uploadData
{
    [self.APIController uploadLogs:@[self.user] progress:^(NSString *status, float _progress)
    {
        NSLog(@"Progress: %.2f", _progress);

    } success:^
    {
        NSLog(@"Upload Success");

    } failure:^
    {
        NSLog(@"Upload Failure");
    }];
}

- (void)pressTestButton:(id)sender
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    TestButton *pressedButton = sender;

    double reaction_time = [self.timer timeIntervalSinceNow] * -1000.0;
    [self log:@"reaction_time" info:@"%.2fms", reaction_time];

    [self log:@"button_press" info:@"%d (%@)", pressedButton.number, [pressedButton titleForState:UIControlStateNormal]];

    if (self.currentConfiguration.attempt_facial_recognition.boolValue)
        [self.distanceDetector takePhoto:self question:self.questionNumber];

    if (self.currentConfiguration.use_staircase_method.boolValue)
    {
        bool answerCorrect;

        //TestImageButtons in self.images
        TestImageButton *imageButton = self.image;
        if ([[imageButton.dbImage.name substringToIndex:2] isEqualToString:[NSString stringWithFormat:@"%d_", pressedButton.number]])
        {
            // go harder, got it right
            answerCorrect = YES;
            self.currentStaircase.numTimesCorrect++;
            self.currentStaircase.numTimesIncorrect = 0;
        }
        else
        {
            // go easier, got it wrong
            answerCorrect = NO;
            self.currentStaircase.numTimesIncorrect++;
            self.currentStaircase.numTimesCorrect = 0;
        }

        if (answerCorrect && self.currentStaircase.numTimesCorrect >= self.currentStaircase.numTimesCorrectToGetHarder)
        {
            if (self.currentStaircase.lastReversalType == 0) // down
            {
                [self log:@"reversal" info:nil];
                self.currentStaircase.currentReversal++;

                if (self.currentStaircase.currentReversal >= self.currentStaircase.maxReversals)
                {
                    [self.staircases removeObject:self.currentStaircase];
                    self.currentStaircase = nil;
                    [self prepareNextQuestion];
                    return;
                }
            }
            self.currentStaircase.lastReversalType = 1;

            int delta = [(NSNumber *)[self.currentStaircase.deltaValues objectAtIndex:(NSUInteger)self.currentStaircase.currentReversal] intValue];
            self.currentStaircase.currentLevel -= delta;
            self.currentStaircase.numTimesCorrect = 0;
            self.currentStaircase.numTimesIncorrect = 0;
        }
        else if (!answerCorrect && self.currentStaircase.numTimesIncorrect >= self.currentStaircase.numTimesIncorrectToGetEasier)
        {
            if (self.currentStaircase.lastReversalType == 1) // up
            {
                [self log:@"reversal" info:nil];
                self.currentStaircase.currentReversal++;

                if (self.currentStaircase.currentReversal >= self.currentStaircase.maxReversals)
                {
                    [self.staircases removeObject:self.currentStaircase];
                    self.currentStaircase = nil;
                    [self prepareNextQuestion];
                    return;
                }
            }
            self.currentStaircase.lastReversalType = 0;

            int delta = [(NSNumber *)[self.currentStaircase.deltaValues objectAtIndex:(NSUInteger)self.currentStaircase.currentReversal] intValue];
            self.currentStaircase.currentLevel += delta;
            self.currentStaircase.numTimesIncorrect = 0;
            self.currentStaircase.numTimesCorrect = 0;
        }

        //self.currentStaircase.lastAnswerCorrect = answerCorrect ? 1 : 0;

        if (self.currentStaircase.currentLevel <= self.currentStaircase.minLevel || self.currentStaircase.currentLevel >= self.currentStaircase.maxLevel)
        {
            self.currentStaircase.numHits++;

            if (self.currentStaircase.currentLevel <= self.currentStaircase.minLevel) self.currentStaircase.currentLevel = self.currentStaircase.minLevel;
            if (self.currentStaircase.currentLevel >= self.currentStaircase.maxLevel) self.currentStaircase.currentLevel = self.currentStaircase.maxLevel;
        }
        else
        {
            self.currentStaircase.numHits = 0;
        }

        if (self.currentStaircase.numHits == self.currentStaircase.floorCeilingHits)
        {
            [self.staircases removeObject:self.currentStaircase];
            self.currentStaircase = nil;
        }
    }

    [self prepareNextQuestion];
}

#pragma mark - Test preparation

- (TestImageButton *)getNextImage
{
    TestSequenceImage *image = [self.imageCollection objectAtIndex:(NSUInteger)self.questionNumber-1];

    if (!image)
        return nil;

    TestImageButton *imageButton;

    if (image.is_animated.boolValue == NO)
        imageButton = [[TestImageButton alloc] initWithImage:image.image];
    else
        imageButton = [[TestImageButton alloc] initWithAnimatedImage:image.images framerate:self.currentConfiguration.animation_frame_rate.intValue loop:self.currentConfiguration.loop_animated_images.boolValue];

    imageButton.dbImage = image;

    return imageButton;
}

- (TestImageButton *)getNextImageStaircase
{
    TestSequenceImage *image = [self.currentConfiguration.sequence nextImageFromFolder:self.currentStaircase.currentLevel withState:self.seedState];

    if (!image)
        return nil;

    TestImageButton *imageButton;

    if (image.is_animated.boolValue == NO)
        imageButton = [[TestImageButton alloc] initWithImage:image.image];
    else
        imageButton = [[TestImageButton alloc] initWithAnimatedImage:image.images framerate:self.currentConfiguration.animation_frame_rate.intValue loop:self.currentConfiguration.loop_animated_images.boolValue];

    imageButton.dbImage = image;

    return imageButton;
}

- (NSMutableArray *)getButtonSet
{
    NSMutableArray *buttons = [NSMutableArray array];
    for (int i = 0; i < self.currentConfiguration.number_of_buttons.intValue; i++)
    {
        NSString *buttonText; UIColor *bg_colour, *fg_colour; int width = 0, height = 0, x = 0, y = 0;
        if (i == 0)
        {
            buttonText = self.currentConfiguration.button_text_one;
            bg_colour = [UIColor colorWithHexString:self.currentConfiguration.button1_bg];
            fg_colour = [UIColor colorWithHexString:self.currentConfiguration.button1_fg];
            x = self.currentConfiguration.button1_x.intValue;
            y = self.currentConfiguration.button1_y.intValue;
            width = self.currentConfiguration.button1_w.intValue;
            height = self.currentConfiguration.button1_h.intValue;
        }
        else if (i == 1)
        {
            buttonText = self.currentConfiguration.button_text_two;
            bg_colour = [UIColor colorWithHexString:self.currentConfiguration.button2_bg];
            fg_colour = [UIColor colorWithHexString:self.currentConfiguration.button2_fg];
            x = self.currentConfiguration.button2_x.intValue;
            y = self.currentConfiguration.button2_y.intValue;
            width = self.currentConfiguration.button2_w.intValue;
            height = self.currentConfiguration.button2_h.intValue;
        }
        else if (i == 2)
        {
            buttonText = self.currentConfiguration.button_text_three;
            bg_colour = [UIColor colorWithHexString:self.currentConfiguration.button3_bg];
            fg_colour = [UIColor colorWithHexString:self.currentConfiguration.button3_fg];
            x = self.currentConfiguration.button3_x.intValue;
            y = self.currentConfiguration.button3_y.intValue;
            width = self.currentConfiguration.button3_w.intValue;
            height = self.currentConfiguration.button3_h.intValue;
        }
        else if (i == 3)
        {
            buttonText = self.currentConfiguration.button_text_four;
            bg_colour = [UIColor colorWithHexString:self.currentConfiguration.button4_bg];
            fg_colour = [UIColor colorWithHexString:self.currentConfiguration.button4_fg];
            x = self.currentConfiguration.button4_x.intValue;
            y = self.currentConfiguration.button4_y.intValue;
            width = self.currentConfiguration.button4_w.intValue;
            height = self.currentConfiguration.button4_h.intValue;
        }

        TestButton *button = [[TestButton alloc] initWithNumber:i+1
                                                           text:buttonText
                                                             bg:bg_colour
                                                             fg:fg_colour
                                                              x:x
                                                              y:y
                                                          width:width
                                                         height:height];

        [button addTarget:self action:@selector(pressTestButton:) forControlEvents:UIControlEventTouchUpInside];

        [buttons addObject:button];
    }

    return buttons;
}

- (void)setupRandomGenerator
{
    if (self.currentConfiguration.randomisation_use_specified_seed.boolValue)
    {
        self.seed = self.currentConfiguration.randomisation_specified_seed.unsignedIntValue;
    }
    else
    {
        self.seed = arc4random() % UINT_MAX;
    }

    self.seedState = [Random setupState:self.seed];
}

- (void)createTestLog
{
    self.log = [NSEntityDescription insertNewObjectForEntityForName:@"TestLog"
                                             inManagedObjectContext:APP_DELEGATE.managedObjectContext];
    self.log.timestamp = [NSDate date];
    self.log.user = self.user;

    [APP_DELEGATE saveContext];
}

- (NSTimeInterval)timeBetweenEachQuestion
{
    NSTimeInterval interval;
    interval = self.currentConfiguration.time_between_question_mean.floatValue;
    interval -= self.currentConfiguration.time_between_question_plusminus.floatValue;
    interval += [Random randfFrom:0.0 to:2*self.currentConfiguration.time_between_question_plusminus.floatValue withState:self.seedState];
    return fabs(interval);
}

#pragma mark - Question functions

- (void)prepareNextQuestion
{
    if (self.currentConfiguration.use_staircase_method.boolValue == NO && ! (self.questionNumber < self.currentConfiguration.countQuestions))
    {
        [self testFinished];
    }
    else
    {
        if (self.currentConfiguration.require_next.boolValue == NO)
        {
            self.questionLabel.hidden = YES;

            [self.image removeFromSuperview];

            for (TestButton *button in self.buttons)
            {
                [button removeFromSuperview];
            }
            [self.buttons removeAllObjects];

            [self performBlock:^
            {
                if (self.currentConfiguration.use_staircase_method.boolValue)
                    [self presentNextQuestionStaircase];
                else
                    [self presentNextQuestion];
            }
                  afterDelay:[self timeBetweenEachQuestion]
            ];
        }
        else
        {
            [self showNextButton];
        }
    }
}

- (void)showNextButton
{
    for (TestButton *button in self.buttons)
    {
        [button removeFromSuperview];
    }
    [self.buttons removeAllObjects];

    [self.image removeFromSuperview];

    TestButton *nextButton = [[TestButton alloc] initWithText:@"Next"];

    [nextButton moveToX:VIEW_WIDTH/2 - nextButton.width/2 y:VIEW_HEIGHT/2 - nextButton.height/2];

    [nextButton addTarget:self action:@selector(pressNextButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];

    [self.buttons addObject:nextButton];
}

- (void)pressNextButton:(id)sender
{
    [self log:@"next_button" info:nil];

     self.questionLabel.hidden = YES;

     for (TestButton *button in self.buttons)
     {
         [button removeFromSuperview];
     }

     [self.buttons removeAllObjects];

     [self performBlock:^
     {
         if (self.currentConfiguration.use_staircase_method.boolValue)
             [self presentNextQuestionStaircase];
         else
             [self presentNextQuestion];
     }
           afterDelay:[self timeBetweenEachQuestion]
     ];
}

- (void)presentNextQuestionStaircase
{
    self.questionNumber++;

    self.currentStaircase = [self.staircases getRandomObject:self.seedState];
    if (self.currentStaircase == nil)
    {
        [self testFinished];
        return;
    }

    self.questionLabel.text = [NSString stringWithFormat:@"Question %d", self.questionNumber];
    [self log:@"next_question" info:@"%d", self.questionNumber];
    [self log:@"currentStaircase" info:@"%d", self.currentStaircase.id];
    [self log:@"currentReversal" info:@"%d", self.currentStaircase.currentReversal];

    self.image = [self getNextImageStaircase];

    if (self.image == nil)
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Image not found" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
        [self log:@"error" info:@"image not found"];
        [self testFinished];
        return;
    }

    [self.view addSubview:self.image];
    [self log:@"presented_image" info:@"%@/%@", self.image.dbImage.folder.name, self.image.dbImage.name];

    self.buttons = [self getButtonSet];

    [self performBlock:^{

        for (TestButton *button in self.buttons)
        {
            [self.view addSubview:button];
        }

        NSMutableString *presentedButtons = [NSMutableString stringWithFormat:@""];
        for (TestButton *button in self.buttons)
        {
            [presentedButtons appendFormat:@"%@ ", [button titleForState:UIControlStateNormal]];
        }
        [self log:@"presented_buttons" info:@"%@", presentedButtons];

    } afterDelay:self.currentConfiguration.button_presentation_delay.floatValue];

    self.timer = [NSDate date];

    if (self.image.isAnimated)
        [self.image.animationImageView startAnimating];

    if (self.currentConfiguration.images_together_presentation_time_is_infinite.boolValue == NO)
    {
        [self performBlock:^
        {
            [self log:@"image_hidden" info:nil];
            self.image.hidden = YES;
        }
              afterDelay:self.currentConfiguration.images_together_presentation_time.floatValue
        ];
    }

    if (self.currentConfiguration.response_window_is_infinite.boolValue == NO)
    {
        [self performBlock:^
        {
            [self reponseWindowTimeout];
        }
                afterDelay:self.currentConfiguration.response_window.floatValue
        ];
    }
}

- (void)presentNextQuestion
{
    self.questionNumber++;

    self.questionLabel.text = [NSString stringWithFormat:@"Question %d/%d", self.questionNumber, self.currentConfiguration.countQuestions];
    [self log:@"next_question" info:@"%d/%d", self.questionNumber, self.currentConfiguration.countQuestions];

    self.image = [self getNextImage];

    if (self.image == nil)
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Image not found" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
        [self log:@"error" info:@"image not found"];
        [self testFinished];
        return;
    }

    [self.view addSubview:self.image];
    [self log:@"presented_image" info:@"%@/%@", self.image.dbImage.folder.name, self.image.dbImage.name];

    self.buttons = [self getButtonSet];

    [self performBlock:^{

        for (TestButton *button in self.buttons)
        {
            [self.view addSubview:button];
        }

        NSMutableString *presentedButtons = [NSMutableString stringWithFormat:@""];
        for (TestButton *button in self.buttons)
        {
            [presentedButtons appendFormat:@"%@ ", [button titleForState:UIControlStateNormal]];
        }
        [self log:@"presented_buttons" info:@"%@", presentedButtons];

    } afterDelay:self.currentConfiguration.button_presentation_delay.floatValue];

    self.timer = [NSDate date];

    if (self.image.isAnimated)
        [self.image.animationImageView startAnimating];

    if (self.currentConfiguration.images_together_presentation_time_is_infinite.boolValue == NO)
    {
        [self performBlock:^
        {
            [self log:@"image_hidden" info:nil];
            self.image.hidden = YES;
        }
              afterDelay:self.currentConfiguration.images_together_presentation_time.floatValue
        ];
    }

    if (self.currentConfiguration.response_window_is_infinite.boolValue == NO)
    {
        [self performBlock:^
        {
            [self reponseWindowTimeout];
        }
                afterDelay:self.currentConfiguration.response_window.floatValue
        ];
    }
}

- (void)reponseWindowTimeout
{
    [self log:@"response_window_timeout" info:nil];

    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    if (self.currentConfiguration.use_staircase_method.boolValue)
    {
        bool answerCorrect = NO;
        self.currentStaircase.numTimesIncorrect++;
        self.currentStaircase.numTimesCorrect = 0;

        // same as in pressTestButton
        if (answerCorrect && self.currentStaircase.numTimesCorrect >= self.currentStaircase.numTimesCorrectToGetHarder)
        {
            if (self.currentStaircase.lastReversalType == 0) // down
            {
                [self log:@"reversal" info:nil];
                self.currentStaircase.currentReversal++;

                if (self.currentStaircase.currentReversal >= self.currentStaircase.maxReversals)
                {
                    [self.staircases removeObject:self.currentStaircase];
                    self.currentStaircase = nil;
                    [self prepareNextQuestion];
                    return;
                }
            }
            self.currentStaircase.lastReversalType = 1;

            int delta = [(NSNumber *)[self.currentStaircase.deltaValues objectAtIndex:(NSUInteger)self.currentStaircase.currentReversal] intValue];
            self.currentStaircase.currentLevel -= delta;
            self.currentStaircase.numTimesCorrect = 0;
            self.currentStaircase.numTimesIncorrect = 0;
        }
        else if (!answerCorrect && self.currentStaircase.numTimesIncorrect >= self.currentStaircase.numTimesIncorrectToGetEasier)
        {
            if (self.currentStaircase.lastReversalType == 1) // up
            {
                [self log:@"reversal" info:nil];
                self.currentStaircase.currentReversal++;

                if (self.currentStaircase.currentReversal >= self.currentStaircase.maxReversals)
                {
                    [self.staircases removeObject:self.currentStaircase];
                    self.currentStaircase = nil;
                    [self prepareNextQuestion];
                    return;
                }
            }
            self.currentStaircase.lastReversalType = 0;

            int delta = [(NSNumber *)[self.currentStaircase.deltaValues objectAtIndex:(NSUInteger)self.currentStaircase.currentReversal] intValue];
            self.currentStaircase.currentLevel += delta;
            self.currentStaircase.numTimesIncorrect = 0;
            self.currentStaircase.numTimesCorrect = 0;
        }

        //self.currentStaircase.lastAnswerCorrect = answerCorrect ? 1 : 0;

        if (self.currentStaircase.currentLevel <= self.currentStaircase.minLevel || self.currentStaircase.currentLevel >= self.currentStaircase.maxLevel)
        {
            self.currentStaircase.numHits++;

            if (self.currentStaircase.currentLevel <= self.currentStaircase.minLevel) self.currentStaircase.currentLevel = self.currentStaircase.minLevel;
            if (self.currentStaircase.currentLevel >= self.currentStaircase.maxLevel) self.currentStaircase.currentLevel = self.currentStaircase.maxLevel;
        }
        else
        {
            self.currentStaircase.numHits = 0;
        }

        if (self.currentStaircase.numHits == self.currentStaircase.floorCeilingHits)
        {
            [self.staircases removeObject:self.currentStaircase];
            self.currentStaircase = nil;
        }
    }

    [self prepareNextQuestion];
}

- (void)testFinished
{
    [self log:@"test_finished" info:nil];

    [self pressExitButton:nil];
}

#pragma mark - Logging functions

- (void)log:(NSString *)type info:(NSString *)format, ...
{
    NSString *info;

    if (format)
    {
        va_list argList;
        va_start(argList, format);
        info = [[NSString alloc] initWithFormat:format arguments:argList];
        NSLog(@"%@, %@", type, info);
        va_end(argList);
    }
    else
    {
        NSLog(@"%@", type);
    }

    if (self.log)
    {
        TestLogItem *logItem = [NSEntityDescription insertNewObjectForEntityForName:@"TestLogItem" inManagedObjectContext:self.log.managedObjectContext];
        logItem.type = type;
        logItem.info = info;
        logItem.timestamp = [NSDate date];
        logItem.log = self.log;

        [APP_DELEGATE saveContext];
    }
}

#pragma mark - Cleanup

- (void)viewDidUnload
{
    free(self.seedState);

    [self.distanceDetector done];

    [self setBeginTestButton:nil];
    [self setQuestionLabel:nil];
    [self setConfigurationNameLabel:nil];
    [self setBeginConfigurationButton:nil];
    [self setExitButton:nil];
    [super viewDidUnload];
}

- (void)distanceDetectionPerformed:(NSString *)string
{
    [self log:@"distance_detection" info:string];
}

@end
