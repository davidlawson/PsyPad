//
//  ImageTableViewCell.m
//  PsyPad
//
//  Created by David Lawson on 24/02/2014.
//  Copyright (c) 2014 David Lawson. All rights reserved.
//

#import "ImageTableViewCell.h"

@implementation ImageTableViewCell

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.imageView.frame = CGRectMake(10, 10, 521, 428);
}

@end
