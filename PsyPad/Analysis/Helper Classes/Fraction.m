//
//  Fraction.m
//  PsyPad
//
//  Created by David Lawson on 01/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction


- (id)init
{
    self = [super init];
    if (self)
    {
        self.numerator = [NSNumber numberWithInt: 0];
        self.denominator = [NSNumber numberWithInt: 0];
    }

    return self;
}

- (float)floatValue
{
    return self.numerator.floatValue / self.denominator.floatValue;
}

@end
