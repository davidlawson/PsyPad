//
//  TestLog.h
//  eTASM
//
//  Created by David Lawson on 13/12/12.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User, TestLogItem;

@interface TestLog : NSManagedObject

@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSOrderedSet *logitems;
@property (nonatomic, retain) User *user;

- (NSString *)getConfigName;
@end

@interface TestLog (CoreDataGeneratedAccessors)

- (void)insertObject:(TestLogItem *)value inLogitemsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLogitemsAtIndex:(NSUInteger)idx;
- (void)insertLogitems:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLogitemsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLogitemsAtIndex:(NSUInteger)idx withObject:(TestLogItem *)value;
- (void)replaceLogitemsAtIndexes:(NSIndexSet *)indexes withLogitems:(NSArray *)values;
- (void)addLogitemsObject:(TestLogItem *)value;
- (void)removeLogitemsObject:(TestLogItem *)value;
- (void)addLogitems:(NSOrderedSet *)values;
- (void)removeLogitems:(NSOrderedSet *)values;

@end
