//
//  NSObject+DelayBlock.h
//  PsyPad
//
//  Created by David Lawson on 12/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface NSObject (PerformBlockAfterDelay)

- (void)performBlock:(void (^)(void))block
          afterDelay:(NSTimeInterval)delay;

- (void)fireBlockAfterDelay:(void (^)(void))block;

@end
