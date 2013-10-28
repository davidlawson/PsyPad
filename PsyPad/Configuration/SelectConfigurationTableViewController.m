//
//  SelectConfigurationTableViewController.m
//  PsyPad
//
//  Created by David Lawson on 4/01/13.
//  Copyright (c) 2013 David Lawson. All rights reserved.
//

#import "SelectConfigurationTableViewController.h"
#import "User.h"
#import "TickTableViewCell.h"
#import "TestConfiguration.h"
#import "AppDelegate.h"
#import "TestConfigTableViewController.h"

@interface SelectConfigurationTableViewController ()

@end

@implementation SelectConfigurationTableViewController

#pragma mark - Initial setup

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setEditing:NO animated:NO];
}

#pragma mark - UIViewController delegate methods

// Allow landscape orientation only
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIDeviceOrientationIsLandscape(toInterfaceOrientation);
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.user.nonPracticeConfigurations.count + 1;
    }
    else
    {
        return self.user.practiceConfigurations.count + 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section == 0 && indexPath.row == self.user.nonPracticeConfigurations.count)
            || (indexPath.section == 1 && indexPath.row == self.user.practiceConfigurations.count))
    {
        return 44;
    }
    else
    {
        return 64;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section == 0 && indexPath.row < self.user.nonPracticeConfigurations.count)
        || (indexPath.section == 1 && indexPath.row < self.user.practiceConfigurations.count))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section == 0 && indexPath.row < self.user.nonPracticeConfigurations.count)
            || (indexPath.section == 1 && indexPath.row < self.user.practiceConfigurations.count))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;

    if (indexPath.section == 0 && indexPath.row < self.user.nonPracticeConfigurations.count)
    {
        TickTableViewCell *tvCell = [tableView dequeueReusableCellWithIdentifier:@"ConfigurationCell"];

        TestConfiguration *configuration = [self.user.nonPracticeConfigurations objectAtIndex:(NSUInteger)indexPath.row];

        tvCell.altTextLabel.text = configuration.name;
        if (configuration.use_staircase_method.boolValue)
            tvCell.altDetailTextLabel.text = @"Staircase method setup";
        else
            tvCell.altDetailTextLabel.text = [NSString stringWithFormat:@"%d questions", configuration.countQuestions];

        if (configuration.enabled.boolValue)
        {
            [tvCell styleCellSelected];
        }
        else
        {
            [tvCell styleCellNormal];
        }

        cell = tvCell;
    }
    else if (indexPath.section == 0 && indexPath.row == self.user.nonPracticeConfigurations.count)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AddConfigurationCell"];
    }
    else if (indexPath.section == 1 && indexPath.row < self.user.practiceConfigurations.count)
    {
        TickTableViewCell *tvCell = [tableView dequeueReusableCellWithIdentifier:@"ConfigurationCell"];

        TestConfiguration *configuration = [self.user.practiceConfigurations objectAtIndex:(NSUInteger)indexPath.row];

        tvCell.altTextLabel.text = configuration.name;
        if (!configuration.use_staircase_method.boolValue)
            tvCell.altDetailTextLabel.text = [NSString stringWithFormat:@"%d questions", configuration.countQuestions];
        else
            tvCell.altDetailTextLabel.text = [NSString stringWithFormat:@"Staircase method setup"];

        if (configuration.enabled.boolValue)
        {
            [tvCell styleCellSelected];
        }
        else
        {
            [tvCell styleCellNormal];
        }

        cell = tvCell;
    }
    else if (indexPath.section == 1 && indexPath.row == self.user.practiceConfigurations.count)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AddPracticeConfigurationCell"];
    }

    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (sourceIndexPath.section == 0)
    {
        if (proposedDestinationIndexPath.section > 0 ||
                (proposedDestinationIndexPath.section == 0 && proposedDestinationIndexPath.row == self.user.nonPracticeConfigurations.count))
        {
            return [NSIndexPath indexPathForRow:self.user.nonPracticeConfigurations.count-1 inSection:0];
        }
    }
    else if (sourceIndexPath.section == 1)
    {
        if (proposedDestinationIndexPath.section < 1)
        {
            return [NSIndexPath indexPathForRow:0 inSection:1];
        }
        else if (proposedDestinationIndexPath.section == 1 && proposedDestinationIndexPath.row == self.user.practiceConfigurations.count)
        {
            return [NSIndexPath indexPathForRow:self.user.practiceConfigurations.count-1 inSection:1];
        }
    }

    return proposedDestinationIndexPath;
}


#pragma mark - Table view actions

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row < self.user.nonPracticeConfigurations.count)
    {
        TestConfiguration *configuration = [self.user.nonPracticeConfigurations objectAtIndex:(NSUInteger)indexPath.row];
        if (configuration.enabled.boolValue)
        {
            configuration.enabled = [NSNumber numberWithBool:NO];
            [((TickTableViewCell *)[tableView cellForRowAtIndexPath:indexPath]) styleCellNormal];
        }
        else
        {
            configuration.enabled = [NSNumber numberWithBool:YES];
            [((TickTableViewCell *)[tableView cellForRowAtIndexPath:indexPath]) styleCellSelected];
        }

        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else if (indexPath.section == 0 && indexPath.row == self.user.nonPracticeConfigurations.count)
    {
        [self addConfiguration];
    }
    else if (indexPath.section == 1 && indexPath.row < self.user.practiceConfigurations.count)
    {
        TestConfiguration *configuration = [self.user.practiceConfigurations objectAtIndex:(NSUInteger)indexPath.row];
        if (configuration.enabled.boolValue)
        {
            configuration.enabled = [NSNumber numberWithBool:NO];
            [((TickTableViewCell *)[tableView cellForRowAtIndexPath:indexPath]) styleCellNormal];
        }
        else
        {
            configuration.enabled = [NSNumber numberWithBool:YES];
            [((TickTableViewCell *)[tableView cellForRowAtIndexPath:indexPath]) styleCellSelected];
        }

        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == self.user.practiceConfigurations.count)
    {
        [self addPracticeConfiguration];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if ([self.navigationItem.title isEqualToString:@"Select Configuration"])
    {
        [self performSegueWithIdentifier:@"ConfigurationInformation" sender:indexPath];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editing)
    {
        return UITableViewCellEditingStyleNone;
    }

    return UITableViewCellEditingStyleDelete;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    // Make sure you call super first
    [super setEditing:editing animated:animated];

    if (editing)
    {
        self.editButtonItem.title = @"Done";
    }
    else
    {
        self.editButtonItem.title = @"Reorder";
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        TestConfiguration *selectedConfiguration;
        
        if (indexPath.section == 0)
        {
            selectedConfiguration = [self.user.nonPracticeConfigurations objectAtIndex:(NSUInteger)indexPath.row];
            [self.user removeConfigurationsObject:selectedConfiguration];
        }
        else
        {
            selectedConfiguration = [self.user.practiceConfigurations objectAtIndex:(NSUInteger)indexPath.row];
            [self.user removeConfigurationsObject:selectedConfiguration];
        }

        // This will cascade and delete all folders, and all images inside them from the database
        [APP_DELEGATE.managedObjectContext deleteObject:selectedConfiguration];

        [APP_DELEGATE saveContext];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (sourceIndexPath.section == 0)
    {
        NSMutableArray *nonPracticeConfigurations = [self.user.nonPracticeConfigurations mutableCopy];
        NSMutableOrderedSet *allConfigurations = [self.user.configurations mutableCopy];

        int from = sourceIndexPath.row;
        int to = destinationIndexPath.row;

        if (to > from)
        {
            for (int x = from; x < to; x++)
            {
                int a = [allConfigurations indexOfObject:[nonPracticeConfigurations objectAtIndex:x]];
                int b = [allConfigurations indexOfObject:[nonPracticeConfigurations objectAtIndex:x + 1]];
                [allConfigurations exchangeObjectAtIndex:(NSUInteger)a withObjectAtIndex:(NSUInteger)b];
            }
        }
        else
        {
            for (int x = from; x > to; x--)
            {
                int a = [allConfigurations indexOfObject:[nonPracticeConfigurations objectAtIndex:x]];
                int b = [allConfigurations indexOfObject:[nonPracticeConfigurations objectAtIndex:x - 1]];
                [allConfigurations exchangeObjectAtIndex:(NSUInteger)a withObjectAtIndex:(NSUInteger)b];
            }
        }

        self.user.configurations = allConfigurations;
    }
    else
    {
        NSMutableArray *practiceConfigurations = [self.user.practiceConfigurations mutableCopy];
        NSMutableOrderedSet *allConfigurations = [self.user.configurations mutableCopy];

        int from = sourceIndexPath.row;
        int to = destinationIndexPath.row;

        if (to > from)
        {
            for (int x = from; x < to; x++)
            {
                int a = [allConfigurations indexOfObject:[practiceConfigurations objectAtIndex:x]];
                int b = [allConfigurations indexOfObject:[practiceConfigurations objectAtIndex:x + 1]];
                [allConfigurations exchangeObjectAtIndex:(NSUInteger)a withObjectAtIndex:(NSUInteger)b];
            }
        }
        else
        {
            for (int x = from; x > to; x--)
            {
                int a = [allConfigurations indexOfObject:[practiceConfigurations objectAtIndex:x]];
                int b = [allConfigurations indexOfObject:[practiceConfigurations objectAtIndex:x - 1]];
                [allConfigurations exchangeObjectAtIndex:(NSUInteger)a withObjectAtIndex:(NSUInteger)b];
            }
        }

        self.user.configurations = allConfigurations;
    }

    [APP_DELEGATE saveContext];
}

#pragma mark - User interaction

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ConfigurationInformation"])
    {
        TestConfigTableViewController *tvc = segue.destinationViewController;
        tvc.parentController = self;

        NSIndexPath *indexPath = (NSIndexPath *)sender;

        if (indexPath.section == 0)
            tvc.configuration = [self.user.nonPracticeConfigurations objectAtIndex:(NSUInteger)indexPath.row];
        else if (indexPath.section == 1)
            tvc.configuration = [self.user.practiceConfigurations objectAtIndex:(NSUInteger)indexPath.row];

        tvc.title = tvc.configuration.name;
    }
}

- (void)addConfiguration
{
    TestConfiguration *newConfiguration = [NSEntityDescription insertNewObjectForEntityForName:@"TestConfiguration" inManagedObjectContext:APP_DELEGATE.managedObjectContext];
    newConfiguration.user = self.user;
    newConfiguration.practice_configuration = @NO;

    [self.user addConfigurationsObject:newConfiguration];

    [APP_DELEGATE saveContext];

    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.user.nonPracticeConfigurations indexOfObject:newConfiguration] inSection:0]] withRowAnimation:UITableViewRowAnimationFade];

    [self performSegueWithIdentifier:@"ConfigurationInformation" sender:[NSIndexPath indexPathForRow:[self.user.nonPracticeConfigurations indexOfObject:newConfiguration] inSection:0]];
}

- (void)addPracticeConfiguration
{
    TestConfiguration *newConfiguration = [NSEntityDescription insertNewObjectForEntityForName:@"TestConfiguration" inManagedObjectContext:APP_DELEGATE.managedObjectContext];
    newConfiguration.user = self.user;
    newConfiguration.practice_configuration = @YES;

    [self.user addConfigurationsObject:newConfiguration];

    [APP_DELEGATE saveContext];

    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.user.practiceConfigurations indexOfObject:newConfiguration] inSection:1]] withRowAnimation:UITableViewRowAnimationFade];

    [self performSegueWithIdentifier:@"ConfigurationInformation" sender:[NSIndexPath indexPathForRow:[self.user.practiceConfigurations indexOfObject:newConfiguration] inSection:1]];
}

- (IBAction)dismissModal:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
