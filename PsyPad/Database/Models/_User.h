// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.h instead.

@import CoreData;

extern const struct UserAttributes {
	__unsafe_unretained NSString *id;
} UserAttributes;

extern const struct UserRelationships {
	__unsafe_unretained NSString *configurations;
	__unsafe_unretained NSString *logs;
} UserRelationships;

@class TestConfiguration;
@class TestLog;

@interface UserID : NSManagedObjectID {}
@end

@interface _User : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) UserID* objectID;

@property (nonatomic, strong) NSString* id;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSOrderedSet *configurations;

- (NSMutableOrderedSet*)configurationsSet;

@property (nonatomic, strong) NSOrderedSet *logs;

- (NSMutableOrderedSet*)logsSet;

@end

@interface _User (ConfigurationsCoreDataGeneratedAccessors)
- (void)addConfigurations:(NSOrderedSet*)value_;
- (void)removeConfigurations:(NSOrderedSet*)value_;
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
- (void)addLogs:(NSOrderedSet*)value_;
- (void)removeLogs:(NSOrderedSet*)value_;
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

- (NSMutableOrderedSet*)primitiveConfigurations;
- (void)setPrimitiveConfigurations:(NSMutableOrderedSet*)value;

- (NSMutableOrderedSet*)primitiveLogs;
- (void)setPrimitiveLogs:(NSMutableOrderedSet*)value;

@end
