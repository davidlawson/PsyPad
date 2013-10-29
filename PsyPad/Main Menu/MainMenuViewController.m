//
//  MainMenuViewController.m
//  PsyPad
//
//  Created by David Lawson on 28/12/12.
//  Copyright (c) 2012 David Lawson. All rights reserved.
//

#import "MainMenuViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <AFNetworking/AFNetworking.h>

#import "UIView+Positioning.h"
#import "UIAlertView+Blocks.h"
#import "AppDelegate.h"
#import "User.h"
#import "TestConfiguration.h"
#import "TestViewController.h"
#import "AdminPanelTableViewController.h"
#import "AppConfiguration.h"

@interface MainMenuViewController ()

@property (nonatomic) BOOL viewSetup;

@end

@implementation MainMenuViewController

#pragma mark - Setup

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.viewSetup = NO;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (!self.viewSetup)
    {
        [self loadAppConfiguration];
        [self loadUsers];
    }
}

- (void)loadUsers
{
    NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:context]];

    NSError *error;
    self.users = [[context executeFetchRequest:request error:&error] mutableCopy];

    if (error)
    {
        NSLog(@"Error loading users: %@", [error localizedDescription]);
        abort();
    }

    NSLog(@"Loaded %d user(s) from database", self.users.count);
}

- (void)loadAppConfiguration
{
    NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"AppConfiguration" inManagedObjectContext:context]];

    NSError *error;
    NSArray *result = [context executeFetchRequest:request error:&error];

    if (error)
    {
        NSLog(@"Error loading app configuration: %@", [error localizedDescription]);
        abort();
    }

    if (result.count > 0)
    {
        self.appConfiguration = [result objectAtIndex:0];

        NSLog(@"Loaded application configuration");
    }
    else
    {
        self.appConfiguration = [NSEntityDescription insertNewObjectForEntityForName:@"AppConfiguration" inManagedObjectContext:context];
        [self.appConfiguration insertDefaultData];
        [APP_DELEGATE saveContext];

        NSLog(@"Created application configuration");
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (!self.viewSetup)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

        [self.centreBox setWidth:300 height:104];
        [self.centreBox moveToY:self.view.height/2 - self.centreBox.height/2];

        [self.statusLabel centerToX:self.centreBox.width/2 y:51];
        self.statusLabel.alpha = 0.0;

        [self.infoLabel moveToX:30 y:14];
        self.infoLabel.alpha = 0.0;

        [self.beginTestButton moveToX:30 y:51];
        self.beginTestButton.alpha = 0.0;

        [self.beginPracticeTestButton moveToX:30 y:51+44+20];
        self.beginPracticeTestButton.alpha = 0.0;

        [self.logoutButton moveToX:30 y:51+44+20+44+20];
        self.logoutButton.alpha = 0.0;

        self.viewSetup = YES;
    }
}

#pragma mark - User interaction

- (IBAction)loginPress
{
    self.loginTextField.text = [self.loginTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (self.loginTextField.text.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"You have not entered a User ID."
                                                       delegate:nil
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }

    [self doLogin:self.loginTextField.text];
}

- (void)doLogin:(NSString *)userID
{
    if ([userID isEqualToString:@"admin"])
    {
        RIButtonItem *cancelButton = [RIButtonItem itemWithLabel:@"Cancel"];

        RIButtonItem *loginButton = [RIButtonItem itemWithLabel:@"Login"];

        self.passwordAlertView = [[UIAlertView alloc] initWithTitle:@"Authentication Required"
                                                             message:@"Please enter admin password:"
                                                    cancelButtonItem:cancelButton
                                                    otherButtonItems:loginButton, nil];

        loginButton.action = ^{
            NSString *password = [self.passwordAlertView textFieldAtIndex:0].text;
            if ([password isEqualToString:self.appConfiguration.admin_password])
            {
                [self performSegueWithIdentifier:@"AdminPanel" sender:nil];
                self.loginTextField.text = @"";
                [self.loginTextField resignFirstResponder];
            }
            else
            {
                UIAlertView *inval = [[UIAlertView alloc] initWithTitle:@"Access Denied"
                                                                message:@"Incorrect password entered."
                                                               delegate:nil
                                                      cancelButtonTitle:@"Okay"
                                                      otherButtonTitles:nil];
                [inval show];
            }
        };

        self.passwordAlertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [self.passwordAlertView textFieldAtIndex:0].delegate = self;

        [self.passwordAlertView show];

        return;
    }
    else if (self.appConfiguration.server_username.length < 1 || self.appConfiguration.server_password.length < 1)
    {
        [[[UIAlertView alloc] initWithTitle:@"Initial Setup" message:[NSString stringWithFormat:@"Please login as admin/%@ and configure PsyPad.", self.appConfiguration.admin_password] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
        return;
    }

    [self.view endEditing:YES];

    self.statusLabel.text = @"Querying local database...";

    [UIView animateWithDuration:0.3 animations:^
    {
        self.loginTextField.alpha = 0;
        self.loginButton.alpha = 0;
        self.statusLabel.alpha = 1.0;
    }
    completion:^(BOOL finished)
    {
        [self loadUser:userID];
    }];
}

- (void)cancelLogin
{
    [UIView animateWithDuration:0.3
                     animations:^
                     {
                         self.statusLabel.alpha = 0.0;
                         self.loginButton.alpha = 1.0;
                         self.loginTextField.alpha = 1.0;
                     }
    ];
}

- (void)loadUser:(NSString *)userID
{
    // Attempt to connect to server and download latest configuration
    // If a new imageset is there, download that

    self.statusLabel.text = @"Downloading participant...";

    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[self.appConfiguration.server_url stringByAppendingFormat:@"api/load_user/%@", userID]]];
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
                //
            }
            else
            {
                User *newUser = nil;

                BOOL usernameTaken = NO;
                for (User *user in self.users)
                {
                    if ([user.id isEqualToString:userID])
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
                    newUser.id = userID;

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
            }

            [[APP_DELEGATE managedObjectContext] unlock];

            [self loadedUser:userID];
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [self loadedUser:userID];

        NSLog(@"%@", error.description);
        //self.connectionStatusLabel.text = error.description;
        //self.uploadDataButton.enabled = YES;
    }];

    [operation start];

    // Then try load locally.
}

- (void)loadedUser:(NSString *)userID
{
    dispatch_async(dispatch_get_main_queue(), ^
    {
        [self.hud hide:YES];
    });

    unsigned int user = [self.users indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop)
    {
        return [((User *)obj).id isEqualToString:userID];
    }];

    if (user == NSNotFound)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unknown User"
                                                        message:@"User not found."
                                                       delegate:nil
                                              cancelButtonTitle:@"Oh well..."
                                              otherButtonTitles:nil];

        dispatch_async(dispatch_get_main_queue(), ^
        {
            [self cancelLogin];
            [alert show];
        });

        return;
    }

    dispatch_async(dispatch_get_main_queue(), ^
    {
        self.statusLabel.text = @"Found user, loading...";
        self.user = [self.users objectAtIndex:user];
        self.statusLabel.text = @"Loaded user.";

        [self showMainMenu];
    });
}

- (void)showMainMenu
{
    self.infoLabel.text = [NSString stringWithFormat:@"Logged in as %@", self.user.id];

    if (self.user.enabledPracticeConfigurations.count == 0)
    {
        [self.logoutButton moveToY:51+44+20];
    }
    else
    {
        [self.logoutButton moveToY:51+44+20+44+20];
    }

    if (self.user.enabledPracticeConfigurations.count > 1)
    {
        [self.beginPracticeTestButton setTitle:@"Begin Practice Tests" forState:UIControlStateNormal];
    }
    else
    {
        [self.beginPracticeTestButton setTitle:@"Begin Practice Test" forState:UIControlStateNormal];
    }

    if (self.user.enabledConfigurations.count > 1)
    {
        [self.beginTestButton setTitle:@"Begin Tests" forState:UIControlStateNormal];
    }
    else
    {
        [self.beginTestButton setTitle:@"Begin Test" forState:UIControlStateNormal];
    }

    [UIView animateWithDuration:0.3
                     animations:^
                     {
                         if (self.user.enabledPracticeConfigurations.count > 0)
                         {
                             [self.centreBox setHeight:51+44+20+44+20+44+30];
                             self.beginPracticeTestButton.alpha = 1.0;
                         }
                         else
                         {
                             [self.centreBox setHeight:51+44+20+44+30];
                         }

                         [self.centreBox moveToY:self.view.height/2-self.centreBox.height/2];

                         self.statusLabel.alpha = 0.0;
                         self.beginTestButton.alpha = 1.0;
                         self.logoutButton.alpha = 1.0;
                         self.infoLabel.alpha = 1.0;
                     }
    ];
}

- (IBAction)doLogout
{
    self.user = nil;

    self.loginTextField.text = @"";

    [UIView animateWithDuration:0.3
                     animations:^
                     {
                         self.beginTestButton.alpha = 0.0;
                         self.beginPracticeTestButton.alpha = 0.0;
                         self.logoutButton.alpha = 0.0;
                         self.infoLabel.alpha = 0.0;

                         [self.centreBox setHeight:104];
                         [self.centreBox moveToY:self.view.height/2-self.centreBox.height/2];

                         self.loginButton.alpha = 1.0;
                         self.loginTextField.alpha = 1.0;
                     }
    ];
}

- (IBAction)beginTestPress:(id)sender
{
    if (self.user.enabledConfigurations.count > 0)
    {
        [self performSegueWithIdentifier:@"BeginTest" sender:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Test Configurations"
                                                        message:@"No tests are enabled/have been configured."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BeginTest"])
    {
        TestViewController *controller = segue.destinationViewController;
        controller.user = self.user;
        controller.configurations = self.user.enabledConfigurations;
        controller.appConfiguration = self.appConfiguration;
        controller.users = self.users;
    }
    else if ([segue.identifier isEqualToString:@"BeginPracticeTest"])
    {
        TestViewController *controller = segue.destinationViewController;
        controller.user = self.user;
        controller.configurations = self.user.enabledPracticeConfigurations;
        controller.appConfiguration = self.appConfiguration;
        controller.users = self.users;
    }
    else if ([segue.identifier isEqualToString:@"AdminPanel"])
    {
        UINavigationController *controller = segue.destinationViewController;
        AdminPanelTableViewController *theController = [controller.viewControllers objectAtIndex:0];
        theController.users = self.users;
        theController.appConfiguration = self.appConfiguration;
    }
}


#pragma mark - Delegate Methods

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

#pragma mark - Cleanup

- (void)viewDidUnload
{
    [self setCentreBox:nil];
    [self setInfoLabel:nil];
    [super viewDidUnload];
}

#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.loginTextField)
        [self loginPress];
    else
    {
        [self.passwordAlertView clickButtonAtIndex:1];
    }
    return NO;
}


#pragma mark - Keyboard handler

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSValue *animationDurationValue = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];

    [UIView animateWithDuration:animationDuration
        animations:^
        {
            self.overlay.alpha = 0.0;
            [self.centreBox moveToY:self.view.height/2-self.centreBox.height/2];
        }
    ];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardFrame = [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardFrame = [self.view convertRect:keyboardFrame fromView:nil];

    NSValue *animationDurationValue = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];

    [UIView animateWithDuration:animationDuration
        animations:^
        {
            self.overlay.alpha = 1.0;
            [self.centreBox moveToY:(self.view.height-keyboardFrame.size.height)/2-self.centreBox.height/2];
        }
    ];
}

@end
