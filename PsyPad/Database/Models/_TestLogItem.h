// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestLogItem.h instead.

@import CoreData;

extern const struct TestLogItemAttributes {
	__unsafe_unretained NSString *info;
	__unsafe_unretained NSString *timestamp;
	__unsafe_unretained NSString *type;
} TestLogItemAttributes;

extern const struct TestLogItemRelationships {
	__unsafe_unretained NSString *log;
} TestLogItemRelationships;

@class TestLog;

@interface TestLogItemID : NSManagedObjectID {}
@end

@interface _TestLogItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TestLogItemID* objectID;

@property (nonatomic, strong) NSString* info;

//- (BOOL)validateInfo:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* timestamp;

//- (BOOL)validateTimestamp:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* type;

//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) TestLog *log;

//- (BOOL)validateLog:(id*)value_ error:(NSError**)error_;

@end

@interface _TestLogItem (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveInfo;
- (void)setPrimitiveInfo:(NSString*)value;

- (NSDate*)primitiveTimestamp;
- (void)setPrimitiveTimestamp:(NSDate*)value;

- (TestLog*)primitiveLog;
- (void)setPrimitiveLog:(TestLog*)value;

@end
