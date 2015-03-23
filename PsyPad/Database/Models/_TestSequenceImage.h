// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestSequenceImage.h instead.

@import CoreData;

extern const struct TestSequenceImageAttributes {
	__unsafe_unretained NSString *animated_images;
	__unsafe_unretained NSString *is_animated;
	__unsafe_unretained NSString *length;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *start;
} TestSequenceImageAttributes;

extern const struct TestSequenceImageRelationships {
	__unsafe_unretained NSString *folder;
} TestSequenceImageRelationships;

@class TestSequenceFolder;

@interface TestSequenceImageID : NSManagedObjectID {}
@end

@interface _TestSequenceImage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TestSequenceImageID* objectID;

@property (nonatomic, strong) NSString* animated_images;

//- (BOOL)validateAnimated_images:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* is_animated;

@property (atomic) BOOL is_animatedValue;
- (BOOL)is_animatedValue;
- (void)setIs_animatedValue:(BOOL)value_;

//- (BOOL)validateIs_animated:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* length;

@property (atomic) int32_t lengthValue;
- (int32_t)lengthValue;
- (void)setLengthValue:(int32_t)value_;

//- (BOOL)validateLength:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* start;

@property (atomic) int64_t startValue;
- (int64_t)startValue;
- (void)setStartValue:(int64_t)value_;

//- (BOOL)validateStart:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) TestSequenceFolder *folder;

//- (BOOL)validateFolder:(id*)value_ error:(NSError**)error_;

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
