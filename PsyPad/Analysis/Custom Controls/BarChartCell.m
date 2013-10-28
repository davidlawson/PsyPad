//
//  BarChartCell.m
//  PsyPad
//
//  Created by David Lawson on 15/01/13.
//  Copyright (c) 2013 David Lawson. All rights reserved.
//

#import "BarChartCell.h"
#import "UIView+Positioning.h"

@implementation BarChartCell

- (void)displayPercentage:(float)percentage
{
    float width = [self.barContainer width];

    [self.barMiddle setWidth:percentage*width];
    [self.barMiddle moveToX:0];

    self.barLabel.text = [NSString stringWithFormat:@"%.2f%%", percentage*100];
    CGSize textSize = [self.barLabel.text sizeWithFont:self.barLabel.font];

    if (textSize.width > percentage*width)
    {
        [self.barLabel setWidth:width];
        self.barLabel.textAlignment = NSTextAlignmentLeft;
        [self.barLabel moveToX:0];
    }
    else
    {
        [self.barLabel setWidth:percentage*width];
        [self.barLabel moveToX:0];
    }
}

- (void)displayInt:(int)number withMax:(int)max
{
    float width = [self.barContainer width];
    [self.barMiddle setWidth:(float)number/max*width];
    [self.barMiddle moveToX:0];

    self.barLabel.text = [NSString stringWithFormat:@"%d", number];
    CGSize textSize = [self.barLabel.text sizeWithFont:self.barLabel.font];

    if (textSize.width > (float)number/max*width)
    {
        [self.barLabel setWidth:width];
        self.barLabel.textAlignment = NSTextAlignmentLeft;
        [self.barLabel moveToX:0];
    }
    else
    {
        [self.barLabel setWidth:(float)number/max*width];
        [self.barLabel moveToX:0];
    }
}

- (void)displayMean:(float)mean withMax:(float)max
{
    float width = [self.barContainer width];
    [self.barMiddle setWidth:mean/max*width];
    [self.barMiddle moveToX:0];

    self.barLabel.text = [NSString stringWithFormat:@"%.2f", mean];
    CGSize textSize = [self.barLabel.text sizeWithFont:self.barLabel.font];

    if (textSize.width > mean/max*width)
    {
        [self.barLabel setWidth:width];
        self.barLabel.textAlignment = NSTextAlignmentLeft;
        [self.barLabel moveToX:0];
    }
    else
    {
        [self.barLabel setWidth:mean/max*width];
        [self.barLabel moveToX:0];
    }
}

- (void)displayMean:(float)mean withMax:(float)max stdev:(float)stdev
{
    float width = [self.barContainer width];
    [self.barMiddle setWidth:mean/max*width];
    [self.barMiddle moveToX:0];

    self.barLabel.text = [NSString stringWithFormat:@"%.2fms (σ=%.2f)", mean, stdev];
    CGSize textSize = [self.barLabel.text sizeWithFont:self.barLabel.font];

    if (textSize.width > mean/max*width)
    {
        [self.barLabel setWidth:width];
        self.barLabel.textAlignment = NSTextAlignmentLeft;
        [self.barLabel moveToX:0];
    }
    else
    {
        [self.barLabel setWidth:mean/max*width];
        [self.barLabel moveToX:0];
    }
}

@end
