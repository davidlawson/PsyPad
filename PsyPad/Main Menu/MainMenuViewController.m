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
#import "APIController.h"
#import "DatabaseManager.h"

#define CENTRE_BOX_Y 330

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
        self.appConfiguration = [AppConfiguration MR_findFirst];
        self.APIController = [APIController controllerWithConfiguration:self.appConfiguration];
        [self loadUsers];
    }
}

- (void)loadUsers
{
    NSArray *users = [User MR_findAll];
    self.users = [users mutableCopy];

    NSLog(@"Loaded %lu user(s) from database",(unsigned long) self.users.count);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (!self.viewSetup)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

        [self.centreBox setWidth:300 height:104];
        [self.centreBox moveToY:CENTRE_BOX_Y];

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
                                                        message:@"You have not entered a participant username."
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
                [self.loginTextField resignFirstResponder];
            }
        };

        cancelButton.action = ^ {
            [self.loginTextField resignFirstResponder];
        };

        self.passwordAlertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [self.passwordAlertView textFieldAtIndex:0].delegate = self;

        [self.passwordAlertView show];

        UITextField *tf = [self.passwordAlertView textFieldAtIndex:0];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tf selectAll:nil];
        });

        return;
    }
    else if (self.appConfiguration.server_username.length < 1 || self.appConfiguration.server_password.length < 1)
    {
        [[[UIAlertView alloc] initWithTitle:@"Initial Setup" message:[NSString stringWithFormat:@"Please login as admin/%@ and configure PsyPad.", self.appConfiguration.admin_password] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
        return;
    }

    [self.view endEditing:YES];

    self.statusLabel.text = @"Loading participant...";

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
    // If a new image set is there, download that

    [self.APIController downloadParticipant:userID progress:^(NSString *status, float progress)
    {
        self.statusLabel.text = [NSString stringWithFormat:@"Loading participant... (%.0f%%)", progress * 100];

    } success:^(User *newUser)
    {
        if (![self.users containsObject:newUser])
            [self.users addObject:newUser];
        
        [self loadedUser:userID];

    } failure:^
    {
        [self loadedUser:userID];
    } supressErrors:YES];

    // Then try load locally.
}

- (void)loadedUser:(NSString *)userID
{
    unsigned long user = [self.users indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop)
    {
        return [((User *)obj).id isEqualToString:userID];
    }];

    if (user == NSNotFound)
    {
        [self cancelLogin];

        [[[UIAlertView alloc] initWithTitle:@"Unknown User"
                                    message:@"User not found."
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];

        return;
    }
    else
    {
        self.statusLabel.text = @"Found participant, loading...";
        self.user = [self.users objectAtIndex:user];
        self.statusLabel.text = @"Loaded participant.";

        [self showMainMenu];
    }
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
                             [self.centreBox moveToY:CENTRE_BOX_Y];

                             self.beginPracticeTestButton.alpha = 1.0;
                         }
                         else
                         {
                             [self.centreBox setHeight:51+44+20+44+30];
                             [self.centreBox moveToY:CENTRE_BOX_Y];
                         }

                         //[self.centreBox moveToY:self.view.height/2-self.centreBox.height/2];

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
                         [self.centreBox moveToY:CENTRE_BOX_Y];

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
        [[[UIAlertView alloc] initWithTitle:@"No Test Configurations"
                                    message:@"No tests are enabled/have been configured."
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];
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
        controller.APIController = self.APIController;
    }
    else if ([segue.identifier isEqualToString:@"BeginPracticeTest"])
    {
        TestViewController *controller = segue.destinationViewController;
        controller.user = self.user;
        controller.configurations = self.user.enabledPracticeConfigurations;
        controller.appConfiguration = self.appConfiguration;
        controller.users = self.users;
        controller.APIController = self.APIController;
    }
    else if ([segue.identifier isEqualToString:@"AdminPanel"])
    {
        UINavigationController *controller = segue.destinationViewController;
        AdminPanelTableViewController *theController = [controller.viewControllers objectAtIndex:0];
        theController.users = self.users;
        theController.appConfiguration = self.appConfiguration;
        theController.APIController = self.APIController;
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

            [self.centreBox moveToY:CENTRE_BOX_Y];
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
