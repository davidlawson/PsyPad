//
//  TestConfigSubTableViewController.m
//  PsyPad
//
//  Created by David Lawson on 12/02/12.
//

#import "TestConfigSubTableViewController.h"
#import "TestConfiguration.h"
#import "TestConfigTableViewController.h"
#import "TestSequence.h"
#import "TestSequenceFolder.h"
#import "TextFieldTableViewCell.h"
#import "SliderTableViewCell.h"
#import "SwitchTableViewCell.h"
#import "TickTableViewCell.h"
#import "TestSequenceImage.h"
#import "AppDelegate.h"
#import "UIView+Positioning.h"
#import "ImageTableViewCell.h"

@interface TestConfigSubTableViewController ()

@end

@implementation TestConfigSubTableViewController

#pragma mark - Initial setup

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self populateFields];
}

- (void)populateFields
{
    if ([self.navigationItem.title isEqualToString:@"Image Information"])
    {
        self.image_name.text = self.selectedImage.name;

        if (!self.selectedImage.is_animated.boolValue)
        {
            self.image_view.image = self.selectedImage.image;
        }
        else
        {
            NSArray *animImages = self.selectedImage.images;

            self.image_view.animationImages = animImages;
            self.image_view.animationDuration = animImages.count * 0.05; // 50ms per frame
            [self.image_view startAnimating];
        }
    }
}

#pragma mark - ViewController delegate methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View transition methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TestConfigSubTableViewController *dest = segue.destinationViewController;
    dest.parentController = self;

    if ([segue.identifier isEqualToString:@"FolderInformation"])
    {
        TestSequenceFolder *sequence = [self.sequence.folders objectAtIndex:(NSUInteger)[[self.tableView indexPathForSelectedRow] row]];
        [dest setSelectedFolder:sequence];
    }
    if ([segue.identifier isEqualToString:@"ImageInformation"])
    {
        TestSequenceImage *sequence = [self.selectedFolder.images objectAtIndex:(NSUInteger)[[self.tableView indexPathForSelectedRow] row]];
        [dest setSelectedImage:sequence];
    }
}

#pragma mark - CoreData helper methods

- (TestConfiguration *)data
{
    TestConfigTableViewController *parent = self.parentController;
    return [parent configuration];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.navigationItem.title isEqualToString:@"Sequence Information"])
    {
        return 2;
    }
    else if ([self.navigationItem.title isEqualToString:@"Folder Information"])
    {
        return 2;
    }

    return [super numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.navigationItem.title isEqualToString:@"Sequence Information"])
    {
        if (section == 0)
        {
            if (self.sequence.backgroundImage) return 2;
            else return 1;
        }
        else return self.sequence.folders.count;
    }
    else if ([self.navigationItem.title isEqualToString:@"Folder Information"])
    {
        if (section == 0) return 1;
        else return self.selectedFolder.images.count;
    }

    return [super tableView:tableView numberOfRowsInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self.navigationItem.title isEqualToString:@"Sequence Information"])
    {
        if (section == 1) return @"Folders";
    }
    else if ([self.navigationItem.title isEqualToString:@"Folder Information"])
    {
        if (section == 1) return @"Images";
    }

    return [super tableView:tableView titleForHeaderInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.navigationItem.title isEqualToString:@"Sequence Information"])
    {
        if (indexPath.section == 0)
        {
            if (indexPath.row == 0)
            {
                TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell"];
                cell.textField.text = self.sequence.name;
                return cell;
            }
            else if (indexPath.row == 1)
            {
                ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell"];
                cell.imageView.image = self.sequence.backgroundImage;
                return cell;
            }
        }
        else if (indexPath.section == 1)
        {
            UITableViewCell *folderCell = [tableView dequeueReusableCellWithIdentifier:@"FolderCell"];

            TestSequenceFolder *selectedFolder = [self.sequence.folders objectAtIndex:(NSUInteger)indexPath.row];

            folderCell.textLabel.text = selectedFolder.name.length ? selectedFolder.name : @"Folder";
            folderCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu image(s)", (unsigned long)selectedFolder.images.count];

            return folderCell;
        }
    }
    else if ([self.navigationItem.title isEqualToString:@"Folder Information"])
    {
        if (indexPath.section == 0)
        {
            if (indexPath.row == 0) // Name
            {
                TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell"];
                cell.textField.text = self.selectedFolder.name;
                return cell;
            }
        }
        else if (indexPath.section == 1)
        {
            UITableViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell"];

            TestSequenceFolder *selectedImage = [self.selectedFolder.images objectAtIndex:(NSUInteger)indexPath.row];

            imageCell.textLabel.text = selectedImage.name.length ? selectedImage.name : @"Image";
            return imageCell;
        }
    }

    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.navigationItem.title isEqualToString:@"Sequence Information"] && indexPath.section == 1)
        return 64;
    else if (indexPath.section == 0 && indexPath.row == 1)
        return 449;

    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

/*- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}*/

#pragma mark - Clean up

- (void)viewDidUnload
{
    [self setImage_name:nil];
    [self setImage_view:nil];
    [super viewDidUnload];
}

@end
