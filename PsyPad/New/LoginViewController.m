//
//  LoginViewController.m
//  PsyPad
//
//  Created by David Lawson on 23/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "LoginViewController.h"
#import "DLKeyboardObserver.h"
#import "SignUpTableViewController.h"
#import "DLTextFieldToolbar.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIView *centreView;
@property (nonatomic, strong) DLKeyboardObserver *keyboardObserver;
@property (weak, nonatomic) IBOutlet UITextField *serverURLField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (nonatomic, strong) DLTextFieldToolbar *textFieldToolbar;

@property (nonatomic) CGFloat oldCentreViewOffset;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centreViewOffset;


@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    self.oldCentreViewOffset = self.centreViewOffset.constant;
    
    self.keyboardObserver = [[DLKeyboardObserver alloc] init];
    self.keyboardObserver.keyboardChanged = ^(BOOL visible, CGFloat height)
    {
        [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
        {
            weakSelf.centreViewOffset.constant = weakSelf.oldCentreViewOffset;
            
            if (visible)
                weakSelf.centreViewOffset.constant = (weakSelf.view.frame.size.height - height) / 2.0f;
            
            [weakSelf.view layoutIfNeeded];
        } completion:nil];
    };
    
    self.textFieldToolbar = [[DLTextFieldToolbar alloc] initWithTextFields:@[
        self.serverURLField,
        self.emailField,
        self.passwordField
    ]];
    
    self.textFieldToolbar.finalReturnBlock = ^{ [weakSelf login]; };
}

- (IBAction)login
{
    
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
