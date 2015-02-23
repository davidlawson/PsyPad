//
//  BorderButton.m
//  PsyPad
//
//  Created by David Lawson on 23/10/13.
//  Copyright (c) 2013 David Lawson. All rights reserved.
//

#import "BorderButton.h"

@implementation BorderButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithWhite:193.0f/255.0f alpha:1.0f].CGColor;
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
}

@end
