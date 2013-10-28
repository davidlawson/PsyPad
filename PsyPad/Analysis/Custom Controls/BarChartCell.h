//
//  BarChartCell.h
//  PsyPad
//
//  Created by David Lawson on 15/01/13.
//  Copyright (c) 2013 David Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarChartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

@property (weak, nonatomic) IBOutlet UIView *barContainer;
@property (weak, nonatomic) IBOutlet UIView *barMiddle;
@property (weak, nonatomic) IBOutlet UILabel *barLabel;

-(void)displayPercentage:(float)percentage;

- (void)displayInt:(int)number withMax:(int)max;

- (void)displayMean:(float)mean withMax:(float)max;

- (void)displayMean:(float)mean withMax:(float)max stdev:(float)stdev;
@end
