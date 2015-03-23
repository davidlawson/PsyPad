//
//  LoginViewController.h
//  PsyPad
//
//  Created by David Lawson on 23/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *serverURLField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)login;

@end
