//
// Created by david on 7/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSString+getNumberFromString.h"


@implementation NSString (getNumberFromString)

- (int)getNumberInGroup:(int)group element:(int)element
{
    NSArray *groups = [self componentsSeparatedByString:@"/"];
    if (group < groups.count)
    {
        NSString *chosenGroup = [groups objectAtIndex:(NSUInteger)group];
        NSArray *elements = [chosenGroup componentsSeparatedByString:@","];

        if (element < elements.count)
        {
            return [(NSString *) [elements objectAtIndex:(NSUInteger)element] intValue];
        }
        else
        {
            return -1;
        }
    }
    else
    {
        return -1;
    }
}

@end