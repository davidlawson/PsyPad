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
#import "RootEntity.h"
#import "MainMenuViewController.h"
#import "DemoViewController.h"
#import "DatabaseManager.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)handleLaunch
{
    [super handleLaunch];
    
    // perform application initialization (but not migration) steps here
    
    // Ensure https is used instead of http
    if ([[RootEntity rootEntity].server_url isEqualToString:@"http://server.psypad.net.au/"])
    {
        [RootEntity rootEntity].server_url = @"https://server.psypad.net.au/";
        [DatabaseManager save];
    }
    
    UIViewController *vc;
    if ([RootEntity rootEntity].loggedIn)
    {
        if ([RootEntity rootEntity].demoModeValue)
            vc = [DemoViewController loadFromMainStoryboard];
        else
            vc = [MainMenuViewController loadFromMainStoryboard];
    }
    else
        vc = [LoginViewController loadFromMainStoryboard];
        
    [self.navigationController setViewControllers:@[vc] animated:YES];
}

- (IBAction)tappedVisitWebsite:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.psypad.net.au/"]];
}

@end
