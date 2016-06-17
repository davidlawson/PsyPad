// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestLogItem.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class TestLog;

@interface TestLogItemID : NSManagedObjectID {}
@end

@interface _TestLogItem : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TestLogItemID *objectID;

@property (nonatomic, strong, nullable) NSString* info;

@property (nonatomic, strong) NSDate* timestamp;

@property (nonatomic, strong) NSString* type;

@property (nonatomic, strong) TestLog *log;

@end

@interface _TestLogItem (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveInfo;
- (void)setPrimitiveInfo:(NSString*)value;

- (NSDate*)primitiveTimestamp;
- (void)setPrimitiveTimestamp:(NSDate*)value;

- (TestLog*)primitiveLog;
- (void)setPrimitiveLog:(TestLog*)value;

@end

@interface TestLogItemAttributes: NSObject 
+ (NSString *)info;
+ (NSString *)timestamp;
+ (NSString *)type;
@end

@interface TestLogItemRelationships: NSObject
+ (NSString *)log;
@end

NS_ASSUME_NONNULL_END
