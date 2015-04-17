//
//  TestLogTableViewController.h
//  PsyPad
//
//  Created by David Lawson on 13/12/12.
//

#import <UIKit/UIKit.h>

@class TestLog;
@class User;

@interface TestLogTableViewController : UITableViewController

@property (strong, nonatomic) TestLog *log;
@property (strong, nonatomic) NSOrderedSet *logs;
@property (strong, nonatomic) User *user;

@end
