#import "User.h"
#import "TestConfiguration.h"

@interface User ()

// Private interface goes here.

@end

@implementation User

- (NSArray *)nonPracticeConfigurations
{
    return [self.configurations objectsAtIndexes:
            [self.configurations indexesOfObjectsPassingTest:^BOOL(TestConfiguration *obj, NSUInteger idx, BOOL *stop)
            {
                return obj.is_practiceValue == NO;
            }]];
}

- (NSArray *)practiceConfigurations
{
    return [self.configurations objectsAtIndexes:
            [self.configurations indexesOfObjectsPassingTest:^BOOL(TestConfiguration *obj, NSUInteger idx, BOOL *stop)
            {
                return obj.is_practiceValue == YES;
            }]];
}

- (NSArray *)enabledConfigurations
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    long weekday = [comps weekday]; // sunday 0

    return [self.configurations objectsAtIndexes:
            [self.configurations indexesOfObjectsPassingTest:^BOOL(TestConfiguration *obj, NSUInteger idx, BOOL *stop)
            {
                if ( (!obj.day_of_week_sunValue && weekday == 1)
                        || (!obj.day_of_week_monValue && weekday == 2)
                        || (!obj.day_of_week_tueValue && weekday == 3)
                        || (!obj.day_of_week_wedValue && weekday == 4)
                        || (!obj.day_of_week_thuValue && weekday == 5)
                        || (!obj.day_of_week_friValue && weekday == 6)
                        || (!obj.day_of_week_satValue && weekday == 7))
                    return NO;

                return obj.is_practiceValue == NO && obj.enabledValue && obj.sequence != NULL;
            }]];
}


- (NSArray *)enabledPracticeConfigurations
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    long weekday = [comps weekday]; // sunday 0

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

                return obj.is_practiceValue == YES
                        && obj.enabledValue && obj.sequence != NULL;
            }]];
}

@end
