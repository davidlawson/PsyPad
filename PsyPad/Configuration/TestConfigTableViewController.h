//
//  TestConfigTableViewController.h
//  PsyPad
//
//  Created by David Lawson on 2/12/12.
//

#import <UIKit/UIKit.h>

@class TestConfiguration;
@class SelectConfigurationTableViewController;

@interface TestConfigTableViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) SelectConfigurationTableViewController *parentController;

@property (strong, nonatomic) TestConfiguration *configuration;

@property (weak, nonatomic) IBOutlet UITextField *configurationName;

@property (weak, nonatomic) IBOutlet UISwitch *enabledSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *mondaySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *tuesdaySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *wednesdaySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *thursdaySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *fridaySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *saturdaySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *sundaySwitch;

@property (weak, nonatomic) IBOutlet UISwitch *practiceConfigurationSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *loopAnimatedImages;
@property (weak, nonatomic) IBOutlet UITextField *animationFrameRate;

@property (weak, nonatomic) IBOutlet UISwitch *useStaircaseMethodSwitch;
@property (weak, nonatomic) IBOutlet UITextField *numberOfStaircases;
@property (weak, nonatomic) IBOutlet UITextField *startLevel;
@property (weak, nonatomic) IBOutlet UITextField *numberOfReversals;
@property (weak, nonatomic) IBOutlet UITextField *hitsToFinish;
@property (weak, nonatomic) IBOutlet UITextField *minimumLevel;
@property (weak, nonatomic) IBOutlet UITextField *maximumLevel;
@property (weak, nonatomic) IBOutlet UITextField *deltaValues;
@property (weak, nonatomic) IBOutlet UITextField *numWrongToGetEasier;
@property (weak, nonatomic) IBOutlet UITextField *numCorrectToGetHarder;

@property (weak, nonatomic) IBOutlet UITextField *questionsPerFolder;

@property (weak, nonatomic) IBOutlet UITextField *backgroundColour;

@property (weak, nonatomic) IBOutlet UISwitch *showExitButton;
@property (weak, nonatomic) IBOutlet UITextField *exitButtonX;
@property (weak, nonatomic) IBOutlet UITextField *exitButtonY;
@property (weak, nonatomic) IBOutlet UITextField *exitButtonW;
@property (weak, nonatomic) IBOutlet UITextField *exitButtonH;
@property (weak, nonatomic) IBOutlet UITextField *exitButtonBG;
@property (weak, nonatomic) IBOutlet UITextField *exitButtonFG;

@property (weak, nonatomic) IBOutlet UITextField *button1Text;
@property (weak, nonatomic) IBOutlet UITextField *button2Text;
@property (weak, nonatomic) IBOutlet UITextField *button3Text;
@property (weak, nonatomic) IBOutlet UITextField *button4Text;

@property (weak, nonatomic) IBOutlet UILabel *buttonPresentationDelayLabel;
@property (weak, nonatomic) IBOutlet UISlider *buttonPresentationDelay;

@property (weak, nonatomic) IBOutlet UITextField *button1X;
@property (weak, nonatomic) IBOutlet UITextField *button1Y;
@property (weak, nonatomic) IBOutlet UITextField *button1W;
@property (weak, nonatomic) IBOutlet UITextField *button1H;
@property (weak, nonatomic) IBOutlet UITextField *button2X;
@property (weak, nonatomic) IBOutlet UITextField *button2Y;
@property (weak, nonatomic) IBOutlet UITextField *button2W;
@property (weak, nonatomic) IBOutlet UITextField *button2H;

@property (weak, nonatomic) IBOutlet UITextField *button3X;
@property (weak, nonatomic) IBOutlet UITextField *button3Y;
@property (weak, nonatomic) IBOutlet UITextField *button3W;
@property (weak, nonatomic) IBOutlet UITextField *button3H;
@property (weak, nonatomic) IBOutlet UITextField *button4X;
@property (weak, nonatomic) IBOutlet UITextField *button4Y;
@property (weak, nonatomic) IBOutlet UITextField *button4W;
@property (weak, nonatomic) IBOutlet UITextField *button4H;

@property (weak, nonatomic) IBOutlet UITextField *button1BG;
@property (weak, nonatomic) IBOutlet UITextField *button1FG;
@property (weak, nonatomic) IBOutlet UITextField *button2BG;
@property (weak, nonatomic) IBOutlet UITextField *button2FG;
@property (weak, nonatomic) IBOutlet UITextField *button3BG;
@property (weak, nonatomic) IBOutlet UITextField *button3FG;
@property (weak, nonatomic) IBOutlet UITextField *button4BG;
@property (weak, nonatomic) IBOutlet UITextField *button4FG;

@property (weak, nonatomic) IBOutlet UISwitch *requireNextSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *attemptFacialRecognition;

@property (weak, nonatomic) IBOutlet UILabel *timeBetweenEachQuestionMeanLabel;
@property (weak, nonatomic) IBOutlet UISlider *timeBetweenEachQuestionMean;
@property (weak, nonatomic) IBOutlet UILabel *timeBetweenEachQuestionPlusMinusLabel;
@property (weak, nonatomic) IBOutlet UISlider *timeBetweenEachQuestionPlusMinus;

@property (weak, nonatomic) IBOutlet UISwitch *presentationTimeIsInfinite;
@property (weak, nonatomic) IBOutlet UILabel *presentationTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *presentationTime;

@property (weak, nonatomic) IBOutlet UISwitch *responseWindowIsInfinite;
@property (weak, nonatomic) IBOutlet UILabel *responseWindowLabel;
@property (weak, nonatomic) IBOutlet UISlider *responseWindow;

@property (weak, nonatomic) IBOutlet UISwitch *useSpecifiedSeed;
@property (weak, nonatomic) IBOutlet UITextField *specifiedSeed;

enum Test1ConfigTableViewController_TableView_positions
{
    sInformation = 0,
    
    sImageSequence = 1,
    rViewSequence = 0,

    sStaircaseMethodParameters = 2,
    
    sMOCS = 3,
    
    sDisplayConfiguration = 4,
    
    sExitButtonConfiguration = 5,
    
    sNumberOfButtons = 6,
    
    sButtonText = 7,
    
    sButtonPresentationDelay = 8,
    
    sButtonPositioning = 9,
    
    sButtonColours = 10,
    
    sGeneralTestingParameters = 11,
    
    sTimeBetweenEachQuestion = 12,
    
    sPresentationTime = 13,
    
    sResponseWindow = 14,
    
    sRandomisationSettings = 15
};

- (IBAction)saveChanges:(id)sender;

@end
