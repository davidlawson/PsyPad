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
#import "RootEntity.h"
#import "DatabaseManager.h"
#import "DLKeyboardObserver.h"

@interface MainMenuViewController ()

@property (nonatomic, strong) DLKeyboardObserver *keyboardObserver;

@property (nonatomic) CGFloat defaultBoxYOffset;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *boxHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *boxYConstraint;

@end

@implementation MainMenuViewController

#pragma mark - Setup

- (void)viewDidLoad
{
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;
    
    self.defaultBoxYOffset = self.boxYConstraint.constant;
    
    self.keyboardObserver = [[DLKeyboardObserver alloc] init];
    self.keyboardObserver.keyboardChanged = ^(BOOL visible, CGFloat height)
    {
        [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
         {
             weakSelf.boxYConstraint.constant = weakSelf.defaultBoxYOffset;
             
             if (visible)
                 weakSelf.boxYConstraint.constant = height / 2.0f;
             
             [weakSelf.view layoutIfNeeded];
             
             weakSelf.overlay.alpha = visible ? 1.0 : 0.0;
             
         } completion:nil];
    };
    
    self.boxHeightConstraint.constant = 104;
    
    self.statusLabel.alpha = 0.0f;
    self.infoLabel.alpha = 0.0f;
    self.logoutButton.alpha = 0.0f;
    self.beginTestButton.alpha = 0.0f;
    self.beginPracticeTestButton.alpha = 0.0f;
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
        if ([RootEntity rootEntity].admin_password.length == 0)
        {
            [self performSegueWithIdentifier:@"AdminPanel" sender:nil];
            self.loginTextField.text = @"";
            [self.loginTextField resignFirstResponder];
            return;
        }

        // Bug in iOS8.3
        // http://stackoverflow.com/questions/29637443/nsinteralinconsistencyexception-uikeyboardlayoutalignmentview
        [self.loginTextField resignFirstResponder];
        
        RIButtonItem *cancelButton = [RIButtonItem itemWithLabel:@"Cancel"];

        RIButtonItem *loginButton = [RIButtonItem itemWithLabel:@"Login"];

        self.passwordAlertView = [[UIAlertView alloc] initWithTitle:@"Authentication Required"
                                                             message:@"Please enter admin password:"
                                                    cancelButtonItem:cancelButton
                                                    otherButtonItems:loginButton, nil];

        loginButton.action = ^{
            NSString *password = [self.passwordAlertView textFieldAtIndex:0].text;
            if ([password isEqualToString:[RootEntity rootEntity].admin_password])
            {
                [self performSegueWithIdentifier:@"AdminPanel" sender:nil];
                self.loginTextField.text = @"";
                [self.loginTextField resignFirstResponder];
            }
            else
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                {
                    [[[UIAlertView alloc] initWithTitle:@"Access Denied"
                                               message:@"Incorrect password entered."
                                              delegate:nil
                                     cancelButtonTitle:@"Okay"
                                     otherButtonTitles:nil] show];
                });
                
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

    [[ServerManager sharedManager] downloadParticipant:userID progress:^(NSString *status, float progress)
    {
        self.statusLabel.text = [NSString stringWithFormat:@"Loading participant... (%.0f%%)", progress * 100];

    } success:^(User *newUser)
    {
        [self loadedUser:userID];

    } failure:^(NSString *error)
    {
        [self loadedUser:userID];
    }];

    // Then try load locally.
}

- (void)loadedUser:(NSString *)userID
{
    User *user = [User MR_findFirstByAttribute:UserAttributes.id withValue:userID];

    if (!user)
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
        self.user = user;
        self.statusLabel.text = @"Loaded participant.";

        [self showMainMenu];
    }
}

- (void)showMainMenu
{
    self.infoLabel.text = [NSString stringWithFormat:@"Logged in as %@", self.user.id];

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

    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.3
                     animations:^
                     {
                         if (self.user.enabledPracticeConfigurations.count > 0)
                         {
                             weakSelf.boxHeightConstraint.constant = 25+20+20+44+20+44+20+44+30;
                             weakSelf.beginPracticeTestButton.alpha = 1.0;
                         }
                         else
                         {
                             weakSelf.boxHeightConstraint.constant = 25+20+20+44+20+44+30;
                             weakSelf.beginPracticeTestButton.alpha = 0.0;
                         }

                         weakSelf.statusLabel.alpha = 0.0;
                         weakSelf.beginTestButton.alpha = 1.0;
                         weakSelf.logoutButton.alpha = 1.0;
                         weakSelf.infoLabel.alpha = 1.0;
                         
                         [weakSelf.view layoutIfNeeded];
                     }
    ];
}

- (IBAction)doLogout
{
    self.user = nil;

    self.loginTextField.text = @"";

    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.3
                     animations:^
                     {
                         weakSelf.beginTestButton.alpha = 0.0;
                         weakSelf.beginPracticeTestButton.alpha = 0.0;
                         weakSelf.logoutButton.alpha = 0.0;
                         weakSelf.infoLabel.alpha = 0.0;

                         weakSelf.boxHeightConstraint.constant = 104;

                         weakSelf.loginButton.alpha = 1.0;
                         weakSelf.loginTextField.alpha = 1.0;
                         
                         [weakSelf.view layoutIfNeeded];
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
    }
    else if ([segue.identifier isEqualToString:@"BeginPracticeTest"])
    {
        TestViewController *controller = segue.destinationViewController;
        controller.user = self.user;
        controller.configurations = self.user.enabledPracticeConfigurations;
    }
}


#pragma mark - Delegate Methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIDeviceOrientationIsLandscape(toInterfaceOrientation);
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.loginTextField)
    {
        [self loginPress];
    }
    else
    {
        [self.passwordAlertView clickButtonAtIndex:1];
    }
    return NO;
}

@end
