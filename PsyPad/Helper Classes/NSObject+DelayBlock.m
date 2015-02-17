//
//  NSObject+DelayBlock.m
//  PsyPad
//
//  Created by David Lawson on 17/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

@implementation NSObject (PerformBlockAfterDelay)

- (void)performBlock:(void (^)(void))block
          afterDelay:(NSTimeInterval)delay
{
    block = [block copy];
    [self performSelector:@selector(fireBlockAfterDelay:)
               withObject:block
               afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block {
    block();
}

@end