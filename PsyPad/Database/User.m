//
//  User.m
//  PsyPad
//
//  Created by David Lawson on 6/01/13.
//  Copyright (c) 2013 David Lawson. All rights reserved.
//

#import "User.h"
#import "TestConfiguration.h"
#import "TestLog.h"
#import "AppDelegate.h"

@implementation User

@dynamic id;
@dynamic configurations;
@dynamic logs;

+ (NSArray *)allUsers
{
    NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:context]];

    NSError *error;
    NSArray *users = [context executeFetchRequest:request error:&error];

    if (error)
    {
        NSLog(@"Error loading users: %@", [error localizedDescription]);
        return nil;
    }

    return users;
}

- (void)addConfigurationsObject:(TestConfiguration *)value
{
    NSMutableOrderedSet *tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.configurations];
    [tempSet addObject:value];
    self.configurations = tempSet;
}

- (void)removeConfigurationsObject:(TestConfiguration *)value
{
    NSMutableOrderedSet *tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.configurations];
    [tempSet removeObject:value];
    self.configurations = tempSet;
}

- (NSArray *)nonPracticeConfigurations
{
    return [self.configurations objectsAtIndexes:
            [self.configurations indexesOfObjectsPassingTest:^BOOL(TestConfiguration *obj, NSUInteger idx, BOOL *stop)
            {
                return obj.practice_configuration.boolValue == NO;
            }]];
}

- (NSArray *)practiceConfigurations
{
    return [self.configurations objectsAtIndexes:
            [self.configurations indexesOfObjectsPassingTest:^BOOL(TestConfiguration *obj, NSUInteger idx, BOOL *stop)
            {
                return obj.practice_configuration.boolValue == YES;
            }]];
}

- (NSArray *)enabledConfigurations
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    int weekday = [comps weekday]; // sunday 0

    return [self.configurations objectsAtIndexes:
            [self.configurations indexesOfObjectsPassingTest:^BOOL(TestConfiguration *obj, NSUInteger idx, BOOL *stop)
            {
                if ( (!obj.day_of_week_sun.boolValue && weekday == 1)
                        || (!obj.day_of_week_mon.boolValue && weekday == 2)
                        || (!obj.day_of_week_tue.boolValue && weekday == 3)
                        || (!obj.day_of_week_wed.boolValue && weekday == 4)
                        || (!obj.day_of_week_thu.boolValue && weekday == 5)
                        || (!obj.day_of_week_fri.boolValue && weekday == 6)
                        || (!obj.day_of_week_sat.boolValue && weekday == 7))
                    return NO;

                return obj.practice_configuration.boolValue == NO && obj.enabled.boolValue && obj.sequence != NULL;
            }]];
}


- (NSArray *)enabledPracticeConfigurations
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    int weekday = [comps weekday]; // sunday 0

    return [self.configurations objectsAtIndexes:
            [self.configurations indexesOfObjectsPassingTest:^BOOL(TestConfiguration *obj, NSUInteger idx, BOOL *stop)
            {
                if ( (!obj.day_of_week_sun.boolValue && weekday == 1)
                        || (!obj.day_of_week_mon.boolValue && weekday == 2)
                        || (!obj.day_of_week_tue.boolValue && weekday == 3)
                        || (!obj.day_of_week_wed.boolValue && weekday == 4)
                        || (!obj.day_of_week_thu.boolValue && weekday == 5)
                        || (!obj.day_of_week_fri.boolValue && weekday == 6)
                        || (!obj.day_of_week_sat.boolValue && weekday == 7))
                    return NO;

                return obj.practice_configuration.boolValue == YES
                        && obj.enabled.boolValue && obj.sequence != NULL;
            }]];
}


@end
