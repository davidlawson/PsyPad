//
//  DemoViewController.m
//  PsyPad
//
//  Created by David Lawson on 16/04/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "DemoViewController.h"
#import "ConfigurationsTableViewController.h"
#import "TestViewController.h"
#import "TestLogTableViewController.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Configurations"])
    {
        ConfigurationsTableViewController *dest = (ConfigurationsTableViewController *)segue.destinationViewController;
        dest.parentVC = self;
    }
    else if ([segue.identifier isEqualToString:@"Test"])
    {
        TestViewController *controller = segue.destinationViewController;
        controller.configurations = @[sender];
    }
    else if ([segue.identifier isEqualToString:@"ShowLog"])
    {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        TestLogTableViewController *vc = (TestLogTableViewController *)nav.topViewController;
        vc.log = sender;
        vc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:vc action:@selector(pressedClose)];
    }
}

- (IBAction)tappedVisitWebsite:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.psypad.net.au/"]];
}

@end
