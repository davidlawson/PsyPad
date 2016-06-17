// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestSequenceFolder.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class TestSequenceImage;
@class TestSequence;

@interface TestSequenceFolderID : NSManagedObjectID {}
@end

@interface _TestSequenceFolder : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TestSequenceFolderID *objectID;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong, nullable) NSOrderedSet<TestSequenceImage*> *images;
- (nullable NSMutableOrderedSet<TestSequenceImage*>*)imagesSet;

@property (nonatomic, strong) TestSequence *sequence;

@end

@interface _TestSequenceFolder (ImagesCoreDataGeneratedAccessors)
- (void)addImages:(NSOrderedSet<TestSequenceImage*>*)value_;
- (void)removeImages:(NSOrderedSet<TestSequenceImage*>*)value_;
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

- (NSMutableOrderedSet<TestSequenceImage*>*)primitiveImages;
- (void)setPrimitiveImages:(NSMutableOrderedSet<TestSequenceImage*>*)value;

- (TestSequence*)primitiveSequence;
- (void)setPrimitiveSequence:(TestSequence*)value;

@end

@interface TestSequenceFolderAttributes: NSObject 
+ (NSString *)name;
@end

@interface TestSequenceFolderRelationships: NSObject
+ (NSString *)images;
+ (NSString *)sequence;
@end

NS_ASSUME_NONNULL_END
