// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestSequenceImage.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class TestSequenceFolder;

@interface TestSequenceImageID : NSManagedObjectID {}
@end

@interface _TestSequenceImage : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TestSequenceImageID *objectID;

@property (nonatomic, strong, nullable) NSString* animated_images;

@property (nonatomic, strong) NSNumber* is_animated;

@property (atomic) BOOL is_animatedValue;
- (BOOL)is_animatedValue;
- (void)setIs_animatedValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* length;

@property (atomic) int32_t lengthValue;
- (int32_t)lengthValue;
- (void)setLengthValue:(int32_t)value_;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong, nullable) NSNumber* start;

@property (atomic) int64_t startValue;
- (int64_t)startValue;
- (void)setStartValue:(int64_t)value_;

@property (nonatomic, strong) TestSequenceFolder *folder;

@end

@interface _TestSequenceImage (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAnimated_images;
- (void)setPrimitiveAnimated_images:(NSString*)value;

- (NSNumber*)primitiveIs_animated;
- (void)setPrimitiveIs_animated:(NSNumber*)value;

- (BOOL)primitiveIs_animatedValue;
- (void)setPrimitiveIs_animatedValue:(BOOL)value_;

- (NSNumber*)primitiveLength;
- (void)setPrimitiveLength:(NSNumber*)value;

- (int32_t)primitiveLengthValue;
- (void)setPrimitiveLengthValue:(int32_t)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitiveStart;
- (void)setPrimitiveStart:(NSNumber*)value;

- (int64_t)primitiveStartValue;
- (void)setPrimitiveStartValue:(int64_t)value_;

- (TestSequenceFolder*)primitiveFolder;
- (void)setPrimitiveFolder:(TestSequenceFolder*)value;

@end

@interface TestSequenceImageAttributes: NSObject 
+ (NSString *)animated_images;
+ (NSString *)is_animated;
+ (NSString *)length;
+ (NSString *)name;
+ (NSString *)start;
@end

@interface TestSequenceImageRelationships: NSObject
+ (NSString *)folder;
@end

NS_ASSUME_NONNULL_END
