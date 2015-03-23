//
//  LaunchViewController.m
//  PsyPad
//
//  Created by David Lawson on 22/03/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "LaunchViewController.h"
#import "LoginViewController.h"
#import "UIViewController+DLLoad.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)handleLaunch
{
    [super handleLaunch];
    
    // perform application initialization (but not migration) steps here
    
    [self.navigationController setViewControllers:@[[LoginViewController loadFromMainStoryboard]] animated:YES];
}

- (IBAction)tappedVisitWebsite:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.psypad.net.au/"]];
}

@end
