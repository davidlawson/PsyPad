//
//  AdminPanelTableViewController.h
//  2
//
//  Created by David Lawson on 01/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

@class MBProgressHUD;
@class APIController;

@interface AdminPanelTableViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSMutableArray *users;
@property (strong, nonatomic) NSArray *serverUsers;

@property (strong, nonatomic) MBProgressHUD *hud;

- (IBAction)saveChanges:(id)sender;

- (IBAction)dismissModal:(id)sender;

@end
