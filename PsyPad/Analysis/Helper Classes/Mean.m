//
//  Mean.m
//  PsyPad
//
//  Created by David Lawson on 01/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Mean.h"

@implementation Mean

- (id)init
{
    self = [super init];
    if (self)
    {
        self.values = [NSMutableArray array];
    }

    return self;
}

- (void)addValue:(float)value
{
    [self.values addObject:@(value)];
}

- (float)max
{
    float max = -1;
    for (NSNumber *num in self.values)
    {
        if (num.floatValue > max) max = num.floatValue;
    }
    return max;
}

- (float)mean
{
    float sum = 0;
    for (NSNumber *num in self.values)
    {
        sum += num.floatValue;
    }
    return sum/self.values.count;
}

- (float)stdev
{
    float mean = self.mean;
    float sum = 0;

    for (NSNumber *num in self.values)
    {
        sum += powf(num.floatValue - mean, 2);
    }

    sum /= self.values.count;
    sum = sqrtf(sum);

    return sum;
}


@end
