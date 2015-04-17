//
//  MainMenuViewController.h
//  PsyPad
//
//  Created by David Lawson on 28/12/12.
//  Copyright (c) 2012 David Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSZipArchive.h"

@class User;
@class MBProgressHUD;
@class APIController;

@interface MainMenuViewController : UIViewController <UITextFieldDelegate, SSZipArchiveDelegate>

@property (strong, nonatomic) IBOutlet UIView *overlay;

@property (weak, nonatomic) IBOutlet UIView *centreBox;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (weak, nonatomic) IBOutlet UIButton *beginTestButton;
@property (weak, nonatomic) IBOutlet UIButton *beginPracticeTestButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@property (strong, nonatomic) UIAlertView *passwordAlertView;

@property (strong, nonatomic) User *user;

- (IBAction)loginPress;
- (IBAction)doLogout;

- (IBAction)beginTestPress:(id)sender;

@end
