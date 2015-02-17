//
//  TestConfigTableViewController.m
//  PsyPad
//
//  Created by David Lawson on 2/12/12.
//

#import "TestConfigTableViewController.h"
#import "AppDelegate.h"
#import "TestConfiguration.h"
#import "TestSequence.h"
#import "User.h"
#import "TestConfigSubTableViewController.h"
#import "SelectConfigurationTableViewController.h"
#import "TickTableViewCell.h"
#import "DatabaseManager.h"

@interface TestConfigTableViewController ()

@end

@implementation TestConfigTableViewController

#pragma mark - Initialisation

- (void)viewDidLoad
{
    [super viewDidLoad];

    //[self loadData];
    [self populateFields];
}

#pragma mark - TextField delegate methods

// Only allow numeric values in certain TextFields (i.e. for seed values)
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return (textField.text.length < 3 || [string isEqualToString:@""]) && ([string isEqualToString:@""] ||
            ([string stringByTrimmingCharactersInSet:
                    [[NSCharacterSet decimalDigitCharacterSet] invertedSet]].length > 0));
}

#pragma mark - CoreData methods

- (IBAction)saveChanges:(id)sender
{
    TestConfiguration *conf = self.configuration;

    conf.name = self.configurationName.text;
    conf.enabled = @(self.enabledSwitch.on);
    conf.day_of_week_mon = @(self.mondaySwitch.on);
    conf.day_of_week_tue = @(self.tuesdaySwitch.on);
    conf.day_of_week_wed = @(self.wednesdaySwitch.on);
    conf.day_of_week_thu = @(self.thursdaySwitch.on);
    conf.day_of_week_fri = @(self.fridaySwitch.on);
    conf.day_of_week_sat = @(self.saturdaySwitch.on);
    conf.day_of_week_sun = @(self.sundaySwitch.on);
    conf.practice_configuration = @(self.practiceConfigurationSwitch.on);

    // view sequence
    conf.loop_animated_images = @(self.loopAnimatedImages.on);
    conf.animation_frame_rate = @(self.animationFrameRate.text.intValue);

    conf.use_staircase_method = @(self.useStaircaseMethodSwitch.on);
    conf.num_staircases_interleaved = @(self.numberOfStaircases.text.intValue);
    conf.staircase_start_level = self.startLevel.text;
    conf.staircase_num_reversals = self.numberOfReversals.text;
    conf.staircase_floor_ceiling_hits = self.hitsToFinish.text;
    conf.staircase_min_level = self.minimumLevel.text;
    conf.staircase_max_level = self.maximumLevel.text;
    conf.staircase_deltas = self.deltaValues.text;
    conf.staircase_num_incorrect_to_get_easier = self.numWrongToGetEasier.text;
    conf.staircase_num_correct_to_get_harder = self.numCorrectToGetHarder.text;

    conf.questions_per_folder = self.questionsPerFolder.text;

    conf.background_colour = self.backgroundColour.text;

    conf.show_exit_button = @(self.showExitButton.on);
    conf.exit_button_x = @(self.exitButtonX.text.intValue);
    conf.exit_button_y = @(self.exitButtonY.text.intValue);
    conf.exit_button_w = @(self.exitButtonW.text.intValue);
    conf.exit_button_h = @(self.exitButtonH.text.intValue);
    conf.exit_button_bg = self.exitButtonBG.text;
    conf.exit_button_fg = self.exitButtonFG.text;

    // # buttons

    conf.button_text_one = self.button1Text.text;
    conf.button_text_two = self.button2Text.text;
    conf.button_text_three = self.button3Text.text;
    conf.button_text_four = self.button4Text.text;
    
    conf.button_presentation_delay = @(self.buttonPresentationDelay.value);

    conf.button1_x = @(self.button1X.text.intValue);
    conf.button1_y = @(self.button1Y.text.intValue);
    conf.button1_w = @(self.button1W.text.intValue);
    conf.button1_h = @(self.button1H.text.intValue);
    conf.button2_x = @(self.button2X.text.intValue);
    conf.button2_y = @(self.button2Y.text.intValue);
    conf.button2_w = @(self.button2W.text.intValue);
    conf.button2_h = @(self.button2H.text.intValue);
    conf.button3_x = @(self.button3X.text.intValue);
    conf.button3_y = @(self.button3Y.text.intValue);
    conf.button3_w = @(self.button3W.text.intValue);
    conf.button3_h = @(self.button3H.text.intValue);
    conf.button4_x = @(self.button4X.text.intValue);
    conf.button4_y = @(self.button4Y.text.intValue);
    conf.button4_w = @(self.button4W.text.intValue);
    conf.button4_h = @(self.button4H.text.intValue);

    conf.button1_bg = self.button1BG.text;
    conf.button1_fg = self.button1FG.text;
    conf.button2_bg = self.button2BG.text;
    conf.button2_fg = self.button2FG.text;
    conf.button3_bg = self.button3BG.text;
    conf.button3_fg = self.button3FG.text;
    conf.button4_bg = self.button4BG.text;
    conf.button4_fg = self.button4FG.text;

    conf.require_next = @(self.requireNextSwitch.on);
    conf.attempt_facial_recognition = @(self.attemptFacialRecognition.on);

    conf.time_between_question_mean = @(self.timeBetweenEachQuestionMean.value);
    conf.time_between_question_plusminus = @(self.timeBetweenEachQuestionPlusMinus.value);

    conf.images_together_presentation_time_is_infinite = @(self.presentationTimeIsInfinite.on);
    conf.images_together_presentation_time = @(self.presentationTime.value);
    
    conf.response_window_is_infinite = @(self.responseWindowIsInfinite.on);
    conf.response_window = @(self.responseWindow.value);

    conf.randomisation_use_specified_seed = @(self.useSpecifiedSeed.on);

    unsigned int uintValue = (unsigned int)strtoul([self.specifiedSeed.text UTF8String], NULL, 0);
    conf.randomisation_specified_seed = [NSNumber numberWithUnsignedInt:uintValue];

    // Handle overflows
    /*if ( self.specifiedSeed.text.length > 0
            && ! [[NSString stringWithFormat:@"%u", conf.randomisation_specified_seed.unsignedIntValue]
                    isEqualToString:self.specifiedSeed.text])
    {
        self.specifiedSeed.text = [NSString stringWithFormat:@"%u", conf.randomisation_specified_seed.unsignedIntValue];
    }*/


    [DatabaseManager save];

    [self populateFields];
}

- (void)populateFields
{
    TestConfiguration *conf = self.configuration;

    self.configurationName.text = conf.name;
    self.enabledSwitch.on = conf.enabled.boolValue;
    self.mondaySwitch.on = conf.day_of_week_mon.boolValue;
    self.tuesdaySwitch.on = conf.day_of_week_tue.boolValue;
    self.wednesdaySwitch.on = conf.day_of_week_wed.boolValue;
    self.thursdaySwitch.on = conf.day_of_week_thu.boolValue;
    self.fridaySwitch.on = conf.day_of_week_fri.boolValue;
    self.saturdaySwitch.on = conf.day_of_week_sat.boolValue;
    self.sundaySwitch.on = conf.day_of_week_sun.boolValue;
    self.practiceConfigurationSwitch.on = conf.practice_configuration.boolValue;

    // view sequence
    self.loopAnimatedImages.on = conf.loop_animated_images.boolValue;
    self.animationFrameRate.text = [NSString stringWithFormat:@"%d", conf.animation_frame_rate.intValue];

    self.useStaircaseMethodSwitch.on = conf.use_staircase_method.boolValue;
    self.numberOfStaircases.text = [NSString stringWithFormat:@"%d", conf.num_staircases_interleaved.intValue];
    self.startLevel.text = conf.staircase_start_level;
    self.numberOfReversals.text = conf.staircase_num_reversals;
    self.hitsToFinish.text = conf.staircase_floor_ceiling_hits;
    self.minimumLevel.text = conf.staircase_min_level;
    self.maximumLevel.text = conf.staircase_max_level;
    self.deltaValues.text = conf.staircase_deltas;
    self.numWrongToGetEasier.text = conf.staircase_num_incorrect_to_get_easier;
    self.numCorrectToGetHarder.text = conf.staircase_num_correct_to_get_harder;

    self.questionsPerFolder.text = conf.questions_per_folder;

    self.backgroundColour.text = conf.background_colour;

    self.showExitButton.on = conf.show_exit_button.boolValue;
    self.exitButtonX.text = [NSString stringWithFormat:@"%d", conf.exit_button_x.intValue];
    self.exitButtonY.text = [NSString stringWithFormat:@"%d", conf.exit_button_y.intValue];
    self.exitButtonW.text = [NSString stringWithFormat:@"%d", conf.exit_button_w.intValue];
    self.exitButtonH.text = [NSString stringWithFormat:@"%d", conf.exit_button_h.intValue];
    self.exitButtonBG.text = conf.exit_button_bg;
    self.exitButtonFG.text = conf.exit_button_fg;

    // # buttons

    self.button1Text.text = conf.button_text_one;
    self.button2Text.text = conf.button_text_two;
    self.button3Text.text = conf.button_text_three;
    self.button4Text.text = conf.button_text_four;
    
    self.buttonPresentationDelay.value = conf.button_presentation_delay.floatValue;
    self.buttonPresentationDelayLabel.text = [NSString stringWithFormat:@"%.2fs", conf.button_presentation_delay.floatValue];
    
    self.button1X.text = [NSString stringWithFormat:@"%d", conf.button1_x.intValue];
    self.button1Y.text = [NSString stringWithFormat:@"%d", conf.button1_y.intValue];
    self.button1W.text = [NSString stringWithFormat:@"%d", conf.button1_w.intValue];
    self.button1H.text = [NSString stringWithFormat:@"%d", conf.button1_h.intValue];
    self.button2X.text = [NSString stringWithFormat:@"%d", conf.button2_x.intValue];
    self.button2Y.text = [NSString stringWithFormat:@"%d", conf.button2_y.intValue];
    self.button2W.text = [NSString stringWithFormat:@"%d", conf.button2_w.intValue];
    self.button2H.text = [NSString stringWithFormat:@"%d", conf.button2_h.intValue];
    self.button3X.text = [NSString stringWithFormat:@"%d", conf.button3_x.intValue];
    self.button3Y.text = [NSString stringWithFormat:@"%d", conf.button3_y.intValue];
    self.button3W.text = [NSString stringWithFormat:@"%d", conf.button3_w.intValue];
    self.button3H.text = [NSString stringWithFormat:@"%d", conf.button3_h.intValue];
    self.button4X.text = [NSString stringWithFormat:@"%d", conf.button4_x.intValue];
    self.button4Y.text = [NSString stringWithFormat:@"%d", conf.button4_y.intValue];
    self.button4W.text = [NSString stringWithFormat:@"%d", conf.button4_w.intValue];
    self.button4H.text = [NSString stringWithFormat:@"%d", conf.button4_h.intValue];

    self.button1BG.text = conf.button1_bg;
    self.button1FG.text = conf.button1_fg;
    self.button2BG.text = conf.button2_bg;
    self.button2FG.text = conf.button2_fg;
    self.button3BG.text = conf.button3_bg;
    self.button3FG.text = conf.button3_fg;
    self.button4BG.text = conf.button4_bg;
    self.button4FG.text = conf.button4_fg;

    self.requireNextSwitch.on = conf.require_next.boolValue;
    self.attemptFacialRecognition.on = conf.attempt_facial_recognition.boolValue;

    self.timeBetweenEachQuestionMean.value = conf.time_between_question_mean.floatValue;
    self.timeBetweenEachQuestionMeanLabel.text = [NSString stringWithFormat:@"%.2fs", conf.time_between_question_mean.floatValue];
    self.timeBetweenEachQuestionPlusMinus.value = conf.time_between_question_plusminus.floatValue;
    self.timeBetweenEachQuestionPlusMinusLabel.text = [NSString stringWithFormat:@"%.2fs", conf.time_between_question_plusminus.floatValue];

    self.presentationTimeIsInfinite.on = conf.images_together_presentation_time_is_infinite.boolValue;
    self.presentationTime.value = conf.images_together_presentation_time.floatValue;
    self.presentationTimeLabel.text = [NSString stringWithFormat:@"%.2fs", conf.images_together_presentation_time.floatValue];
    
    self.responseWindowIsInfinite.on = conf.response_window_is_infinite.boolValue;
    self.responseWindow.value = conf.response_window.floatValue;
    self.responseWindowLabel.text = [NSString stringWithFormat:@"%.2fs", conf.response_window.floatValue];

    self.useSpecifiedSeed.on = conf.randomisation_use_specified_seed.boolValue;
    self.specifiedSeed.text = [NSString stringWithFormat:@"%u", conf.randomisation_specified_seed.unsignedIntValue];
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

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];

    if (indexPath.section == sNumberOfButtons)
    {
        long numChosen = indexPath.row + 1;
        if (self.configuration.number_of_buttons.intValue == numChosen)
        {
            [self styleCellSelected:cell];
        }
        else
        {
            [self styleCellNormal:cell];
        }
    }
    else if (indexPath.section == sImageSequence)
    {
        if (indexPath.row == rViewSequence)
        {
            if (self.configuration.sequence)
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                cell.detailTextLabel.text = self.configuration.sequence.name.length ? self.configuration.sequence.name : @"Sequence";
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.detailTextLabel.text = @"None";
            }
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == sImageSequence)
    {
        if (indexPath.row == rViewSequence)
        {
            if (self.configuration.sequence)
            {
                [self performSegueWithIdentifier:@"SequenceInformation" sender:nil];
            }
        }
    }
    else if (indexPath.section == sNumberOfButtons)
    {
        UITableViewCell *oldCell = [self.tableView cellForRowAtIndexPath:
                [NSIndexPath indexPathForRow:self.configuration.number_of_buttons.intValue - 1 inSection:sNumberOfButtons]];

        [self styleCellNormal:oldCell];
        [self styleCellSelected:[self.tableView cellForRowAtIndexPath:indexPath]];

        self.configuration.number_of_buttons = @(indexPath.row + 1);
        [DatabaseManager save];

        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    SelectConfigurationTableViewController *parent = self.parentController;
    [parent.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)] withRowAnimation:UITableViewRowAnimationNone];
    /*if ([self.configuration.user.practiceConfigurations containsObject:self.configuration])
    {
        [parent.tableView reloadRowsAtIndexPaths:@[
                [NSIndexPath indexPathForRow:[self.configuration.user.practiceConfigurations indexOfObject:self.configuration] inSection:1]
        ] withRowAnimation:UITableViewRowAnimationNone];
    }
    else
    {
        [parent.tableView reloadRowsAtIndexPaths:@[
                [NSIndexPath indexPathForRow:[self.configuration.user.nonPracticeConfigurations indexOfObject:self.configuration] inSection:0]
        ] withRowAnimation:UITableViewRowAnimationNone];
    }*/
}

#pragma mark - UI helper functions

- (void)styleCellSelected:(UITableViewCell *)cell
{
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.textLabel.textColor = TEXT_SELECTED_COLOR;
}

- (void)styleCellNormal:(UITableViewCell *)cell
{
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.textColor = [UIColor blackColor];
}

- (void)styleCellTickSelected:(TickTableViewCell *)cell
{
    cell.altImageView.hidden = NO;
    cell.altTextLabel.textColor = TEXT_SELECTED_COLOR;
}

- (void)styleCellTickNormal:(TickTableViewCell *)cell
{
    cell.altImageView.hidden = YES;
    cell.altTextLabel.textColor = [UIColor blackColor];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TestConfigSubTableViewController *dest = segue.destinationViewController;
    dest.parentController = self;

    if ([segue.identifier isEqualToString:@"SequenceInformation"])
    {
        dest.sequence = self.configuration.sequence;
    }
}

@end
