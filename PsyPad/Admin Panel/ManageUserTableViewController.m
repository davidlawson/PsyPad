//
//  ManageUserTableViewController.m
//  PsyPad
//
//  Created by David Lawson on 01/28/13.
//

#import "ManageUserTableViewController.h"
#import "TestLogTableViewController.h"
#import "User.h"

@interface ManageUserTableViewController ()

@end

@implementation ManageUserTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.userIDTextField.text = self.user.id;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ViewLogs"])
    {
        TestLogTableViewController *dest = segue.destinationViewController;
        dest.user = self.user;
    }
}



@end
