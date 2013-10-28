//
//  TickTableViewCell.m
//  PsyPad
//
//  Created by David Lawson on 6/12/12.
//
//

#import "TickTableViewCell.h"

@implementation TickTableViewCell

#pragma mark - UI helper functions



- (void)styleCellSelected
{
    self.altImageView.hidden = NO;
    self.altTextLabel.textColor = TEXT_SELECTED_COLOR;
}

- (void)styleCellNormal
{
    self.altImageView.hidden = YES;
    self.altTextLabel.textColor = [UIColor blackColor];
}

@end
