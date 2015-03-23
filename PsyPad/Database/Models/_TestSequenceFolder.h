// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestSequenceFolder.h instead.

@import CoreData;

extern const struct TestSequenceFolderAttributes {
	__unsafe_unretained NSString *name;
} TestSequenceFolderAttributes;

extern const struct TestSequenceFolderRelationships {
	__unsafe_unretained NSString *images;
	__unsafe_unretained NSString *sequence;
} TestSequenceFolderRelationships;

@class TestSequenceImage;
@class TestSequence;

@interface TestSequenceFolderID : NSManagedObjectID {}
@end

@interface _TestSequenceFolder : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TestSequenceFolderID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSOrderedSet *images;

- (NSMutableOrderedSet*)imagesSet;

@property (nonatomic, strong) TestSequence *sequence;

//- (BOOL)validateSequence:(id*)value_ error:(NSError**)error_;

@end

@interface _TestSequenceFolder (ImagesCoreDataGeneratedAccessors)
- (void)addImages:(NSOrderedSet*)value_;
- (void)removeImages:(NSOrderedSet*)value_;
- (void)addImagesObject:(TestSequenceImage*)value_;
- (void)removeImagesObject:(TestSequenceImage*)value_;

- (void)insertObject:(TestSequenceImage*)value inImagesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromImagesAtIndex:(NSUInteger)idx;
- (void)insertImages:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeImagesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInImagesAtIndex:(NSUInteger)idx withObject:(TestSequenceImage*)value;
- (void)replaceImagesAtIndexes:(NSIndexSet *)indexes withImages:(NSArray *)values;

@end

@interface _TestSequenceFolder (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableOrderedSet*)primitiveImages;
- (void)setPrimitiveImages:(NSMutableOrderedSet*)value;

- (TestSequence*)primitiveSequence;
- (void)setPrimitiveSequence:(TestSequence*)value;

@end
