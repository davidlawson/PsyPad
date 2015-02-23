//
//  SignUpTableViewController.m
//  PsyPad
//
//  Created by David Lawson on 23/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "SignUpTableViewController.h"
#import "DLTextFieldToolbar.h"

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
    
}

@end
