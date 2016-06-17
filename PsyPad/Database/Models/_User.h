// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class TestConfiguration;
@class TestLog;

@interface UserID : NSManagedObjectID {}
@end

@interface _User : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) UserID *objectID;

@property (nonatomic, strong) NSString* id;

@property (nonatomic, strong, nullable) NSOrderedSet<TestConfiguration*> *configurations;
- (nullable NSMutableOrderedSet<TestConfiguration*>*)configurationsSet;

@property (nonatomic, strong, nullable) NSOrderedSet<TestLog*> *logs;
- (nullable NSMutableOrderedSet<TestLog*>*)logsSet;

@end

@interface _User (ConfigurationsCoreDataGeneratedAccessors)
- (void)addConfigurations:(NSOrderedSet<TestConfiguration*>*)value_;
- (void)removeConfigurations:(NSOrderedSet<TestConfiguration*>*)value_;
- (void)addConfigurationsObject:(TestConfiguration*)value_;
- (void)removeConfigurationsObject:(TestConfiguration*)value_;

- (void)insertObject:(TestConfiguration*)value inConfigurationsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromConfigurationsAtIndex:(NSUInteger)idx;
- (void)insertConfigurations:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeConfigurationsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInConfigurationsAtIndex:(NSUInteger)idx withObject:(TestConfiguration*)value;
- (void)replaceConfigurationsAtIndexes:(NSIndexSet *)indexes withConfigurations:(NSArray *)values;

@end

@interface _User (LogsCoreDataGeneratedAccessors)
- (void)addLogs:(NSOrderedSet<TestLog*>*)value_;
- (void)removeLogs:(NSOrderedSet<TestLog*>*)value_;
- (void)addLogsObject:(TestLog*)value_;
- (void)removeLogsObject:(TestLog*)value_;

- (void)insertObject:(TestLog*)value inLogsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLogsAtIndex:(NSUInteger)idx;
- (void)insertLogs:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLogsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLogsAtIndex:(NSUInteger)idx withObject:(TestLog*)value;
- (void)replaceLogsAtIndexes:(NSIndexSet *)indexes withLogs:(NSArray *)values;

@end

@interface _User (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveId;
- (void)setPrimitiveId:(NSString*)value;

- (NSMutableOrderedSet<TestConfiguration*>*)primitiveConfigurations;
- (void)setPrimitiveConfigurations:(NSMutableOrderedSet<TestConfiguration*>*)value;

- (NSMutableOrderedSet<TestLog*>*)primitiveLogs;
- (void)setPrimitiveLogs:(NSMutableOrderedSet<TestLog*>*)value;

@end

@interface UserAttributes: NSObject 
+ (NSString *)id;
@end

@interface UserRelationships: NSObject
+ (NSString *)configurations;
+ (NSString *)logs;
@end

NS_ASSUME_NONNULL_END
