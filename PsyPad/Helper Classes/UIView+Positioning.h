//
//  UIView+Positioning.h
//  PsyPad
//
//  Created by David Lawson on 7/12/12.
//

#import <UIKit/UIKit.h>

@interface UIView (Positioning)

-(void)moveToX:(float)x y:(float)y;

-(void)moveToX:(float)x;

-(void)moveToY:(float)y;

-(void)centerToX:(float)x y:(float)y;

-(CGFloat)width;

-(CGFloat)height;

-(void)setWidth:(float)width height:(float)height;

-(void)setWidth:(float)width;

-(void)setHeight:(float)height;
@end
