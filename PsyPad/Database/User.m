//
//  User.m
//  eTASM2
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

- (void)insertDefaultData
{
    /*TestConfiguration *RFSPracticeConfig, *RFSConfig,
            *GlassPracticeConfig, *GlassConfig,
            *GDMPracticeConfig, *GDMConfig;

    RFSPracticeConfig = [NSEntityDescription insertNewObjectForEntityForName:@"TestConfiguration"
                                              inManagedObjectContext:APP_DELEGATE.managedObjectContext];
    RFSPracticeConfig.user = self;
    RFSPracticeConfig.enabled = [NSNumber numberWithBool:YES];
    RFSPracticeConfig.name = @"RFS Practice";
    RFSPracticeConfig.number_of_images_per_question = [NSNumber numberWithInt:1];
    RFSPracticeConfig.number_of_buttons = [NSNumber numberWithInt:2];
    RFSPracticeConfig.button_text_one = @"Absent";
    RFSPracticeConfig.button_text_two = @"Present";
    RFSPracticeConfig.image1_x = @22;
    RFSPracticeConfig.image1_y = @74;

    RFSPracticeConfig.button1_x = @324;
    RFSPracticeConfig.button1_y = @645;
    RFSPracticeConfig.button1_w = @175;
    RFSPracticeConfig.button1_h = @93;

    RFSPracticeConfig.button2_x = @519;
    RFSPracticeConfig.button2_y = @645;
    RFSPracticeConfig.button2_w = @180;
    RFSPracticeConfig.button2_h = @93;

    [RFSPracticeConfig installPreloadedSequence:@"rfs"];
    [RFSPracticeConfig setNQPF:1]; // 15 folders = 15 questions
    
    [self addPracticeConfigurationsObject:RFSPracticeConfig];

    RFSConfig = [NSEntityDescription insertNewObjectForEntityForName:@"TestConfiguration"
                                              inManagedObjectContext:APP_DELEGATE.managedObjectContext];
    RFSConfig.user = self;
    RFSConfig.enabled = [NSNumber numberWithBool:YES];
    RFSConfig.name = @"RFS";
    RFSConfig.number_of_images_per_question = [NSNumber numberWithInt:1];
    RFSConfig.number_of_buttons = [NSNumber numberWithInt:2];
    RFSConfig.button_text_one = @"Absent";
    RFSConfig.button_text_two = @"Present";
    RFSConfig.image1_x = @22;
    RFSConfig.image1_y = @74;

    RFSConfig.button1_x = @324;
    RFSConfig.button1_y = @645;
    RFSConfig.button1_w = @175;
    RFSConfig.button1_h = @93;

    RFSConfig.button2_x = @519;
    RFSConfig.button2_y = @645;
    RFSConfig.button2_w = @180;
    RFSConfig.button2_h = @93;
    [RFSConfig installPreloadedSequence:@"rfs"];
    [RFSConfig setNQPF:10]; // 15 folders = 150 questions

    [self addConfigurationsObject:RFSConfig];


    TestConfiguration *CalibrationConfig = [NSEntityDescription insertNewObjectForEntityForName:@"TestConfiguration"
                                                      inManagedObjectContext:APP_DELEGATE.managedObjectContext];
    CalibrationConfig.user = self;
    CalibrationConfig.enabled = [NSNumber numberWithBool:NO];
    CalibrationConfig.name = @"Calibration Configuration";
    CalibrationConfig.number_of_images_per_question = [NSNumber numberWithInt:1];
    CalibrationConfig.number_of_buttons = [NSNumber numberWithInt:1];
    CalibrationConfig.button_text_one = @"Continue";
    CalibrationConfig.images_together_presentation_time_is_infinite = [NSNumber numberWithBool:YES];
    CalibrationConfig.button1_x = @416;
    CalibrationConfig.button1_y = @645;
    CalibrationConfig.button1_w = @193;
    CalibrationConfig.button1_h = @93;
    CalibrationConfig.image1_x = @0;
    CalibrationConfig.image1_y = @0;
    [CalibrationConfig installPreloadedSequence:@"blanks"];

    CalibrationConfig.use_staircase_method = [NSNumber numberWithBool:YES];
    CalibrationConfig.num_staircases_interleaved = @1;
    CalibrationConfig.staircase_start_level = @"16";
    CalibrationConfig.staircase_num_reversals = @"1";
    CalibrationConfig.staircase_floor_ceiling_hits = @"2";
    CalibrationConfig.staircase_deltas = @"1";
    CalibrationConfig.staircase_num_correct_to_get_harder = @"1";
    CalibrationConfig.staircase_num_incorrect_to_get_easier = @"1";

    [self addConfigurationsObject:CalibrationConfig];

    GlassPracticeConfig = [NSEntityDescription insertNewObjectForEntityForName:@"TestConfiguration"
                                                inManagedObjectContext:APP_DELEGATE.managedObjectContext];
    GlassPracticeConfig.user = self;
    GlassPracticeConfig.enabled = [NSNumber numberWithBool:YES];
    GlassPracticeConfig.name = @"Glass Practice";
    GlassPracticeConfig.number_of_images_per_question = [NSNumber numberWithInt:1];
    GlassPracticeConfig.number_of_buttons = [NSNumber numberWithInt:2];
    GlassPracticeConfig.button_text_one = @"Concentric";
    GlassPracticeConfig.button_text_two = @"Radial";
    GlassPracticeConfig.images_together_presentation_time_is_infinite = [NSNumber numberWithBool:NO];
    GlassPracticeConfig.images_together_presentation_time = [NSNumber numberWithFloat:0.4];
    GlassPracticeConfig.button1_x = @30;
    GlassPracticeConfig.button1_y = @645;
    GlassPracticeConfig.button1_w = @210;
    GlassPracticeConfig.button1_h = @93;
    GlassPracticeConfig.button2_x = @826;
    GlassPracticeConfig.button2_y = @645;
    GlassPracticeConfig.button2_w = @168;
    GlassPracticeConfig.button2_h = @93;
    GlassPracticeConfig.image1_x = @267;
    GlassPracticeConfig.image1_y = @74;
    [GlassPracticeConfig installPreloadedSequence:@"glass"];
    //[GlassPracticeConfig setNQPF:1];  // 51 folders = 51 questions

    [GlassPracticeConfig setNQPFs:@{
            @"0.08": @2,
            @"0.16": @2,
            @"0.32": @2,
            @"0.48": @2,
            @"0.52": @2,
            @"0.98": @2
    }];

    [self addPracticeConfigurationsObject:GlassPracticeConfig];

    GDMPracticeConfig = [NSEntityDescription insertNewObjectForEntityForName:@"TestConfiguration"
                                                      inManagedObjectContext:APP_DELEGATE.managedObjectContext];
    GDMPracticeConfig.user = self;
    GDMPracticeConfig.enabled = [NSNumber numberWithBool:YES];
    GDMPracticeConfig.name = @"GDM Practice";
    GDMPracticeConfig.number_of_images_per_question = [NSNumber numberWithInt:1];
    GDMPracticeConfig.number_of_buttons = [NSNumber numberWithInt:2];
    GDMPracticeConfig.button_text_one = @"Left";
    GDMPracticeConfig.button_text_two = @"Right";
    [GDMPracticeConfig installPreloadedSequence:@"gdm"];
    [GDMPracticeConfig setNQPFs:@{
            @"0.08": @2,
            @"0.16": @2,
            @"0.32": @2,
            @"0.48": @2,
            @"0.52": @2,
            @"0.98": @2
    }];
    GDMPracticeConfig.button1_x = @30;
    GDMPracticeConfig.button1_y = @645;
    GDMPracticeConfig.button1_w = @145;
    GDMPracticeConfig.button1_h = @93;
    GDMPracticeConfig.button2_x = @838;
    GDMPracticeConfig.button2_y = @645;
    GDMPracticeConfig.button2_w = @159;
    GDMPracticeConfig.button2_h = @93;
    GDMPracticeConfig.image1_x = @267;
    GDMPracticeConfig.image1_y = @74;
    [self addPracticeConfigurationsObject:GDMPracticeConfig];


    GlassConfig = [NSEntityDescription insertNewObjectForEntityForName:@"TestConfiguration"
                                              inManagedObjectContext:APP_DELEGATE.managedObjectContext];
    GlassConfig.user = self;
    GlassConfig.enabled = [NSNumber numberWithBool:YES];
    GlassConfig.name = @"Glass";
    GlassConfig.number_of_images_per_question = [NSNumber numberWithInt:1];
    GlassConfig.number_of_buttons = [NSNumber numberWithInt:2];
    GlassConfig.button_text_one = @"Concentric";
    GlassConfig.button_text_two = @"Radial";
    GlassConfig.images_together_presentation_time_is_infinite = [NSNumber numberWithBool:NO];
    GlassConfig.images_together_presentation_time = [NSNumber numberWithFloat:0.4];
    GlassConfig.use_staircase_method = [NSNumber numberWithBool:YES];
    GlassConfig.staircase_start_level = @"60";
    GlassConfig.button1_x = @30;
    GlassConfig.button1_y = @645;
    GlassConfig.button1_w = @210;
    GlassConfig.button1_h = @93;
    GlassConfig.button2_x = @826;
    GlassConfig.button2_y = @645;
    GlassConfig.button2_w = @168;
    GlassConfig.button2_h = @93;
    GlassConfig.image1_x = @267;
    GlassConfig.image1_y = @74;
    GlassConfig.num_staircases_interleaved = @2;
    GlassConfig.staircase_start_level = @"60/80";
    GlassConfig.staircase_num_reversals = @"6/6";
    GlassConfig.staircase_floor_ceiling_hits = @"4/4";
    GlassConfig.staircase_deltas = @"8,4,2,2,2,2/8,4,2,2,2,2";
    GlassConfig.staircase_num_correct_to_get_harder = @"2/2";
    GlassConfig.staircase_num_incorrect_to_get_easier = @"1/1";
    [GlassConfig installPreloadedSequence:@"glass"];

    [self addConfigurationsObject:GlassConfig];


    GDMConfig = [NSEntityDescription insertNewObjectForEntityForName:@"TestConfiguration"
                                                inManagedObjectContext:APP_DELEGATE.managedObjectContext];
    GDMConfig.user = self;
    GDMConfig.enabled = [NSNumber numberWithBool:YES];
    GDMConfig.name = @"GDM";
    GDMConfig.number_of_images_per_question = [NSNumber numberWithInt:1];
    GDMConfig.number_of_buttons = [NSNumber numberWithInt:2];
    GDMConfig.button_text_one = @"Left";
    GDMConfig.button_text_two = @"Right";
    GDMConfig.use_staircase_method = [NSNumber numberWithBool:YES];
    GDMConfig.staircase_start_level = @"60";
    GDMConfig.button1_x = @30;
    GDMConfig.button1_y = @645;
    GDMConfig.button1_w = @145;
    GDMConfig.button1_h = @93;
    GDMConfig.button2_x = @838;
    GDMConfig.button2_y = @645;
    GDMConfig.button2_w = @159;
    GDMConfig.button2_h = @93;
    GDMConfig.image1_x = @267;
    GDMConfig.image1_y = @74;
    GDMConfig.num_staircases_interleaved = @2;
    GDMConfig.staircase_start_level = @"60/80";
    GDMConfig.staircase_num_reversals = @"6/6";
    GDMConfig.staircase_floor_ceiling_hits = @"4/4";
    GDMConfig.staircase_deltas = @"8,4,2,2,2,2/8,4,2,2,2,2";
    GDMConfig.staircase_num_correct_to_get_harder = @"2/2";
    GDMConfig.staircase_num_incorrect_to_get_easier = @"1/1";
    [GDMConfig installPreloadedSequence:@"gdm"];

    [self addConfigurationsObject:GDMConfig];

    [APP_DELEGATE saveContext];*/
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
