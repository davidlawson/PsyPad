//
//  TestLogTableViewController.m
//  PsyPad
//
//  Created by David Lawson on 13/12/12.
//

#import "TestLogTableViewController.h"
#import "TestLog.h"
#import "TestLogTableViewCell.h"
#import "TestLogItem.h"
#import "AppDelegate.h"
#import "User.h"
#import "AnalysisTableViewController.h"

@interface TestLogTableViewController ()

@end

@implementation TestLogTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // If we haven't selected a log or aren't in a test, load all the logs for choosing between
    if (!self.log)
    {
        self.logs = self.user.logs;
        self.title = @"Logs";
    }
    else
    {
        // If the user has selected a specific log, hide the Close button.
        if ([self.navigationController.viewControllers indexOfObject:self] == 1)
        {
            self.navigationItem.rightBarButtonItem = nil;
        }
        else
        {
            self.title = @"Current Log";
        }
    }
}

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!self.log)
        return 1;
    else
        return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) return @"Analysis";
    return [super tableView:tableView titleForHeaderInSection:section];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.log)
    {
        if (section == 0)
            return 4;
        else
            return self.log.logitems.count;
    }
    else
    {
        return self.logs.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.log)
    {
        if (indexPath.section == 0)
        {
            return 44;
        }
        else
        {
            TestLogItem *logItem = [self.log.logitems objectAtIndex:(NSUInteger)indexPath.row];

            if (logItem.info.length == 0) return 36;
            else return [super tableView:tableView heightForRowAtIndexPath:indexPath];
        }
    }
    else
    {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.log)
    {
        if (indexPath.section == 0)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnalysisCell"];
            if (indexPath.row == 0)
                cell.textLabel.text = @"Reaction Time";
            else if (indexPath.row == 1)
                cell.textLabel.text = @"Correct Per Level";
            else if (indexPath.row == 2)
                cell.textLabel.text = @"Reversals";
            else if (indexPath.row == 3)
                cell.textLabel.text = @"Presentations Per Level";

            return cell;
        }
        else
        {
            TestLogItem *logItem = [self.log.logitems objectAtIndex:(NSUInteger)indexPath.row];

            TestLogTableViewCell *logCell = [tableView dequeueReusableCellWithIdentifier:@"LogItemCell"];
            logCell.topLabel.text = logItem.type;
            logCell.bottomLabel.text = logItem.info;

            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd/MM/yyyy h:mm:ss a"];

            logCell.rightLabel.text = [dateFormatter stringFromDate:logItem.timestamp];

            return logCell;
        }
    }
    else
    {
        TestLog *log = [self.logs objectAtIndex:(NSUInteger)indexPath.row];

        TestLogTableViewCell *logCell = [tableView dequeueReusableCellWithIdentifier:@"LogCell"];

        NSString *configName = [log getConfigName];

        logCell.topLabel.text = [NSString stringWithFormat:@"Log %d (%@)", (int)indexPath.row+1, configName];
        logCell.bottomLabel.text = [NSString stringWithFormat:@"Log entries: %d", (int)log.logitems.count];

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy h:mm:ss a"];

        logCell.rightLabel.text = [dateFormatter stringFromDate:log.timestamp];

        return logCell;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Analysis"])
    {
        AnalysisTableViewController *controller = segue.destinationViewController;
        controller.log = self.log;

        if ([self.tableView indexPathForSelectedRow].row == 0)
        {
            controller.analysis = kReactionAnalysis;
            controller.title = @"Reaction Time";
        }
        else if ([self.tableView indexPathForSelectedRow].row == 1)
        {
            controller.analysis = kCorrectAnalysis;
            controller.title = @"Correct Per Level";
        }
        else if ([self.tableView indexPathForSelectedRow].row == 2)
        {
            controller.analysis = kThresholdsAnalysis;
            controller.title = @"Reversals";
        }
        else if ([self.tableView indexPathForSelectedRow].row == 3)
        {
            controller.analysis = kPresentationsAnalysis;
            controller.title = @"Presentations Per Level";
        }
    }
    else if ([segue.identifier isEqualToString:@"SelectLog"])
    {
        TestLogTableViewController *controller = segue.destinationViewController;
        controller.log = [self.logs objectAtIndex:(NSUInteger)self.tableView.indexPathForSelectedRow.row];
        controller.title = [NSString stringWithFormat:@"Log %d", (int)self.tableView.indexPathForSelectedRow.row+1];
    }
}

- (void)pressedClose
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
