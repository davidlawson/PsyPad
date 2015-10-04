//
//  UIStoryboard+DLMain.h
//  Boilerplate
//
//  Created by David Lawson on 16/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>

///  
///  Shortcut to access the storyboard named "Main"
///  
@interface UIStoryboard (DLMain)

///  
///  Load the storyboard named "Main"
///  
+ (UIStoryboard *)mainStoryboard;

@end
