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
#import "TextFieldTableViewCell.h"
#import "TestConfiguration.h"
#import "UserTableViewCell.h"

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
        tvCell.detailTextLabel.text = [NSString stringWithFormat:@"%d test configurations, %d practice test configurations, %d logs", user.configurations.count, user.practiceConfigurations.count, user.logs.count];
        tvCell.downloadAction = ^(void)
        {
            [self downloadUser:user.id];
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
            [self downloadUser:[user objectForKey:@"username"]];
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
        [self addUser];
    }
    else if (indexPath.section == 1 && indexPath.row == self.serverUsers.count)
    {
        [self loadServerUsers];
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
            [self uploadLogs];
        else if (indexPath.row == 1)
            [self downloadAllData];
        else if (indexPath.row == 2)
            [self uploadAllData];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)loadServerUsers
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"Loading users...";

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[self.appConfiguration.server_url stringByAppendingString:@"api/list_users"]]];
    [request setHTTPMethod:@"POST"];

    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSMutableDictionary *requestData = [NSMutableDictionary dictionary];
    [requestData setObject:self.appConfiguration.server_username forKey:@"username"];
    [requestData setObject:self.appConfiguration.server_password forKey:@"password"];

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestData options:nil error:nil];

    [request setHTTPBody:jsonData];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"%@", operation.responseString);
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^
        {
            self.serverUsers = [NSMutableArray array];

            NSDictionary *data = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
            if (!data)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Load Error"
                                                                message:[NSString stringWithFormat:@"%@", operation.responseString]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Aww."
                                                      otherButtonTitles:nil];

                dispatch_async(dispatch_get_main_queue(), ^{
                    [alert show];
                });
            }
            else if (data.count > 0)
            {
                for (NSString *username in [data.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *a, NSString *b) {
                    return [a compare:b];
                }])
                {
                    NSMutableDictionary *user = [NSMutableDictionary dictionary];
                    [user setObject:username forKey:@"username"];
                    [user setObject:[data objectForKey:username] forKey:@"description"];
                    [self.serverUsers addObject:user];
                }
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.hud hide:YES];
                [self.hud removeFromSuperview];
            });
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Load Error"
                                                        message:[NSString stringWithFormat:@"%@", error.description]
                                                       delegate:nil
                                              cancelButtonTitle:@"Aww."
                                              otherButtonTitles:nil];
        [alert show];
        NSLog(@"%@", error.description);
        //self.connectionStatusLabel.text = error.description;
        //self.uploadDataButton.enabled = YES;
    }];

    [operation start];

    return;
}

// TODO move this into a model class
- (void)downloadUser:(NSString *)username
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"Downloading participant...";

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[self.appConfiguration.server_url stringByAppendingFormat:@"api/load_user/%@", username]]];
    [request setHTTPMethod:@"POST"];

    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSMutableDictionary *requestData = [NSMutableDictionary dictionary];
    [requestData setObject:self.appConfiguration.server_username forKey:@"username"];
    [requestData setObject:self.appConfiguration.server_password forKey:@"password"];

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestData options:nil error:nil];

    [request setHTTPBody:jsonData];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"%@", operation.responseString);
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^
        {
            [[APP_DELEGATE managedObjectContext] lock];

            NSDictionary *data = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
            if (!data)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Load Error"
                                                                message:[NSString stringWithFormat:@"%@", operation.responseString]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Aww."
                                                      otherButtonTitles:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [alert show];
                });
            }
            else
            {
                User *newUser = nil;

                BOOL usernameTaken = NO;
                for (User *user in self.users)
                {
                    if ([user.id isEqualToString:username])
                    {
                        usernameTaken = YES;
                        newUser = user;
                        for (TestConfiguration *configuration in newUser.configurations)
                        {
                            [newUser removeConfigurationsObject:configuration];
                            [[APP_DELEGATE managedObjectContext] deleteObject:configuration];
                        }
                        break;
                    }
                }

                if (!usernameTaken)
                {
                    newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:APP_DELEGATE.managedObjectContext];
                    newUser.id = username;

                    [self.users addObject:newUser];
                }

                for (NSDictionary *configurationData in data)
                {
                    TestConfiguration *newConfiguration = [NSEntityDescription insertNewObjectForEntityForName:@"TestConfiguration"
                                                                                        inManagedObjectContext:APP_DELEGATE.managedObjectContext];
                    newConfiguration.user = newUser;

                    [newConfiguration loadData:configurationData];

                    if ([configurationData objectForKey:@"imageset_url"])
                    {
                        NSString *image_sequence_url = [self.appConfiguration.server_url stringByAppendingString:[configurationData objectForKey:@"imageset_url"]];
                        NSString *image_sequence_data_string = [configurationData objectForKey:@"imageset_data"];
                        NSDictionary *image_sequence_data = [NSJSONSerialization JSONObjectWithData:[image_sequence_data_string dataUsingEncoding:NSASCIIStringEncoding] options:nil error:nil];

                        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
                        [newConfiguration installSequenceWithURL:image_sequence_url data:image_sequence_data HUD:self.hud sema:sema];
                        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
                        //dispatch_release(sema);
                    }

                    /*if ([configurationData objectForKey:@"NQPF"])
                        [newConfiguration setNQPF:[(NSString *)[configurationData objectForKey:@"NQPF"] intValue]];*/

                    [newUser addConfigurationsObject:newConfiguration];
                }

                [APP_DELEGATE saveContext];

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"User downloaded successfully."
                                                               delegate:nil
                                                      cancelButtonTitle:@"Cool!"
                                                      otherButtonTitles:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [alert show];
                });
            }

            [[APP_DELEGATE managedObjectContext] unlock];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.hud hide:YES];
                [self.hud removeFromSuperview];
            });
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Download Error"
                                                        message:[NSString stringWithFormat:@"%@", error.description]
                                                       delegate:nil
                                              cancelButtonTitle:@"Aww."
                                              otherButtonTitles:nil];
        [alert show];
        NSLog(@"%@", error.description);
        //self.connectionStatusLabel.text = error.description;
        //self.uploadDataButton.enabled = YES;
    }];

    [operation start];

    return;
}

- (void)uploadUser:(User *)user
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"Uploading user...";

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[self.appConfiguration.server_url stringByAppendingFormat:@"api/save_user/%@", user.id]]];
    [request setHTTPMethod:@"POST"];

    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSMutableDictionary *requestData = [NSMutableDictionary dictionary];
    [requestData setObject:self.appConfiguration.server_username forKey:@"username"];
    [requestData setObject:self.appConfiguration.server_password forKey:@"password"];

    NSMutableArray *configurations = [NSMutableArray array];
    for (TestConfiguration *configuration in user.configurations)
    {
        [configurations addObject:configuration.serialise];
    }

    [requestData setObject:configurations forKey:@"configurations"];

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestData options:nil error:nil];

    [request setHTTPBody:jsonData];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];

        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"User uploaded successfully"
                                   delegate:nil
                          cancelButtonTitle:@"Horray!"
                          otherButtonTitles:nil] show];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Error"
                                                        message:[NSString stringWithFormat:@"%@", error.description]
                                                       delegate:nil
                                              cancelButtonTitle:@"Aww."
                                              otherButtonTitles:nil];
        [alert show];
        NSLog(@"%@", error.description);
        //self.connectionStatusLabel.text = error.description;
        //self.uploadDataButton.enabled = YES;
    }];

    [operation start];

    return;
}

- (void)uploadLogs
{
    //[[[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Feature not yet implemented." delegate:nil cancelButtonTitle:@"Oh well..." otherButtonTitles:nil] show];
    [self uploadData];
}

- (void)downloadAllData
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"Downloading participants...";

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[self.appConfiguration.server_url stringByAppendingFormat:@"api/load_users"]]];
    [request setHTTPMethod:@"POST"];

    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSMutableDictionary *requestData = [NSMutableDictionary dictionary];
    [requestData setObject:self.appConfiguration.server_username forKey:@"username"];
    [requestData setObject:self.appConfiguration.server_password forKey:@"password"];

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestData options:nil error:nil];

    [request setHTTPBody:jsonData];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^
        {
            [[APP_DELEGATE managedObjectContext] lock];

            NSDictionary *data = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
            if (!data)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Load Error"
                                                                message:[NSString stringWithFormat:@"%@", operation.responseString]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Aww."
                                                      otherButtonTitles:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [alert show];
                });
            }
            else
            {
                for (NSString *username in data.allKeys)
                {
                    NSDictionary *userData = [data objectForKey:username];

                    User *newUser = nil;

                    BOOL usernameTaken = NO;
                    for (User *user in self.users)
                    {
                        if ([user.id isEqualToString:username])
                        {
                            usernameTaken = YES;
                            newUser = user;
                            for (TestConfiguration *configuration in newUser.configurations)
                            {
                                [newUser removeConfigurationsObject:configuration];
                                [[APP_DELEGATE managedObjectContext] deleteObject:configuration];
                            }
                            break;
                        }
                    }

                    if (!usernameTaken)
                    {
                        newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:APP_DELEGATE.managedObjectContext];
                        newUser.id = username;

                        [self.users addObject:newUser];
                    }

                    for (NSDictionary *configurationData in userData)
                    {
                        TestConfiguration *newConfiguration = [NSEntityDescription insertNewObjectForEntityForName:@"TestConfiguration"
                                                                                            inManagedObjectContext:APP_DELEGATE.managedObjectContext];
                        newConfiguration.user = newUser;

                        [newConfiguration loadData:configurationData];

                        if ([configurationData objectForKey:@"imageset_url"])
                        {
                            NSString *image_sequence_url = [self.appConfiguration.server_url stringByAppendingString:[configurationData objectForKey:@"imageset_url"]];
                            NSString *image_sequence_data_string = [configurationData objectForKey:@"imageset_data"];
                            NSDictionary *image_sequence_data = [NSJSONSerialization JSONObjectWithData:[image_sequence_data_string dataUsingEncoding:NSASCIIStringEncoding] options:nil error:nil];

                            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
                            [newConfiguration installSequenceWithURL:image_sequence_url data:image_sequence_data HUD:self.hud sema:sema];
                            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
                            //dispatch_release(sema);
                        }

                        /*if ([configurationData objectForKey:@"NQPF"])
                            [newConfiguration setNQPF:[(NSString *)[configurationData objectForKey:@"NQPF"] intValue]];*/

                        [newUser addConfigurationsObject:newConfiguration];
                    }

                    [APP_DELEGATE saveContext];
                }

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"Users downloaded successfully."
                                                               delegate:nil
                                                      cancelButtonTitle:@"Cool!"
                                                      otherButtonTitles:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [alert show];
                });
            }

            [[APP_DELEGATE managedObjectContext] unlock];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.hud hide:YES];
                [self.hud removeFromSuperview];
            });
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Download Error"
                                                        message:[NSString stringWithFormat:@"%@", error.description]
                                                       delegate:nil
                                              cancelButtonTitle:@"Aww."
                                              otherButtonTitles:nil];
        [alert show];
        NSLog(@"%@", error.description);
        //self.connectionStatusLabel.text = error.description;
        //self.uploadDataButton.enabled = YES;
    }];

    [operation start];

    return;
}

- (void)uploadAllData
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"Uploading users...";

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[self.appConfiguration.server_url stringByAppendingFormat:@"api/save_users"]]];
    [request setHTTPMethod:@"POST"];

    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSMutableDictionary *requestData = [NSMutableDictionary dictionary];
    [requestData setObject:self.appConfiguration.server_username forKey:@"username"];
    [requestData setObject:self.appConfiguration.server_password forKey:@"password"];

    NSMutableDictionary *users = [NSMutableDictionary dictionary];

    for (User *user in self.users)
    {
        NSMutableArray *configurations = [NSMutableArray array];
        for (TestConfiguration *configuration in user.configurations)
        {
            [configurations addObject:configuration.serialise];
        }

        [users setObject:configurations forKey:user.id];
    }

    [requestData setObject:users forKey:@"users"];

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestData options:nil error:nil];

    [request setHTTPBody:jsonData];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];

        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"Users uploaded successfully"
                                   delegate:nil
                          cancelButtonTitle:@"Horray!"
                          otherButtonTitles:nil] show];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Error"
                                                        message:[NSString stringWithFormat:@"%@", error.description]
                                                       delegate:nil
                                              cancelButtonTitle:@"Aww."
                                              otherButtonTitles:nil];
        [alert show];
        NSLog(@"%@", error.description);
        //self.connectionStatusLabel.text = error.description;
        //self.uploadDataButton.enabled = YES;
    }];

    [operation start];

    return;
}

- (void)addUser
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
        UIAlertView *inval = [[UIAlertView alloc] initWithTitle:@"No Default User"
                                                        message:@"You need a default user downloaded from the server to copy from."
                                                       delegate:nil
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        [inval show];
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
            UIAlertView *inval = [[UIAlertView alloc] initWithTitle:@"Username Taken"
                                                            message:@"Sorry, that user already exists."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil];
            [inval show];
        }
        else
        {
            self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.hud.mode = MBProgressHUDModeIndeterminate;
            self.hud.labelText = @"Creating User";

            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^
            {
                [[APP_DELEGATE managedObjectContext] lock];

                User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:APP_DELEGATE.managedObjectContext];
                newUser.id = userID;

                for (TestConfiguration *configuration in defaultUser.configurations)
                {
                    TestConfiguration *new_config = [NSEntityDescription insertNewObjectForEntityForName:@"TestConfiguration" inManagedObjectContext:APP_DELEGATE.managedObjectContext];
                    [new_config copyFromConfiguration:configuration];
                    [newUser addConfigurationsObject:new_config];
                }

                [APP_DELEGATE saveContext];

                [[APP_DELEGATE managedObjectContext] unlock];

                [self.users addObject:newUser];

                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.users indexOfObject:newUser] inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
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

- (void)uploadData
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeDeterminate;
    self.hud.labelText = @"Uploading...";

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[self.appConfiguration.server_url stringByAppendingString:@"api/upload_logs"]]];
    [request setHTTPMethod:@"POST"];

    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSMutableDictionary *requestData = [NSMutableDictionary dictionary];

    NSMutableDictionary *logData = [NSMutableDictionary dictionary];

    for (User *user in self.users)
    {
        NSMutableDictionary *oneUser = [NSMutableDictionary dictionary];

        for (TestLog *log in user.logs)
        {
            NSString *logIdentifier = nil;
            NSMutableString *logContent = [NSMutableString string];
            for (TestLogItem *logItem in log.logitems)
            {
                if (logIdentifier == nil) logIdentifier = [NSString stringWithFormat:@"%.0f", logItem.timestamp.timeIntervalSince1970];
                [logContent appendFormat:@"%.0f|%@|%@\n", logItem.timestamp.timeIntervalSince1970, logItem.type, logItem.info];
            }

            [oneUser setObject:logContent forKey:logIdentifier];
        }

        [logData setObject:oneUser forKey:user.id];
    }

    [requestData setObject:logData forKey:@"log_data"];
    [requestData setObject:self.appConfiguration.server_username forKey:@"username"];
    [requestData setObject:self.appConfiguration.server_password forKey:@"password"];

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestData options:nil error:nil];

    [request setHTTPBody:jsonData];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {

        NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);

        self.hud.progress = (float)totalBytesWritten/(float)totalBytesExpectedToWrite;
        //self.connectionStatusLabel.text = [NSString stringWithFormat:@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite];

    }];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Complete"
                                                        message:[NSString stringWithFormat:@"Data successfully uploaded. Response: %@", operation.responseString]
                                                       delegate:nil
                                              cancelButtonTitle:@"Yay!"
                                              otherButtonTitles:nil];
        [alert show];
        //self.uploadDataButton.enabled = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Error"
                                                        message:[NSString stringWithFormat:@"%@", error.description]
                                                       delegate:nil
                                              cancelButtonTitle:@"Aww."
                                              otherButtonTitles:nil];
        [alert show];
        NSLog(@"%@", error.description);
        //self.connectionStatusLabel.text = error.description;
        //self.uploadDataButton.enabled = YES;
    }];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];

    return;
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
        [APP_DELEGATE.managedObjectContext deleteObject:selectedUser];

        [APP_DELEGATE saveContext];

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

    [APP_DELEGATE saveContext];
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
