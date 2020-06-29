//
//  UIViewController+DLLoad.h
//  Pods
//
//  Created by David Lawson on 23/02/2015.
//
//

#import <UIKit/UIKit.h>

///  
///  Shortcut to load view controller from the main storyboard
///  that has the same identifier as its class name
///  
@interface UIViewController (DLLoad)

///  
///  Load the view controller from the main storyboard,
///  assuming its identifier is equal to its class name
///  
+ (instancetype)loadFromMainStoryboard;

@end
