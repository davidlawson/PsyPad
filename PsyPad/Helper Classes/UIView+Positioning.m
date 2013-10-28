//
//  UIView+Positioning.m
//  PsyPad
//
//  Created by David Lawson on 7/12/12.
//

#import <CoreGraphics/CoreGraphics.h>
#import "UIView+Positioning.h"

@implementation UIView (Positioning)

- (void)moveToX:(float)x y:(float)y
{
    self.frame = CGRectMake(roundf(x), roundf(y), self.frame.size.width, self.frame.size.height);
}

- (void)moveToX:(float)x
{
    self.frame = CGRectMake(roundf(x), self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)moveToY:(float)y
{
    self.frame = CGRectMake(self.frame.origin.x, roundf(y), self.frame.size.width, self.frame.size.height);
}

- (void)centerToX:(float)x y:(float)y
{
    self.frame = CGRectMake(roundf(x-self.frame.size.width/2), roundf(y-self.frame.size.height/2), self.frame.size.width, self.frame.size.height);
}

- (CGFloat)width
{
    return self.bounds.size.width;
}

- (CGFloat)height
{
    return self.bounds.size.height;
}

- (void)setWidth:(float)width height:(float)height
{
    self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, roundf(width), roundf(height));
}

- (void)setWidth:(float)width
{
    self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, roundf(width), self.bounds.size.height);
}

- (void)setHeight:(float)height
{
    self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, roundf(height));
}

@end
