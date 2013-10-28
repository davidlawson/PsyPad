//
//  Mean.h
//  PsyPad
//
//  Created by David Lawson on 01/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//



@interface Mean : NSObject

@property (nonatomic, strong) NSMutableArray *values;

- (void)addValue:(float)value;

- (float)max;

- (float)mean;
- (float)stdev;

@end
