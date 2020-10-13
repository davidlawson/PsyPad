//
//  SignUpTableViewController.m
//  PsyPad
//
//  Created by David Lawson on 23/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "SignUpTableViewController.h"
#import "DLTextFieldToolbar.h"
#import "ServerManager.h"
#import "RootEntity.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "LoginViewController.h"
#import "NSString+Email.h"
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
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Password Mismatch"
                                    message:@"The two passwords you entered do not match."
                                 preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if (![self.emailField.text isValidEmail])
    {
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Invalid Email"
                                    message:@"Invalid Email."
                                 preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if (self.passwordField.text.length <= 0)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Misisng Password"
                                     message:@"Please choose a password to sign up with." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if (self.affiliationField.text.length <= 0)
    {
        UIAlertController * alert = [UIAlertController
                                    alertControllerWithTitle:@"Misisng Affiliation"
                                     message:@"Please enter your academic affiliation (or \"None\")."
                                     preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];

        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    __weak typeof(self) weakSelf = self;
    void (^success)(void) = ^
    {
        [hud hideAnimated:YES];
        
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
        UIAlertController * alert = [UIAlertController
                                    alertControllerWithTitle:@"Sign Up Failed"
                                     message:error
                                     preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        
        [hud hideAnimated:YES];
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
