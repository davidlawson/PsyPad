//
//  LoginViewController.m
//  PsyPad
//
//  Created by David Lawson on 23/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "LoginViewController.h"
#import <Boilerplate/DLKeyboardObserver.h>
#import "SignUpTableViewController.h"
#import <Boilerplate/DLTextFieldCollection.h>
#import "NSString+Email.h"
#import "MBProgressHUD.h"
#import "RootEntity.h"
#import "UIViewController+DLLoad.h"
#import "MainMenuViewController.h"
#import "DatabaseManager.h"
#import "DemoViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIView *centreView;
@property (nonatomic, strong) DLKeyboardObserver *keyboardObserver;

@property (nonatomic, strong) DLTextFieldCollection *textFields;

@property (nonatomic) CGFloat defaultCentreViewOffset;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centreViewOffset;


@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.serverURLField.text = [RootEntity rootEntity].server_url;
    
    __weak typeof(self) weakSelf = self;
    
    self.defaultCentreViewOffset = self.centreViewOffset.constant;
    
    self.keyboardObserver = [[DLKeyboardObserver alloc] init];
    self.keyboardObserver.keyboardChanged = ^(BOOL visible, CGFloat height)
    {
        [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
        {
            weakSelf.centreViewOffset.constant = weakSelf.defaultCentreViewOffset;
            
            if (visible)
                weakSelf.centreViewOffset.constant = height / 2.0f;
            
            [weakSelf.view layoutIfNeeded];
        } completion:nil];
    };
    
    self.textFields = [[DLTextFieldCollection alloc] initWithTextFields:@[
        self.serverURLField,
        self.emailField,
        self.passwordField
    ]];
    
    self.textFields.finalReturnBlock = ^{ [weakSelf login]; };
}

- (IBAction)login
{
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
                                    message:@"Please enter your password to log in."
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
        
        [weakSelf.navigationController setViewControllers:@[[DemoViewController loadFromMainStoryboard]] animated:YES];
    };
    
    void (^failure)(NSString *error) = ^(NSString *error)
    {
        [[[UIAlertView alloc] initWithTitle:@"Log In Failed"
                                    message:error
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];
        
        [hud hide:YES];
    };
    
    [RootEntity rootEntity].server_url = self.serverURLField.text;
    [DatabaseManager save];
    
    [[ServerManager sharedManager] loginWithEmail:self.emailField.text
                                         password:self.passwordField.text
                                          success:success
                                          failure:failure];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SignUp"])
    {
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        SignUpTableViewController *sutvc = nc.viewControllers[0];
        sutvc.serverField.text = self.serverURLField.text;
        sutvc.emailField.text = self.emailField.text;
        sutvc.passwordField.text = self.passwordField.text;
    }
}

- (IBAction)tappedVisitWebsite:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.psypad.net.au/"]];
}

@end
