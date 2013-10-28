//
// Created by david on 7/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSArray+GetRandom.h"
#import "Random.h"

@implementation NSArray (GetRandom)

- (id)getRandomObject:(unsigned short *)state
{
    if (self.count == 0) return nil;
    else if (self.count == 1) return [self objectAtIndex:0];
    else
        return [self objectAtIndex:(NSUInteger)[Random randiFrom:0 to:self.count - 1 withState:state]];
}

@end