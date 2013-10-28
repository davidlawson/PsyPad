//
//  BorderButton.m
//  PsyPad
//
//  Created by David Lawson on 23/10/13.
//  Copyright (c) 2013 David Lawson. All rights reserved.
//

#import "BorderButton.h"

@implementation BorderButton

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
}

@end
