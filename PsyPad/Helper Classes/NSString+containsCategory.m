//
//  NSString+containsCategory.m
//  PsyPad
//
//  Created by David Lawson on 02/27/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "NSString+containsCategory.h"

@implementation NSString (containsCategory)

- (BOOL) containsString: (NSString*) substring
{
    NSRange range = [self rangeOfString : substring];
    BOOL found = ( range.location != NSNotFound );
    return found;
}

@end
