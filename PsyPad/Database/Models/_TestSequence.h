// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestSequence.h instead.

@import CoreData;

extern const struct TestSequenceAttributes {
	__unsafe_unretained NSString *background_length;
	__unsafe_unretained NSString *background_start;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *path;
	__unsafe_unretained NSString *url;
} TestSequenceAttributes;

extern const struct TestSequenceRelationships {
	__unsafe_unretained NSString *folders;
} TestSequenceRelationships;

@class TestSequenceFolder;

@interface TestSequenceID : NSManagedObjectID {}
@end

@interface _TestSequence : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TestSequenceID* objectID;

@property (nonatomic, strong) NSNumber* background_length;

@property (atomic) int32_t background_lengthValue;
- (int32_t)background_lengthValue;
- (void)setBackground_lengthValue:(int32_t)value_;

//- (BOOL)validateBackground_length:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* background_start;

@property (atomic) int64_t background_startValue;
- (int64_t)background_startValue;
- (void)setBackground_startValue:(int64_t)value_;

//- (BOOL)validateBackground_start:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* path;

//- (BOOL)validatePath:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* url;

//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSOrderedSet *folders;

- (NSMutableOrderedSet*)foldersSet;

@end

@interface _TestSequence (FoldersCoreDataGeneratedAccessors)
- (void)addFolders:(NSOrderedSet*)value_;
- (void)removeFolders:(NSOrderedSet*)value_;
- (void)addFoldersObject:(TestSequenceFolder*)value_;
- (void)removeFoldersObject:(TestSequenceFolder*)value_;

- (void)insertObject:(TestSequenceFolder*)value inFoldersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromFoldersAtIndex:(NSUInteger)idx;
- (void)insertFolders:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeFoldersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInFoldersAtIndex:(NSUInteger)idx withObject:(TestSequenceFolder*)value;
- (void)replaceFoldersAtIndexes:(NSIndexSet *)indexes withFolders:(NSArray *)values;

@end

@interface _TestSequence (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveBackground_length;
- (void)setPrimitiveBackground_length:(NSNumber*)value;

- (int32_t)primitiveBackground_lengthValue;
- (void)setPrimitiveBackground_lengthValue:(int32_t)value_;

- (NSNumber*)primitiveBackground_start;
- (void)setPrimitiveBackground_start:(NSNumber*)value;

- (int64_t)primitiveBackground_startValue;
- (void)setPrimitiveBackground_startValue:(int64_t)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitivePath;
- (void)setPrimitivePath:(NSString*)value;

- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;

- (NSMutableOrderedSet*)primitiveFolders;
- (void)setPrimitiveFolders:(NSMutableOrderedSet*)value;

@end
