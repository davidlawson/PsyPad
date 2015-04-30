//
//  BarChartCell.m
//  PsyPad
//
//  Created by David Lawson on 15/01/13.
//  Copyright (c) 2013 David Lawson. All rights reserved.
//

#import "BarChartCell.h"
#import "UIView+Positioning.h"

@interface BarChartCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *barMiddleWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *barLabelWidth;


@end

@implementation BarChartCell

- (void)displayPercentage:(float)percentage
{
    float width = [self.barContainer width];

    self.barMiddleWidth.constant = percentage*width;

    self.barLabel.text = [NSString stringWithFormat:@"%.2f%%", percentage*100];
    CGSize textSize = [self.barLabel.text sizeWithFont:self.barLabel.font];

    if (textSize.width > percentage*width)
    {
        self.barLabelWidth.constant = width;
        self.barLabel.textAlignment = NSTextAlignmentLeft;
    }
    else
    {
        self.barLabelWidth.constant = percentage*width;
    }
}

- (void)displayInt:(int)number withMax:(int)max
{
    float width = [self.barContainer width];
    
    self.barMiddleWidth.constant = (float)number/max*width;

    self.barLabel.text = [NSString stringWithFormat:@"%d", number];
    CGSize textSize = [self.barLabel.text sizeWithFont:self.barLabel.font];

    if (textSize.width > (float)number/max*width)
    {
        self.barLabelWidth.constant = width;
        self.barLabel.textAlignment = NSTextAlignmentLeft;
    }
    else
    {
        self.barLabelWidth.constant = (float)number/max*width;
    }
}

- (void)displayMean:(float)mean withMax:(float)max
{
    float width = [self.barContainer width];
    
    self.barMiddleWidth.constant = mean/max*width;

    self.barLabel.text = [NSString stringWithFormat:@"%.2f", mean];
    CGSize textSize = [self.barLabel.text sizeWithFont:self.barLabel.font];

    if (textSize.width > mean/max*width)
    {
        self.barLabelWidth.constant = width;
        self.barLabel.textAlignment = NSTextAlignmentLeft;
    }
    else
    {
        self.barLabelWidth.constant = mean/max*width;
    }
}

- (void)displayMean:(float)mean withMax:(float)max stdev:(float)stdev
{
    float width = [self.barContainer width];
    
    self.barMiddleWidth.constant = mean/max*width;

    self.barLabel.text = [NSString stringWithFormat:@"%.2fms (σ=%.2f)", mean, stdev];
    CGSize textSize = [self.barLabel.text sizeWithFont:self.barLabel.font];

    if (textSize.width > mean/max*width)
    {
        self.barLabelWidth.constant = width;
        self.barLabel.textAlignment = NSTextAlignmentLeft;
    }
    else
    {
        self.barLabelWidth.constant = mean/max*width;
    }
}

@end
