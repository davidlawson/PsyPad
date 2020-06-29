//
//  DLKeyboardObserver.h
//  Boilerplate
//
//  Created by David Lawson on 23/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

///  
///  Observes changes in keyboard status and calls block
///  with keyboard visibility and height on change.
///  
@interface DLKeyboardObserver : NSObject

@property (nonatomic, copy) void (^keyboardChanged)(BOOL visible, CGFloat height);

@end
