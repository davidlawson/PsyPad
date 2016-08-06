//
//  TestViewController.h
//  PsyPad
//
//  Created by David Lawson on 5/12/12.
//

#import <UIKit/UIKit.h>

@class User, TestLog, TestConfiguration, TestImageButton, DistanceDetector;
@class Staircase;
@class MBProgressHUD;
@class AVAudioPlayer;

@interface TestViewController : UIViewController

@property (nonatomic, strong) AVAudioPlayer *correctAudioPlayer,
                                            *incorrectAudioPlayer,
                                            *onAudioPlayer,
                                            *offAudioPlayer,
                                            *timeoutAudioPlayer;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *configurationNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *beginConfigurationButton;
@property (weak, nonatomic) IBOutlet UIButton *exitButton;

@property (strong, nonatomic) TestLog *log;
@property (strong, nonatomic) NSArray *configurations;
@property (strong, nonatomic) TestConfiguration *currentConfiguration;

@property (nonatomic) unsigned int seed;
@property (nonatomic) unsigned short *seedState;

@property (strong, nonatomic) NSMutableArray *imageCollection;

@property (strong, nonatomic) TestImageButton *image;
@property (strong, nonatomic) NSMutableArray *buttons;

@property (nonatomic) int questionNumber;
@property (nonatomic, strong) TestImageButton *currentImage;

@property (nonatomic, strong) User *user;

@property (strong, nonatomic) NSDate *timer;

@property (strong, nonatomic) DistanceDetector *distanceDetector;

@property (strong, nonatomic) NSMutableArray *staircases;
@property (weak, nonatomic) Staircase *currentStaircase;

@property (strong, nonatomic) MBProgressHUD *hud;

@property (weak, nonatomic) IBOutlet UIImageView *overlayImageView;
@property (nonatomic) int overlayIndex;
@property (nonatomic) int secondaryPressedIndex;
@property (nonatomic) int ignoredCount;

- (IBAction)beginConfiguration;
- (IBAction)pressExitButton:(id)sender;

- (void)distanceDetectionPerformed:(NSString *)string;
@end
