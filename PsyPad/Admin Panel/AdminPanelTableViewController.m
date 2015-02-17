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
#import "AppConfiguration.h"
#import "APIController.h"
#import "TextFieldTableViewCell.h"
#import "TestConfiguration.h"
#import "UserTableViewCell.h"
#import "MBProgressHUD.h"
#import "MainMenuViewController.h"
#import "DatabaseManager.h"

@interface AdminPanelTableViewController ()

@end

@implementation AdminPanelTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return self.users.count + 1;
    else if (section == 1)
        return self.serverUsers.count + 1;
    else if (section == 2)
        return 3;
    else
        return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;

    if (indexPath.section == 0 && indexPath.row < self.users.count)
    {
        UserTableViewCell *tvCell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];

        User *user = [self.users objectAtIndex:(NSUInteger)indexPath.row];

        tvCell.textLabel.text = user.id;
        tvCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu test configurations, %lu practice test configurations, %lu logs", (unsigned long)user.configurations.count, (unsigned long)user.practiceConfigurations.count, (unsigned long)user.logs.count];
        tvCell.downloadAction = ^(void)
        {
            [self downloadParticipant:user.id];
        };
        tvCell.uploadAction = ^(void)
        {
            [self uploadUser:user];
        };

        cell = tvCell;
    }
    else if (indexPath.section == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AddUserCell"];
    }
    else if (indexPath.section == 1 && indexPath.row < self.serverUsers.count)
    {
        UserTableViewCell *tvCell = [tableView dequeueReusableCellWithIdentifier:@"ServerUserCell"];

        NSDictionary *user = [self.serverUsers objectAtIndex:(NSUInteger)indexPath.row];

        tvCell.textLabel.text = [user objectForKey:@"username"];
        tvCell.detailTextLabel.text = [user objectForKey:@"description"];
        tvCell.downloadAction = ^(void)
        {
            [self downloadParticipant:[user objectForKey:@"username"]];
        };

        cell = tvCell;
    }
    else if (indexPath.section == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"LoadUserListCell"];
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
            cell = [tableView dequeueReusableCellWithIdentifier:@"UploadLogsCell"];
        else if (indexPath.row == 1)
            cell = [tableView dequeueReusableCellWithIdentifier:@"DownloadAllCell"];
        else if (indexPath.row == 2)
            cell = [tableView dequeueReusableCellWithIdentifier:@"UploadAllCell"];
    }
    else if (indexPath.section == 3)
    {
        if (indexPath.row == 0)
        {
            TextFieldTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"AdminPasswordCell"];
            theCell.textField.text = self.appConfiguration.admin_password;
            cell = theCell;
        }
        else if (indexPath.row == 1)
        {
            TextFieldTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"ServerURLCell"];
            theCell.textField.text = self.appConfiguration.server_url;
            cell = theCell;
        }
        else if (indexPath.row == 2)
        {
            TextFieldTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"UsernameCell"];
            theCell.textField.text = self.appConfiguration.server_username;
            cell = theCell;
        }
        else if (indexPath.row == 3)
        {
            TextFieldTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"PasswordCell"];
            theCell.textField.text = self.appConfiguration.server_password;
            cell = theCell;
        }
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == self.users.count)
    {
        return 44;
    }
    else if (indexPath.section == 1 && indexPath.row == self.serverUsers.count)
    {
        return 44;
    }
    else if (indexPath.section == 2 || indexPath.section == 3)
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
    if (indexPath.section == 0 && indexPath.row == self.users.count)
    {
        [self addParticipant];
    }
    else if (indexPath.section == 1 && indexPath.row == self.serverUsers.count)
    {
        [self loadServerParticipants];
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
            [self uploadLogs];
        else if (indexPath.row == 1)
            [self downloadAllParticipants];
        else if (indexPath.row == 2)
            [self uploadAllParticipants];
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

    [self.APIController loadServerParticipants:^(NSMutableArray *serverUsers)
    {
        self.serverUsers = serverUsers;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.hud hide:YES];
        [self.hud removeFromSuperview];

    } failure:^
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
    }];

    return;
}

- (void)downloadParticipant:(NSString *)username
{
    self.hud = [self createHUD];
    self.hud.mode = MBProgressHUDModeDeterminate;
    self.hud.labelText = @"Downloading participant...";

    [self.APIController downloadParticipant:username progress:^(NSString *status, float progress)
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

    } failure:^
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
    } supressErrors:NO];

    return;
}

- (void)uploadUser:(User *)user
{
    self.hud = [self createHUD];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"Uploading user...";

    [self.APIController uploadUser:user success:^
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];

        [[[UIAlertView alloc] initWithTitle:@""
                                    message:@"User uploaded successfully"
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];

    } failure:^
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
    }];
}

- (void)uploadLogs
{
    self.hud = [self createHUD];
    self.hud.mode = MBProgressHUDModeDeterminate;
    self.hud.labelText = @"Uploading...";

    [self.APIController uploadLogs:self.users progress:^(NSString *status, float progress)
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

    } failure:^
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
    }];
}

- (void)downloadAllParticipants
{
    self.hud = [self createHUD];
    self.hud.mode = MBProgressHUDModeDeterminate;
    self.hud.labelText = @"Downloading participants...";

    [self.APIController downloadAllParticipants:^(NSString *status, float progress)
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

    } failure:^
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
    }];
}

- (void)uploadAllParticipants
{
    self.hud = [self createHUD];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"Uploading participants...";

    [self.APIController uploadAllUsers:self.users success:^
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];

        [[[UIAlertView alloc] initWithTitle:@""
                                    message:@"Participants uploaded successfully"
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];

    } failure:^
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
    }];
}

- (void)addParticipant
{
    User *defaultUser = NULL;
    for (User *user in self.users)
    {
        if ([user.id isEqualToString:@"default"])
        {
            defaultUser = user;
            break;
        }
    }

    if (defaultUser == NULL)
    {
        [[[UIAlertView alloc] initWithTitle:@"No Default User"
                                    message:@"You need a default user downloaded from the server to copy from."
                                   delegate:nil
                          cancelButtonTitle:@"Okay"
                          otherButtonTitles:nil] show];
        return;
    }

    RIButtonItem *cancelButton = [RIButtonItem itemWithLabel:@"Cancel"];

    RIButtonItem *createUserButton = [RIButtonItem itemWithLabel:@"Create User"];

    self.addUserAlertView = [[UIAlertView alloc] initWithTitle:@"New User"
                                                        message:@"Please choose a user ID:"
                                               cancelButtonItem:cancelButton
                                               otherButtonItems:createUserButton, nil];

    createUserButton.action = ^{
        NSString *userID = [self.addUserAlertView textFieldAtIndex:0].text;

        BOOL usernameTaken = NO;
        for (User *user in self.users)
        {
            if ([user.id isEqualToString:userID])
            {
                usernameTaken = YES;
                break;
            }
        }

        if (usernameTaken)
        {
            [[[UIAlertView alloc] initWithTitle:@"Username Taken"
                                        message:@"Sorry, that participant already exists."
                                       delegate:nil
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil] show];
        }
        else if ([userID isEqualToString:@"default"] || [userID isEqualToString:@"admin"])
        {
            [[[UIAlertView alloc] initWithTitle:@"Reserved Username"
                                        message:@"Sorry, please choose another username."
                                       delegate:nil
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil] show];
        }
        else if (userID.length == 0)
        {
            [[[UIAlertView alloc] initWithTitle:@"Empty Username"
                                        message:@"Please choose a username."
                                       delegate:nil
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil] show];
        }
        else
        {
            self.hud = [self createHUD];
            self.hud.mode = MBProgressHUDModeIndeterminate;
            self.hud.labelText = @"Creating Participant";

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^
            {
                [[NSManagedObjectContext MR_defaultContext] lock];

                User *newUser = [User MR_createEntity];
                newUser.id = userID;

                for (TestConfiguration *configuration in defaultUser.configurations)
                {
                    TestConfiguration *new_config = [TestConfiguration MR_createEntity];
                    [new_config copyFromConfiguration:configuration];
                    [newUser addConfigurationsObject:new_config];
                }

                [DatabaseManager save];

                [[NSManagedObjectContext MR_defaultContext] unlock];

                [self.users addObject:newUser];

                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.users indexOfObject:newUser] inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                    [self.hud hide:YES];
                    [self.hud removeFromSuperview];
                });
            });

            //[self performSegueWithIdentifier:@"ConfigurationInformation" sender:[NSIndexPath indexPathForRow:[self.user.configurations indexOfObject:newConfiguration] inSection:0]];
        }
    };

    self.addUserAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [self.addUserAlertView textFieldAtIndex:0].delegate = self;

    [self.addUserAlertView show];
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
    switch ([(UITextField *)sender tag])
    {
        case 1:
            self.appConfiguration.admin_password = [(UITextField *)sender text];
            break;
        case 2:
            self.appConfiguration.server_url = [(UITextField *)sender text];
            break;
        case 3:
            self.appConfiguration.server_username = [(UITextField *)sender text];
            break;
        case 4:
            self.appConfiguration.server_password = [(UITextField *)sender text];
            break;
    }

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
    [self dismissViewControllerAnimated:YES completion:^
    {
        [(MainMenuViewController *)self.presentingViewController loadUsers];
    }];
}

@end
