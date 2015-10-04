//
//  DLLaunchViewController.h
//  Boilerplate
//
//  Created by David Lawson on 5/03/15.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

///  
///  ViewController that is used as the application's launch VC.
///  Handles database setup and any other necessary things that
///  might take time and shouldn't be done in the application delegate.
///  
///  This also handles tracking versioning with NSUserDefaults.
///  – currentAppVersion will contain the current bundle version integer
///  – oldAppVersion will contain the old bundle version integer if the
///    user is opening the new version for the first time
///  
@interface DLLaunchViewController : UIViewController

///  
///  Called inside viewDidAppear
///  
- (void)handleLaunch;

///  
///  Called when migrating between versions, before database setup
///  
- (void)preDatabaseSetupMigrationFrom:(int)oldBuild to:(int)currentBuild;

///  
///  Called when migrating between versions, after database setup
///  
- (void)postDatabaseSetupMigrationFrom:(int)oldBuild to:(int)currentBuild;

@end