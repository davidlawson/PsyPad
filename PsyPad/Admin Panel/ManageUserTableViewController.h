//
//  ManageUserTableViewController.h
//  PsyPad
//
//  Created by David Lawson on 01/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

@class User;

@interface ManageUserTableViewController : UITableViewController

@property (strong, nonatomic) User *user;
@property (weak, nonatomic) IBOutlet UITextField *userIDTextField;

@end
