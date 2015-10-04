//
//  DLAppDelegate.h
//  Boilerplate
//
//  Created by David Lawson on 16/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>

///  
///  Subclass and set up DLSettings in `application:didFinishLaunchingWithOptions:`.
///  
@interface DLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/// 
///  Standard application launch method.
///  Ensure that you don't put any code in here that might
///  take a while to execute or that might crash the app before
///  a crash handler is set up. Put that sort of thing (e.g.
///  database related code) in your launch view controller.
/// 
///  A typical subclass will set up DLSettings before calling
/// 
///    return [super application:application didFinishLaunchingWithOptions:launchOptions];
///  
///  code block above
///
///  @param application   The singleton app object.
///  @param launchOptions A dictionary indicating the reason the app was launched (if any). The contents of this dictionary may be empty in situations where the user launched the app directly. For information about the possible keys in this dictionary and how to handle them, see Launch Options Keys.
///
///  @return NO if the app cannot handle the URL resource or continue a user activity, otherwise return YES. The return value is ignored if the app is launched as a result of a remote notification.
///
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions __attribute__((objc_requires_super));

@end

