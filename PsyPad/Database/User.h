//
//  User.h
//  PsyPad
//
//  Created by David Lawson on 6/01/13.
//  Copyright (c) 2013 David Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TestConfiguration, TestLog;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSOrderedSet *configurations;
@property (nonatomic, retain) NSOrderedSet *logs;

+ (NSArray *)allUsers;

- (NSArray *)nonPracticeConfigurations;
- (NSArray *)practiceConfigurations;

- (NSArray *)enabledConfigurations;
- (NSArray *)enabledPracticeConfigurations;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)insertObject:(TestConfiguration *)value inConfigurationsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromConfigurationsAtIndex:(NSUInteger)idx;
- (void)insertConfigurations:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeConfigurationsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInConfigurationsAtIndex:(NSUInteger)idx withObject:(TestConfiguration *)value;
- (void)replaceConfigurationsAtIndexes:(NSIndexSet *)indexes withConfigurations:(NSArray *)values;
- (void)addConfigurationsObject:(TestConfiguration *)value;
- (void)removeConfigurationsObject:(TestConfiguration *)value;
- (void)addConfigurations:(NSOrderedSet *)values;
- (void)removeConfigurations:(NSOrderedSet *)values;

- (void)insertObject:(TestLog *)value inLogsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLogsAtIndex:(NSUInteger)idx;
- (void)insertLogs:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLogsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLogsAtIndex:(NSUInteger)idx withObject:(TestLog *)value;
- (void)replaceLogsAtIndexes:(NSIndexSet *)indexes withLogs:(NSArray *)values;
- (void)addLogsObject:(TestLog *)value;
- (void)removeLogsObject:(TestLog *)value;
- (void)addLogs:(NSOrderedSet *)values;
- (void)removeLogs:(NSOrderedSet *)values;

@end
