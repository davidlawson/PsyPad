//
//  DLLaunchViewController.m
//  Boilerplate
//
//  Created by David Lawson on 5/03/15.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "DLLaunchViewController.h"
#import "DLSettings.h"
#import "DLDatabaseManager.h"

@implementation DLLaunchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self handleLaunch];
}

- (void)handleLaunch
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    int currentBuild = [infoDictionary[(NSString*)kCFBundleVersionKey] intValue];
    int oldBuild = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"currentAppVersion"];
    
    if (currentBuild != oldBuild)
        [self preDatabaseSetupMigrationFrom:oldBuild to:currentBuild];

    [[DLSettings sharedSettings].databaseManagerClass setup];

    if (currentBuild != oldBuild)
        [self postDatabaseSetupMigrationFrom:oldBuild to:currentBuild];

    if (oldBuild != currentBuild)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:oldBuild forKey:@"oldAppVersion"];
        [[NSUserDefaults standardUserDefaults] setInteger:currentBuild forKey:@"currentAppVersion"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oldAppVersion"];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)preDatabaseSetupMigrationFrom:(int)oldBuild to:(int)currentBuild
{

}

- (void)postDatabaseSetupMigrationFrom:(int)oldBuild to:(int)currentBuild
{

}

@end