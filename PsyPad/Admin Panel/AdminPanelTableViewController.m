//
//  AdminPanelTableViewController.m
//  PsyPad
//
//  Created by David Lawson on 01/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AdminPanelTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "User.h"
#import "AppDelegate.h"
#import "RIButtonItem.h"
#import "UIAlertView+Blocks.h"
#import "ManageUserTableViewController.h"
#import "TestLogItem.h"
#import "TestLog.h"
#import "RootEntity.h"
#import "TextFieldTableViewCell.h"
#import "TestConfiguration.h"
#import "UserTableViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "MainMenuViewController.h"
#import "DatabaseManager.h"
#import "LoginViewController.h"
#import "UIViewController+DLLoad.h"
#import "SwitchTableViewCell.h"
#import "DemoViewController.h"

enum {
    sLocalUsers = 0,
    sServerUsers = 1,
    
    sUploadDownload = 2,
    rUploadLogs = 0,
    rDownloadAll = 1,
    
    sAdmin = 3,
    rDemoMode = 0,
    rAdminPassword = 1,
    rLogout = 2
};

@interface AdminPanelTableViewController ()

@end

@implementation AdminPanelTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.users = [[User MR_findAll] mutableCopy];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == sLocalUsers)
        return MAX(1, self.users.count);
    else if (section == sServerUsers)
        return self.serverUsers.count + 1;
    else if (section == sUploadDownload)
        return 2;
    else // if (section == sAdmin)
        return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    
    UITableViewCell *cell;

    if (indexPath.section == sLocalUsers)
    {
        if (self.users.count == 0)
        {
            return [tableView dequeueReusableCellWithIdentifier:@"NoParticipantsCell" forIndexPath:indexPath];
        }
        
        UserTableViewCell *tvCell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];

        User *user = [self.users objectAtIndex:(NSUInteger)indexPath.row];
        // TODO somehow user is a NSDictionary sometimes

        tvCell.textLabel.text = user.id;
        tvCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu test, %lu practice, %lu logs", (unsigned long)user.configurations.count, (unsigned long)user.practiceConfigurations.count, (unsigned long)user.logs.count];
        tvCell.downloadAction = ^(void)
        {
            [weakSelf downloadParticipant:user.id];
        };

        cell = tvCell;
    }
    else if (indexPath.section == sServerUsers && indexPath.row < self.serverUsers.count)
    {
        UserTableViewCell *tvCell = [tableView dequeueReusableCellWithIdentifier:@"ServerUserCell"];

        NSDictionary *user = [self.serverUsers objectAtIndex:(NSUInteger)indexPath.row];

        tvCell.textLabel.text = user[@"username"];
        tvCell.detailTextLabel.text = user[@"desc"];
        tvCell.downloadAction = ^(void)
        {
            [weakSelf downloadParticipant:user[@"username"]];
        };

        cell = tvCell;
    }
    else if (indexPath.section == sServerUsers)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"LoadUserListCell"];
    }
    else if (indexPath.section == sUploadDownload)
    {
        if (indexPath.row == rUploadLogs)
            cell = [tableView dequeueReusableCellWithIdentifier:@"UploadLogsCell"];
        else // if (indexPath.row == rDownloadAll)
            cell = [tableView dequeueReusableCellWithIdentifier:@"DownloadAllCell"];
    }
    else if (indexPath.section == sAdmin)
    {
        if (indexPath.row == rDemoMode)
        {
            SwitchTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"DemoModeCell"];
            theCell.theSwitch.on = [RootEntity rootEntity].demoModeValue;
            cell = theCell;
        }
        else if (indexPath.row == rAdminPassword)
        {
            TextFieldTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"AdminPasswordCell"];
            theCell.textField.text = [RootEntity rootEntity].admin_password;
            cell = theCell;
        }
        else // if (indexPath.row == rLogout)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"LogoutCell"];
        }
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == sLocalUsers && indexPath.row == self.users.count)
    {
        return 44;
    }
    else if (indexPath.section == sServerUsers && indexPath.row == self.serverUsers.count)
    {
        return 44;
    }
    else if (indexPath.section == sUploadDownload || indexPath.section == sAdmin)
    {
        return 44;
    }
    else
    {
        return 64;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == sServerUsers && indexPath.row == self.serverUsers.count)
    {
        [self loadServerParticipants];
    }
    else if (indexPath.section == sUploadDownload)
    {
        if (indexPath.row == rUploadLogs)
            [self uploadLogs];
        else // if (indexPath.row == rDownloadAll)
            [self downloadAllParticipants];
    }
    else if (indexPath.section == sAdmin && indexPath.row == rLogout)
    {
        [self logout];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (MBProgressHUD *)createHUD
{
    UIWindow *window = self.view.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    return hud;
}

- (void)loadServerParticipants
{
    self.hud = [self createHUD];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"Loading users...";

    [[ServerManager sharedManager] loadServerParticipants:^(NSArray *participants)
    {
        self.serverUsers = participants;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sServerUsers]
                      withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.hud hide:YES];
        [self.hud removeFromSuperview];

    } failure:^(NSString *error)
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
        
        [[[UIAlertView alloc] initWithTitle:@"Failed to Load Participants"
                                    message:error
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];
    }];

    return;
}

- (void)downloadParticipant:(NSString *)username
{
    self.hud = [self createHUD];
    self.hud.mode = MBProgressHUDModeDeterminate;
    self.hud.labelText = @"Downloading participant...";

    [[ServerManager sharedManager] downloadParticipant:username
                                              progress:^(NSString *status, float progress)
    {
        self.hud.labelText = status;
        self.hud.progress = progress;

    } success:^(User *newUser)
    {
        if (![self.users containsObject:newUser])
            [self.users addObject:newUser];

        [[[UIAlertView alloc] initWithTitle:@""
                                    message:@"User downloaded successfully."
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];

        [self.tableView reloadData];
        [self.hud hide:YES];
        [self.hud removeFromSuperview];

    } failure:^(NSString *error)
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
        
        [[[UIAlertView alloc] initWithTitle:@"Failed to Download Participant"
                                    message:error
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];
    }];
}

- (void)uploadLogs
{
    self.hud = [self createHUD];
    self.hud.mode = MBProgressHUDModeDeterminate;
    self.hud.labelText = @"Uploading...";

    [[ServerManager sharedManager] uploadLogsWithProgress:^(NSString *status, float progress)
    {
        self.hud.labelText = status;
        self.hud.progress = progress;

    } success:^
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];

        [[[UIAlertView alloc] initWithTitle:@""
                                    message:[NSString stringWithFormat:@"Logs successfully uploaded"]
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];

    } failure:^(NSString *error)
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
        
        [[[UIAlertView alloc] initWithTitle:@"Failed to Upload Logs"
                                    message:error
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];
    }];
}

- (void)downloadAllParticipants
{
    self.hud = [self createHUD];
    self.hud.mode = MBProgressHUDModeDeterminate;
    self.hud.labelText = @"Downloading participants...";

    [[ServerManager sharedManager] downloadAllParticipants:^(NSString *status, float progress)
    {
        self.hud.labelText = status;
        self.hud.progress = progress;

    } success:^(NSMutableArray *newUsers)
    {
        for (User *user in newUsers)
        {
            if (![self.users containsObject:user])
                [self.users addObject:user];
        }

        [self.hud hide:YES];
        [self.hud removeFromSuperview];

        [[[UIAlertView alloc] initWithTitle:@""
                                    message:[NSString stringWithFormat:@"%lu participants downloaded", (unsigned long)newUsers.count]
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];

    } failure:^(NSString *error)
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
        
        [[[UIAlertView alloc] initWithTitle:@"Failed to Upload Logs"
                                    message:error
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];
    }];
}

- (void)logout
{
    __weak typeof(self) weakSelf = self;
    
    RIButtonItem *logOut = [RIButtonItem itemWithLabel:@"Log Out"];
    logOut.action = ^
    {
        [[ServerManager sharedManager] logout];
        
        UINavigationController *nav = (UINavigationController *)weakSelf.navigationController.presentingViewController;
        [nav setViewControllers:@[[LoginViewController loadFromMainStoryboard], nav.topViewController] animated:NO];
        
        [weakSelf.navigationController dismissViewControllerAnimated:YES completion:^
         {
             [nav popViewControllerAnimated:YES];
         }];
    };
    
    [[[UIAlertView alloc] initWithTitle:@""
                                message:@"Are you sure you want to\nlog out of PsyPad?"
                       cancelButtonItem:[RIButtonItem itemWithLabel:@"Cancel"]
                       otherButtonItems:logOut, nil] show];
}

#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.addUserAlertView clickButtonAtIndex:1];
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row < self.users.count)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        User *selectedUser = [self.users objectAtIndex:(NSUInteger)indexPath.row];

        [self.users removeObject:selectedUser];

        // This will cascade and delete all folders, and all images inside them from the database
        [selectedUser MR_deleteEntity];

        [DatabaseManager save];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (IBAction)saveChanges:(id)sender
{
    [RootEntity rootEntity].admin_password = [(UITextField *)sender text];
    [DatabaseManager save];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ManageUser"])
    {
        ManageUserTableViewController *dest = segue.destinationViewController;

        User *selectedUser = [self.users objectAtIndex:(NSUInteger)self.tableView.indexPathForSelectedRow.row];

        dest.title = selectedUser.id;
        dest.user = selectedUser;
    }
}

- (IBAction)dismissModal:(id)sender
{
    UIViewController *presenting = [(UINavigationController *)self.presentingViewController topViewController];
    
    [self dismissViewControllerAnimated:YES completion:^
    {
        if ([presenting isKindOfClass:[DemoViewController class]]
            && ![RootEntity rootEntity].demoModeValue)
        {
            UINavigationController *nav = presenting.navigationController;
            NSMutableArray *vcs = nav.viewControllers.mutableCopy;
            [vcs removeLastObject];
            [vcs addObject:[MainMenuViewController loadFromMainStoryboard]];
            [nav setViewControllers:vcs animated:YES];
        }
        else if ([presenting isKindOfClass:[MainMenuViewController class]]
                 && [RootEntity rootEntity].demoModeValue)
        {
            UINavigationController *nav = presenting.navigationController;
            NSMutableArray *vcs = nav.viewControllers.mutableCopy;
            [vcs removeLastObject];
            [vcs addObject:[DemoViewController loadFromMainStoryboard]];
            [nav setViewControllers:vcs animated:YES];
        }
    }];
}

- (IBAction)demoModeToggled:(UISwitch *)sender
{
    [RootEntity rootEntity].demoModeValue = sender.on;
    
    if (!sender.on)
    {
        NSString *message;
        if ([RootEntity rootEntity].admin_password.length == 0)
        {
            message = @"No admin password has been set. If you want to restrict access to the admin panel, please set an admin password. Login as \"admin\" to open the admin panel.";
        }
        else
        {
            message = @"Make sure you know the admin password (or set a new one) so you can return to the admin panel. Login as \"admin\" to open the admin panel.";
        }
        
        [[[UIAlertView alloc] initWithTitle:@"Warning"
                                    message:message
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];
    }
    
    [DatabaseManager save];
}

@end
