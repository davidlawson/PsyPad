// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestLog.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class TestLogItem;
@class User;

@interface TestLogID : NSManagedObjectID {}
@end

@interface _TestLog : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TestLogID *objectID;

@property (nonatomic, strong) NSDate* timestamp;

@property (nonatomic, strong) NSNumber* uploaded;

@property (atomic) BOOL uploadedValue;
- (BOOL)uploadedValue;
- (void)setUploadedValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSOrderedSet<TestLogItem*> *logitems;
- (nullable NSMutableOrderedSet<TestLogItem*>*)logitemsSet;

@property (nonatomic, strong, nullable) User *user;

@end

@interface _TestLog (LogitemsCoreDataGeneratedAccessors)
- (void)addLogitems:(NSOrderedSet<TestLogItem*>*)value_;
- (void)removeLogitems:(NSOrderedSet<TestLogItem*>*)value_;
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

- (NSMutableOrderedSet<TestLogItem*>*)primitiveLogitems;
- (void)setPrimitiveLogitems:(NSMutableOrderedSet<TestLogItem*>*)value;

- (nullable User*)primitiveUser;
- (void)setPrimitiveUser:(nullable User*)value;

@end

@interface TestLogAttributes: NSObject 
+ (NSString *)timestamp;
+ (NSString *)uploaded;
@end

@interface TestLogRelationships: NSObject
+ (NSString *)logitems;
+ (NSString *)user;
@end

NS_ASSUME_NONNULL_END
