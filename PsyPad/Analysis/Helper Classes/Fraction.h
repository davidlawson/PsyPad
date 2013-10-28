//
//  Fraction.h
//  PsyPad
//
//  Created by David Lawson on 01/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//



@interface Fraction : NSObject

@property (nonatomic, strong) NSNumber *numerator;
@property (nonatomic, strong) NSNumber *denominator;

-(float)floatValue;

@end
