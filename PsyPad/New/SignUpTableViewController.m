//
//  SignUpTableViewController.m
//  PsyPad
//
//  Created by David Lawson on 23/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "SignUpTableViewController.h"
#import <Boilerplate/DLTextFieldToolbar.h>
#import "ServerManager.h"
#import "RootEntity.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "LoginViewController.h"
#import <Boilerplate/NSString+Email.h>
#import "DatabaseManager.h"

@interface SignUpTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *affiliationField;

@property (weak, nonatomic) IBOutlet UITableViewCell *signUpCell;

@property (nonatomic, strong) NSArray *textFields;
@property (nonatomic, strong) DLTextFieldToolbar *toolbar;

@end

@implementation SignUpTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.serverField.text = [RootEntity rootEntity].server_url;
    
    self.textFields = @[self.serverField,
                        self.emailField,
                        self.passwordField,
                        self.confirmPasswordField,
                        self.affiliationField];
    
    __weak typeof(self) weakSelf = self;
    
    self.toolbar = [[DLTextFieldToolbar alloc] initWithTextFields:self.textFields];
    self.toolbar.finalReturnBlock = ^
    {
        [weakSelf signUp];
    };
}

- (IBAction)tappedClose:(UIBarButtonItem *)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView cellForRowAtIndexPath:indexPath] == self.signUpCell)
    {
        [self signUp];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)signUp
{
    if (![self.passwordField.text isEqualToString:self.confirmPasswordField.text])
    {
        [[[UIAlertView alloc] initWithTitle:@"Password Mismatch"
                                    message:@"The two passwords you entered do not match."
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];
        return;
    }
    
    if (![self.emailField.text isValidEmail])
    {
        [[[UIAlertView alloc] initWithTitle:@"Invalid Email"
                                    message:@"The email address you entered is invalid."
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];
        return;
    }
    
    if (self.passwordField.text.length <= 0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Misisng Password"
                                    message:@"Please choose a password to sign up with."
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];
        return;
    }
    
    if (self.affiliationField.text.length <= 0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Misisng Affiliation"
                                    message:@"Please enter your academic affiliation (or \"None\")."
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    __weak typeof(self) weakSelf = self;
    void (^success)() = ^
    {
        [hud hide:YES];
        
        LoginViewController *lvc = (LoginViewController *)[(UINavigationController *)weakSelf.navigationController.presentingViewController topViewController];
        lvc.serverURLField.text = weakSelf.serverField.text;
        lvc.emailField.text = weakSelf.emailField.text;
        lvc.passwordField.text = weakSelf.passwordField.text;
        
        [weakSelf.navigationController dismissViewControllerAnimated:YES completion:^
        {
            [lvc login];
        }];
    };
    
    void (^failure)(NSString *error) = ^(NSString *error)
    {
        [[[UIAlertView alloc] initWithTitle:@"Sign Up Failed"
                                    message:error
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];
        
        [hud hide:YES];
    };
    
    [RootEntity rootEntity].server_url = self.serverField.text;
    [DatabaseManager save];
    
    [[ServerManager sharedManager] signUpWithEmail:self.emailField.text
                                          password:self.passwordField.text
                                              info:@{ @"affiliation": self.affiliationField.text }
                                           success:success
                                           failure:failure];
}

@end
