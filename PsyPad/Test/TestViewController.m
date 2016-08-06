//
//  TestViewController.m
//  PsyPad
//
//  Created by David Lawson on 5/12/12.
//

#import "TestViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <AVFoundation/AVFoundation.h>

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
#import "RootEntity.h"

#import "UIColor+Hex.h"
#import "DistanceDetector.h"
#import "DatabaseManager.h"

#import "NSObject+DelayBlock.h"
#import "DemoViewController.h"

// Shortcuts for the view size
#define VIEW_HEIGHT self.view.bounds.size.height
#define VIEW_WIDTH self.view.bounds.size.width

@interface TestViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *exitButtonTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *exitButtonHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *exitButtonWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *exitButtonLeft;

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

    //todo currentConfiguration is nil here?
    if (self.currentConfiguration.show_exit_buttonValue)
    {
        self.exitButton.hidden = NO;
        [self.exitButton setTitleColor:[UIColor colorWithHexString:self.firstConfiguration.exit_button_fg] forState:UIControlStateNormal];
        self.exitButton.backgroundColor = [UIColor colorWithHexString:self.firstConfiguration.exit_button_bg];
        self.exitButtonWidth.constant = self.firstConfiguration.exit_button_w.intValue;
        self.exitButtonHeight.constant = self.firstConfiguration.exit_button_h.intValue;
        self.exitButtonTop.constant = self.firstConfiguration.exit_button_y.intValue;
        self.exitButtonLeft.constant = self.firstConfiguration.exit_button_x.intValue;
    }
    else
    {
        self.exitButton.hidden = YES;
    }

    self.distanceDetector = [[DistanceDetector alloc] init];

    [[UIScreen mainScreen] setBrightness:1.0];
    
    self.currentConfiguration = [self nextConfiguration];
    [self presentConfiguration];
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

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - User interaction

- (TestConfiguration *)nextConfiguration
{
    if (!self.currentConfiguration && self.configurations.count > 0)
    {
        self.questionNumber = 0;
        return [self.configurations objectAtIndex:0];
    }
    else if (self.currentConfiguration)
    {
        long curIndex = [self.configurations indexOfObject:self.currentConfiguration];
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
    self.configurationNameLabel.text = self.currentConfiguration.title;

    self.view.backgroundColor = [UIColor colorWithHexString:self.currentConfiguration.background_colour];
        UIImage *titleImage = self.currentConfiguration.sequence.titleImage;
    self.backgroundImageView.image = titleImage;

    if (self.currentConfiguration.show_exit_buttonValue)
    {
        self.exitButton.hidden = NO;
        [self.exitButton setTitleColor:[UIColor colorWithHexString:self.currentConfiguration.exit_button_fg] forState:UIControlStateNormal];
        self.exitButton.backgroundColor = [UIColor colorWithHexString:self.currentConfiguration.exit_button_bg];
        self.exitButtonWidth.constant = self.currentConfiguration.exit_button_w.intValue;
        self.exitButtonHeight.constant = self.currentConfiguration.exit_button_h.intValue;
        self.exitButtonTop.constant = self.currentConfiguration.exit_button_y.intValue;
        self.exitButtonLeft.constant = self.currentConfiguration.exit_button_x.intValue;
    }
    else
    {
        self.exitButton.hidden = YES;
    }

    self.configurationNameLabel.hidden = NO;
    self.beginConfigurationButton.hidden = NO;
    
    self.correctAudioPlayer = [self loadAudio:self.currentConfiguration.sequence.correctWAVData description:@"correct button"];
    self.incorrectAudioPlayer = [self loadAudio:self.currentConfiguration.sequence.incorrectWAVData description:@"incorrect button"];
    self.onAudioPlayer = [self loadAudio:self.currentConfiguration.sequence.onWAVData description:@"on"];
    self.offAudioPlayer = [self loadAudio:self.currentConfiguration.sequence.offWAVData description:@"off"];
    self.timeoutAudioPlayer = [self loadAudio:self.currentConfiguration.sequence.timeoutWAVData description:@"timeout"];
}

- (AVAudioPlayer *)loadAudio:(NSData *)data description:(NSString *)description
{
    if (!data) return nil;
    
    NSError *error = nil;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:data fileTypeHint:AVFileTypeWAVE error:&error];
    if (error)
    {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:[NSString stringWithFormat:@"Failed to load '%@' audio file", description]
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];
        return nil;
    }
    
    [player prepareToPlay];
    player.volume = 0;
    [player play];
    
    return player;
}

- (void)playAudio:(AVAudioPlayer *)player
{
    if (!player) return;
    
    player.currentTime = 0;
    player.volume = 1;
    [player play];
}

- (IBAction)beginConfiguration
{
    [self createTestLog];

    [self setupRandomGenerator];

    if (self.currentConfiguration.use_staircase_methodValue)
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
    
    self.ignoredCount = 0;

    if (self.currentConfiguration.show_exit_buttonValue)
    {
        self.exitButton.hidden = NO;
        [self.exitButton setTitleColor:[UIColor colorWithHexString:self.currentConfiguration.exit_button_fg] forState:UIControlStateNormal];
        self.exitButton.backgroundColor = [UIColor colorWithHexString:self.currentConfiguration.exit_button_bg];
        self.exitButtonWidth.constant = self.currentConfiguration.exit_button_w.intValue;
        self.exitButtonHeight.constant = self.currentConfiguration.exit_button_h.intValue;
        self.exitButtonTop.constant = self.currentConfiguration.exit_button_y.intValue;
        self.exitButtonLeft.constant = self.currentConfiguration.exit_button_x.intValue;
    }
    else
    {
        self.exitButton.hidden = YES;
    }

    [self performBlock:^
    {
        if (self.currentConfiguration.use_staircase_methodValue)
            [self presentNextQuestionStaircase];
        else
            [self presentNextQuestion];
    }
            afterDelay:1.0];
}

- (void)setupStaircase
{
    self.staircases = [NSMutableArray array];

    for (int i = 0; i < self.currentConfiguration.number_of_staircasesValue; i++)
    {
        Staircase *staircase = [[Staircase alloc] init];
        staircase.currentLevel = [self.currentConfiguration.start_level getNumberInGroup:i element:0];
        staircase.currentReversal = 0;
        staircase.maxReversals = [self.currentConfiguration.number_of_reversals getNumberInGroup:i element:0];

        staircase.deltaValues = [NSMutableArray array];
        for (int j = 0; j < staircase.maxReversals; j++)
        {
            NSNumber *number = [NSNumber numberWithInt:[self.currentConfiguration.delta_values getNumberInGroup:i element:j]];
            [staircase.deltaValues addObject:number];
        }

        staircase.lastReversalType = -1;
        staircase.numHitsFloor = 0;
        staircase.numHitsCeiling = 0;
        staircase.numTimesCorrectToGetHarder = [self.currentConfiguration.num_correct_to_get_harder getNumberInGroup:i element:0];
        staircase.numTimesCorrect = 0;
        staircase.numTimesIncorrectToGetEasier = [self.currentConfiguration.num_wrong_to_get_easier getNumberInGroup:i element:0];
        staircase.numTimesIncorrect = 0;
        staircase.floorCeilingHits = [self.currentConfiguration.hits_to_finish getNumberInGroup:i element:0];
        staircase.minLevel = [self.currentConfiguration.minimum_level getNumberInGroup:i element:0];
        staircase.maxLevel = [self.currentConfiguration.maximum_level getNumberInGroup:i element:0];
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

    for (int i = (int)self.imageCollection.count - 1; i >= 0; i--)
    {
        int j = [Random randiFrom:0 to:i withState:self.seedState];

        [self.imageCollection exchangeObjectAtIndex:(NSUInteger)i withObjectAtIndex:(NSUInteger)j];
    }

}

- (void)logConfiguration
{
    NSDictionary *data = self.currentConfiguration.serialise;
    NSData *jsonified = [NSJSONSerialization dataWithJSONObject:data options:nil error:nil];
    NSString *string = [[NSString alloc] initWithData:jsonified encoding:NSUTF8StringEncoding];
    [self log:@"test_begin" info:string];
}

- (IBAction)pressExitButton:(id)sender
{
    // Time between each question
    [UIView cancelPreviousPerformRequestsWithTarget:self];
    
    self.questionLabel.hidden = YES;

    [self.image removeFromSuperview];

    for (TestButton *button in self.buttons)
    {
        [button removeFromSuperview];
    }

    if ((self.currentConfiguration = [self nextConfiguration]))
    {
        [self log:@"pressed_exit_button" info:nil];
        
        [self presentConfiguration];
    }
    else
    {
        [self log:@"exit_test" info:nil];

        [self uploadData];

        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        
        TestLog *log = self.log;
        UIViewController *parentVC = [(UINavigationController *)self.presentingViewController topViewController];
        [self dismissViewControllerAnimated:YES completion:^
        {
            if ([parentVC isKindOfClass:[DemoViewController class]])
            {
                [parentVC performSegueWithIdentifier:@"ShowLog" sender:log];
            }
        }];
    }
}

- (void)uploadData
{
    [[ServerManager sharedManager] uploadLogsWithProgress:^(NSString *status, float _progress)
    {
        NSLog(@"Uploading logs, progress: %.2f", _progress);

    } success:^
    {
        NSLog(@"Upload Success");

    } failure:^(NSString *error)
    {
        NSLog(@"Upload Failure: %@", error);
    }];
}

- (void)pressTestButton:(id)sender
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    TestButton *pressedButton = sender;

    if (!self.currentConfiguration.enable_secondary_stimuliValue)
    {
        double reaction_time = [self.timer timeIntervalSinceNow] * -1000.0;
        [self log:@"reaction_time" info:@"%.2fms", reaction_time];
    }

    [self log:@"button_press" info:@"%d (%@)", pressedButton.number, [pressedButton titleForState:UIControlStateNormal]];

    if (self.currentConfiguration.attempt_facial_recognitionValue)
        [self.distanceDetector takePhoto:self question:self.questionNumber];
    
    if (self.currentConfiguration.enable_secondary_stimuliValue && self.overlayIndex != self.secondaryPressedIndex)
    {
        self.ignoredCount++;
        [self log:@"ignored_response" info:@"%d", self.ignoredCount];
        
        if (!self.currentConfiguration.use_staircase_methodValue)
        {
            // move this question to the end
            TestSequenceImage *current = [self.imageCollection objectAtIndex:(NSUInteger)self.questionNumber-1];
            [self.imageCollection removeObjectAtIndex:self.questionNumber - 1];
            [self.imageCollection addObject:current];
        }
        
        self.questionNumber--;
        [self prepareNextQuestion];
        
        return;
    }

    if (self.currentConfiguration.use_staircase_methodValue)
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
            
            [self playAudio:self.correctAudioPlayer];
            
            [self log:@"answer_correct" info:nil];
        }
        else
        {
            // go easier, got it wrong
            answerCorrect = NO;
            self.currentStaircase.numTimesIncorrect++;
            self.currentStaircase.numTimesCorrect = 0;
            
            [self playAudio:self.incorrectAudioPlayer];
            
            [self log:@"answer_incorrect" info:nil];
        }
        
        if (answerCorrect && self.currentStaircase.currentLevel == self.currentStaircase.minLevel)
        {
            self.currentStaircase.numHitsFloor++;
            
            [self log:@"hit_floor" info:nil];
        }
        else if (!answerCorrect && self.currentStaircase.currentLevel == self.currentStaircase.maxLevel)
        {
            self.currentStaircase.numHitsCeiling++;
            
            [self log:@"hit_ceiling" info:nil];
        }
        
        if (self.currentStaircase.numHitsFloor == self.currentStaircase.floorCeilingHits
            || self.currentStaircase.numHitsCeiling == self.currentStaircase.floorCeilingHits)
        {
            [self log:@"reached_maximum_floor_ceiling_hits" info:nil];
            
            [self.staircases removeObject:self.currentStaircase];
            self.currentStaircase = nil;
            [self prepareNextQuestion];
            return;
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

        if (self.currentStaircase.currentLevel < self.currentStaircase.minLevel)
        {
            self.currentStaircase.currentLevel = self.currentStaircase.minLevel;
        }
        else if (self.currentStaircase.currentLevel > self.currentStaircase.maxLevel)
        {
            self.currentStaircase.currentLevel = self.currentStaircase.maxLevel;
        }
    }
    else
    {
        TestImageButton *imageButton = self.image;
        if ([[imageButton.dbImage.name substringToIndex:2] isEqualToString:[NSString stringWithFormat:@"%d_", pressedButton.number]])
        {
            [self playAudio:self.correctAudioPlayer];
            
            [self log:@"answer_correct" info:nil];
        }
        else
        {
            [self playAudio:self.incorrectAudioPlayer];
            
            [self log:@"answer_incorrect" info:nil];
        }
    }

    [self prepareNextQuestion];
}

- (void)pressSecondaryTestButton:(id)sender
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    TestButton *pressedButton = sender;
    
    [self log:@"secondary_button_press" info:@"%d (%@)", pressedButton.number, [pressedButton titleForState:UIControlStateNormal]];
    self.secondaryPressedIndex = pressedButton.number - 1;
    
    [self presentSecondSetOfButtons];
}

#pragma mark - Test preparation

- (TestImageButton *)getNextImage
{
    if (self.questionNumber > self.imageCollection.count)
        return nil;
    
    TestSequenceImage *image = [self.imageCollection objectAtIndex:(NSUInteger)self.questionNumber-1];

    if (!image)
        return nil;

    TestImageButton *imageButton;

    if (image.is_animatedValue == NO)
        imageButton = [[TestImageButton alloc] initWithImage:image.image];
    else
        imageButton = [[TestImageButton alloc] initWithAnimatedImage:image.images framerate:self.currentConfiguration.animation_frame_rateValue loop:self.currentConfiguration.loop_animationsValue];

    imageButton.dbImage = image;

    return imageButton;
}

- (TestImageButton *)getNextImageStaircase
{
    TestSequenceImage *image = [self.currentConfiguration.sequence nextImageFromFolder:self.currentStaircase.currentLevel withState:self.seedState];

    if (!image)
        return nil;

    TestImageButton *imageButton;

    if (image.is_animatedValue == NO)
        imageButton = [[TestImageButton alloc] initWithImage:image.image];
    else
        imageButton = [[TestImageButton alloc] initWithAnimatedImage:image.images framerate:self.currentConfiguration.animation_frame_rateValue loop:self.currentConfiguration.loop_animationsValue];

    imageButton.dbImage = image;

    return imageButton;
}

- (void)showSecondaryStimuli
{
    if (self.currentConfiguration.enable_secondary_stimuliValue)
    {
        self.overlayIndex = arc4random_uniform(self.currentConfiguration.num_secondary_buttonsValue);
        switch (self.overlayIndex)
        {
            case 0:
                self.overlayImageView.image = self.currentConfiguration.sequence.secondaryImage1;
                break;
                
            case 1:
                self.overlayImageView.image = self.currentConfiguration.sequence.secondaryImage2;
                break;
                
            case 2:
                self.overlayImageView.image = self.currentConfiguration.sequence.secondaryImage3;
                break;
                
            case 3:
                self.overlayImageView.image = self.currentConfiguration.sequence.secondaryImage4;
                break;
        }
        [self.view bringSubviewToFront:self.overlayImageView];
        [self log:@"presented_secondary_image" info:@"%d", self.overlayIndex + 1];
    }
}

- (void)hideSecondaryStimuli
{
    self.overlayImageView.image = nil;
}

- (NSMutableArray *)getButtonSet
{
    NSMutableArray *buttons = [NSMutableArray array];
    for (int i = 0; i < self.currentConfiguration.num_buttonsValue; i++)
    {
        NSString *buttonText; UIColor *bg_colour, *fg_colour; int width = 0, height = 0, x = 0, y = 0; UIImage *img;
        if (i == 0)
        {
            buttonText = self.currentConfiguration.button1_text;
            bg_colour = [UIColor colorWithHexString:self.currentConfiguration.button1_bg];
            fg_colour = [UIColor colorWithHexString:self.currentConfiguration.button1_fg];
            x = self.currentConfiguration.button1_x.intValue;
            y = self.currentConfiguration.button1_y.intValue;
            width = self.currentConfiguration.button1_w.intValue;
            height = self.currentConfiguration.button1_h.intValue;
            img = self.currentConfiguration.sequence.button1Image;
        }
        else if (i == 1)
        {
            buttonText = self.currentConfiguration.button2_text;
            bg_colour = [UIColor colorWithHexString:self.currentConfiguration.button2_bg];
            fg_colour = [UIColor colorWithHexString:self.currentConfiguration.button2_fg];
            x = self.currentConfiguration.button2_x.intValue;
            y = self.currentConfiguration.button2_y.intValue;
            width = self.currentConfiguration.button2_w.intValue;
            height = self.currentConfiguration.button2_h.intValue;
            img = self.currentConfiguration.sequence.button2Image;
        }
        else if (i == 2)
        {
            buttonText = self.currentConfiguration.button3_text;
            bg_colour = [UIColor colorWithHexString:self.currentConfiguration.button3_bg];
            fg_colour = [UIColor colorWithHexString:self.currentConfiguration.button3_fg];
            x = self.currentConfiguration.button3_x.intValue;
            y = self.currentConfiguration.button3_y.intValue;
            width = self.currentConfiguration.button3_w.intValue;
            height = self.currentConfiguration.button3_h.intValue;
            img = self.currentConfiguration.sequence.button3Image;
        }
        else if (i == 3)
        {
            buttonText = self.currentConfiguration.button4_text;
            bg_colour = [UIColor colorWithHexString:self.currentConfiguration.button4_bg];
            fg_colour = [UIColor colorWithHexString:self.currentConfiguration.button4_fg];
            x = self.currentConfiguration.button4_x.intValue;
            y = self.currentConfiguration.button4_y.intValue;
            width = self.currentConfiguration.button4_w.intValue;
            height = self.currentConfiguration.button4_h.intValue;
            img = self.currentConfiguration.sequence.button4Image;
        }

        TestButton *button = [[TestButton alloc] initWithNumber:i+1
                                                           text:buttonText
                                                             bg:bg_colour
                                                             fg:fg_colour
                                                              x:x
                                                              y:y
                                                          width:width
                                                         height:height
                                                            img:img];

        [button addTarget:self action:@selector(pressTestButton:) forControlEvents:UIControlEventTouchUpInside];

        [buttons addObject:button];
    }

    return buttons;
}

- (NSMutableArray *)getSecondaryButtonSet
{
    NSMutableArray *buttons = [NSMutableArray array];
    for (int i = 0; i < self.currentConfiguration.num_secondary_buttonsValue; i++)
    {
        NSString *buttonText; UIColor *bg_colour, *fg_colour; int width = 0, height = 0, x = 0, y = 0; UIImage *img;
        if (i == 0)
        {
            buttonText = self.currentConfiguration.secondary_button1_text;
            bg_colour = [UIColor colorWithHexString:self.currentConfiguration.secondary_button1_bg];
            fg_colour = [UIColor colorWithHexString:self.currentConfiguration.secondary_button1_fg];
            x = self.currentConfiguration.secondary_button1_x.intValue;
            y = self.currentConfiguration.secondary_button1_y.intValue;
            width = self.currentConfiguration.secondary_button1_w.intValue;
            height = self.currentConfiguration.secondary_button1_h.intValue;
            img = self.currentConfiguration.sequence.secondaryButton1Image;
        }
        else if (i == 1)
        {
            buttonText = self.currentConfiguration.secondary_button2_text;
            bg_colour = [UIColor colorWithHexString:self.currentConfiguration.secondary_button2_bg];
            fg_colour = [UIColor colorWithHexString:self.currentConfiguration.secondary_button2_fg];
            x = self.currentConfiguration.secondary_button2_x.intValue;
            y = self.currentConfiguration.secondary_button2_y.intValue;
            width = self.currentConfiguration.secondary_button2_w.intValue;
            height = self.currentConfiguration.secondary_button2_h.intValue;
            img = self.currentConfiguration.sequence.secondaryButton2Image;
        }
        else if (i == 2)
        {
            buttonText = self.currentConfiguration.secondary_button3_text;
            bg_colour = [UIColor colorWithHexString:self.currentConfiguration.secondary_button3_bg];
            fg_colour = [UIColor colorWithHexString:self.currentConfiguration.secondary_button3_fg];
            x = self.currentConfiguration.secondary_button3_x.intValue;
            y = self.currentConfiguration.secondary_button3_y.intValue;
            width = self.currentConfiguration.secondary_button3_w.intValue;
            height = self.currentConfiguration.secondary_button3_h.intValue;
            img = self.currentConfiguration.sequence.secondaryButton3Image;
        }
        else if (i == 3)
        {
            buttonText = self.currentConfiguration.secondary_button4_text;
            bg_colour = [UIColor colorWithHexString:self.currentConfiguration.secondary_button4_bg];
            fg_colour = [UIColor colorWithHexString:self.currentConfiguration.secondary_button4_fg];
            x = self.currentConfiguration.secondary_button4_x.intValue;
            y = self.currentConfiguration.secondary_button4_y.intValue;
            width = self.currentConfiguration.secondary_button4_w.intValue;
            height = self.currentConfiguration.secondary_button4_h.intValue;
            img = self.currentConfiguration.sequence.secondaryButton4Image;
        }
        
        TestButton *button = [[TestButton alloc] initWithNumber:i+1
                                                           text:buttonText
                                                             bg:bg_colour
                                                             fg:fg_colour
                                                              x:x
                                                              y:y
                                                          width:width
                                                         height:height
                                                            img:img];
        
        [button addTarget:self action:@selector(pressSecondaryTestButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttons addObject:button];
    }
    
    return buttons;
}

- (void)setupRandomGenerator
{
    if (self.currentConfiguration.use_specified_seedValue)
    {
        self.seed = self.currentConfiguration.specified_seedValue;
    }
    else
    {
        self.seed = arc4random() % UINT_MAX;
    }

    self.seedState = [Random setupState:self.seed];
}

- (void)createTestLog
{
    self.log = [TestLog MR_createEntity];
    self.log.timestamp = [NSDate date];
    self.log.user = self.user;

    [DatabaseManager save];
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
    if (self.currentConfiguration.use_staircase_methodValue == NO && ! (self.questionNumber < self.currentConfiguration.countQuestions))
    {
        [self testFinished];
    }
    else
    {
        if (self.currentConfiguration.require_nextValue == NO)
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
                if (self.currentConfiguration.use_staircase_methodValue)
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
         if (self.currentConfiguration.use_staircase_methodValue)
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
    [self playAudio:self.onAudioPlayer];
    [self showSecondaryStimuli];
    
    [self.view bringSubviewToFront:self.exitButton];

    if (!self.currentConfiguration.enable_secondary_stimuliValue)
    {
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
    }

    self.timer = [NSDate date];

    if (self.image.isAnimated)
        [self.image.animationImageView startAnimating];

    if (self.currentConfiguration.infinite_presentation_timeValue == NO)
    {
        [self performBlock:^
        {
            [self log:@"image_hidden" info:nil];
            self.image.hidden = YES;
            [self playAudio:self.offAudioPlayer];
            [self hideSecondaryStimuli];
            
            if (self.currentConfiguration.enable_secondary_stimuliValue)
            {
                [self performBlock:^{
                    
                    [self presentFirstSetOfButtons];
                    
                } afterDelay:0.5f];
            }
        }
              afterDelay:self.currentConfiguration.finite_presentation_timeValue
        ];
    }

    if (self.currentConfiguration.infinite_response_windowValue == NO)
    {
        [self performBlock:^
        {
            [self reponseWindowTimeout];
        }
                afterDelay:self.currentConfiguration.finite_response_windowValue
        ];
    }
}

- (void)presentFirstSetOfButtons
{
    self.buttons = [self getSecondaryButtonSet];
    
    for (TestButton *button in self.buttons)
    {
        [self.view addSubview:button];
    }
    
    NSMutableString *presentedButtons = [NSMutableString stringWithFormat:@""];
    for (TestButton *button in self.buttons)
    {
        [presentedButtons appendFormat:@"%@ ", [button titleForState:UIControlStateNormal]];
    }
    [self log:@"presented_secondary_buttons" info:@"%@", presentedButtons];
}

- (void)presentSecondSetOfButtons
{
    for (TestButton *button in self.buttons)
    {
        [button removeFromSuperview];
    }
    
    self.buttons = [self getButtonSet];
    
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
    [self playAudio:self.onAudioPlayer];
    [self showSecondaryStimuli];
    
    [self.view bringSubviewToFront:self.exitButton];

    if (!self.currentConfiguration.enable_secondary_stimuliValue)
    {
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
    }

    self.timer = [NSDate date];

    if (self.image.isAnimated)
        [self.image.animationImageView startAnimating];

    if (self.currentConfiguration.infinite_presentation_timeValue == NO)
    {
        [self performBlock:^
        {
            [self log:@"image_hidden" info:nil];
            self.image.hidden = YES;
            [self playAudio:self.offAudioPlayer];
            [self hideSecondaryStimuli];
            
            if (self.currentConfiguration.enable_secondary_stimuliValue)
            {
                [self performBlock:^{
                    
                    [self presentFirstSetOfButtons];
                    
                } afterDelay:0.5f];
            }
        }
              afterDelay:self.currentConfiguration.finite_presentation_timeValue
        ];
    }

    if (self.currentConfiguration.infinite_response_windowValue == NO)
    {
        [self performBlock:^
        {
            [self reponseWindowTimeout];
        }
                afterDelay:self.currentConfiguration.finite_response_windowValue
        ];
    }
}

- (void)reponseWindowTimeout
{
    [self log:@"response_window_timeout" info:nil];

    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self playAudio:self.timeoutAudioPlayer];

    if (self.currentConfiguration.use_staircase_methodValue)
    {
        bool answerCorrect = NO;
        self.currentStaircase.numTimesIncorrect++;
        self.currentStaircase.numTimesCorrect = 0;

        if (self.currentStaircase.currentLevel == self.currentStaircase.maxLevel)
        {
            self.currentStaircase.numHitsCeiling++;
        }
        
        if (self.currentStaircase.numHitsCeiling == self.currentStaircase.floorCeilingHits)
        {
            [self.staircases removeObject:self.currentStaircase];
            self.currentStaircase = nil;
            [self prepareNextQuestion];
            return;
        }
        
        // same as in pressTestButton
        if (self.currentStaircase.numTimesIncorrect >= self.currentStaircase.numTimesIncorrectToGetEasier)
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

        if (self.currentStaircase.currentLevel < self.currentStaircase.minLevel)
        {
            self.currentStaircase.currentLevel = self.currentStaircase.minLevel;
        }
        else if (self.currentStaircase.currentLevel > self.currentStaircase.maxLevel)
        {
            self.currentStaircase.currentLevel = self.currentStaircase.maxLevel;
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

        [DatabaseManager save];
    }
}

#pragma mark - Cleanup

- (void)viewDidUnload
{
    free(self.seedState);

    [self.distanceDetector done];

    [super viewDidUnload];
}

- (void)distanceDetectionPerformed:(NSString *)string
{
    [self log:@"distance_detection" info:string];
}

@end
