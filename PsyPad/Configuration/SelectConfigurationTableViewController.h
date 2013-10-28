//
//  SelectConfigurationTableViewController.h
//  PsyPad
//
//  Created by David Lawson on 4/01/13.
//  Copyright (c) 2013 David Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface SelectConfigurationTableViewController : UITableViewController

@property (strong, nonatomic) User *user;

- (IBAction)dismissModal:(id)sender;

@end
