// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestLog.h instead.

@import CoreData;

extern const struct TestLogAttributes {
	__unsafe_unretained NSString *timestamp;
	__unsafe_unretained NSString *uploaded;
} TestLogAttributes;

extern const struct TestLogRelationships {
	__unsafe_unretained NSString *logitems;
	__unsafe_unretained NSString *user;
} TestLogRelationships;

@class TestLogItem;
@class User;

@interface TestLogID : NSManagedObjectID {}
@end

@interface _TestLog : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TestLogID* objectID;

@property (nonatomic, strong) NSDate* timestamp;

//- (BOOL)validateTimestamp:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* uploaded;

@property (atomic) BOOL uploadedValue;
- (BOOL)uploadedValue;
- (void)setUploadedValue:(BOOL)value_;

//- (BOOL)validateUploaded:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSOrderedSet *logitems;

- (NSMutableOrderedSet*)logitemsSet;

@property (nonatomic, strong) User *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@end

@interface _TestLog (LogitemsCoreDataGeneratedAccessors)
- (void)addLogitems:(NSOrderedSet*)value_;
- (void)removeLogitems:(NSOrderedSet*)value_;
- (void)addLogitemsObject:(TestLogItem*)value_;
- (void)removeLogitemsObject:(TestLogItem*)value_;

- (void)insertObject:(TestLogItem*)value inLogitemsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLogitemsAtIndex:(NSUInteger)idx;
- (void)insertLogitems:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLogitemsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLogitemsAtIndex:(NSUInteger)idx withObject:(TestLogItem*)value;
- (void)replaceLogitemsAtIndexes:(NSIndexSet *)indexes withLogitems:(NSArray *)values;

@end

@interface _TestLog (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveTimestamp;
- (void)setPrimitiveTimestamp:(NSDate*)value;

- (NSNumber*)primitiveUploaded;
- (void)setPrimitiveUploaded:(NSNumber*)value;

- (BOOL)primitiveUploadedValue;
- (void)setPrimitiveUploadedValue:(BOOL)value_;

- (NSMutableOrderedSet*)primitiveLogitems;
- (void)setPrimitiveLogitems:(NSMutableOrderedSet*)value;

- (User*)primitiveUser;
- (void)setPrimitiveUser:(User*)value;

@end
