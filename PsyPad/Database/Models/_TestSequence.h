// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestSequence.h instead.

@import CoreData;

extern const struct TestSequenceAttributes {
	__unsafe_unretained NSString *background_length;
	__unsafe_unretained NSString *background_start;
	__unsafe_unretained NSString *correct_wav_length;
	__unsafe_unretained NSString *correct_wav_start;
	__unsafe_unretained NSString *incorrect_wav_length;
	__unsafe_unretained NSString *incorrect_wav_start;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *off_wav_length;
	__unsafe_unretained NSString *off_wav_start;
	__unsafe_unretained NSString *on_wav_length;
	__unsafe_unretained NSString *on_wav_start;
	__unsafe_unretained NSString *path;
	__unsafe_unretained NSString *timeout_wav_length;
	__unsafe_unretained NSString *timeout_wav_start;
	__unsafe_unretained NSString *title_length;
	__unsafe_unretained NSString *title_start;
	__unsafe_unretained NSString *url;
} TestSequenceAttributes;

extern const struct TestSequenceRelationships {
	__unsafe_unretained NSString *folders;
	__unsafe_unretained NSString *testConfigurations;
} TestSequenceRelationships;

@class TestSequenceFolder;
@class TestConfiguration;

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

@property (nonatomic, strong) NSNumber* correct_wav_length;

@property (atomic) int32_t correct_wav_lengthValue;
- (int32_t)correct_wav_lengthValue;
- (void)setCorrect_wav_lengthValue:(int32_t)value_;

//- (BOOL)validateCorrect_wav_length:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* correct_wav_start;

@property (atomic) int64_t correct_wav_startValue;
- (int64_t)correct_wav_startValue;
- (void)setCorrect_wav_startValue:(int64_t)value_;

//- (BOOL)validateCorrect_wav_start:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* incorrect_wav_length;

@property (atomic) int32_t incorrect_wav_lengthValue;
- (int32_t)incorrect_wav_lengthValue;
- (void)setIncorrect_wav_lengthValue:(int32_t)value_;

//- (BOOL)validateIncorrect_wav_length:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* incorrect_wav_start;

@property (atomic) int64_t incorrect_wav_startValue;
- (int64_t)incorrect_wav_startValue;
- (void)setIncorrect_wav_startValue:(int64_t)value_;

//- (BOOL)validateIncorrect_wav_start:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* off_wav_length;

@property (atomic) int32_t off_wav_lengthValue;
- (int32_t)off_wav_lengthValue;
- (void)setOff_wav_lengthValue:(int32_t)value_;

//- (BOOL)validateOff_wav_length:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* off_wav_start;

@property (atomic) int64_t off_wav_startValue;
- (int64_t)off_wav_startValue;
- (void)setOff_wav_startValue:(int64_t)value_;

//- (BOOL)validateOff_wav_start:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* on_wav_length;

@property (atomic) int32_t on_wav_lengthValue;
- (int32_t)on_wav_lengthValue;
- (void)setOn_wav_lengthValue:(int32_t)value_;

//- (BOOL)validateOn_wav_length:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* on_wav_start;

@property (atomic) int64_t on_wav_startValue;
- (int64_t)on_wav_startValue;
- (void)setOn_wav_startValue:(int64_t)value_;

//- (BOOL)validateOn_wav_start:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* path;

//- (BOOL)validatePath:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* timeout_wav_length;

@property (atomic) int32_t timeout_wav_lengthValue;
- (int32_t)timeout_wav_lengthValue;
- (void)setTimeout_wav_lengthValue:(int32_t)value_;

//- (BOOL)validateTimeout_wav_length:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* timeout_wav_start;

@property (atomic) int64_t timeout_wav_startValue;
- (int64_t)timeout_wav_startValue;
- (void)setTimeout_wav_startValue:(int64_t)value_;

//- (BOOL)validateTimeout_wav_start:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* title_length;

@property (atomic) int32_t title_lengthValue;
- (int32_t)title_lengthValue;
- (void)setTitle_lengthValue:(int32_t)value_;

//- (BOOL)validateTitle_length:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* title_start;

@property (atomic) int64_t title_startValue;
- (int64_t)title_startValue;
- (void)setTitle_startValue:(int64_t)value_;

//- (BOOL)validateTitle_start:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* url;

//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSOrderedSet *folders;

- (NSMutableOrderedSet*)foldersSet;

@property (nonatomic, strong) NSSet *testConfigurations;

- (NSMutableSet*)testConfigurationsSet;

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

@interface _TestSequence (TestConfigurationsCoreDataGeneratedAccessors)
- (void)addTestConfigurations:(NSSet*)value_;
- (void)removeTestConfigurations:(NSSet*)value_;
- (void)addTestConfigurationsObject:(TestConfiguration*)value_;
- (void)removeTestConfigurationsObject:(TestConfiguration*)value_;

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

- (NSNumber*)primitiveCorrect_wav_length;
- (void)setPrimitiveCorrect_wav_length:(NSNumber*)value;

- (int32_t)primitiveCorrect_wav_lengthValue;
- (void)setPrimitiveCorrect_wav_lengthValue:(int32_t)value_;

- (NSNumber*)primitiveCorrect_wav_start;
- (void)setPrimitiveCorrect_wav_start:(NSNumber*)value;

- (int64_t)primitiveCorrect_wav_startValue;
- (void)setPrimitiveCorrect_wav_startValue:(int64_t)value_;

- (NSNumber*)primitiveIncorrect_wav_length;
- (void)setPrimitiveIncorrect_wav_length:(NSNumber*)value;

- (int32_t)primitiveIncorrect_wav_lengthValue;
- (void)setPrimitiveIncorrect_wav_lengthValue:(int32_t)value_;

- (NSNumber*)primitiveIncorrect_wav_start;
- (void)setPrimitiveIncorrect_wav_start:(NSNumber*)value;

- (int64_t)primitiveIncorrect_wav_startValue;
- (void)setPrimitiveIncorrect_wav_startValue:(int64_t)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitiveOff_wav_length;
- (void)setPrimitiveOff_wav_length:(NSNumber*)value;

- (int32_t)primitiveOff_wav_lengthValue;
- (void)setPrimitiveOff_wav_lengthValue:(int32_t)value_;

- (NSNumber*)primitiveOff_wav_start;
- (void)setPrimitiveOff_wav_start:(NSNumber*)value;

- (int64_t)primitiveOff_wav_startValue;
- (void)setPrimitiveOff_wav_startValue:(int64_t)value_;

- (NSNumber*)primitiveOn_wav_length;
- (void)setPrimitiveOn_wav_length:(NSNumber*)value;

- (int32_t)primitiveOn_wav_lengthValue;
- (void)setPrimitiveOn_wav_lengthValue:(int32_t)value_;

- (NSNumber*)primitiveOn_wav_start;
- (void)setPrimitiveOn_wav_start:(NSNumber*)value;

- (int64_t)primitiveOn_wav_startValue;
- (void)setPrimitiveOn_wav_startValue:(int64_t)value_;

- (NSString*)primitivePath;
- (void)setPrimitivePath:(NSString*)value;

- (NSNumber*)primitiveTimeout_wav_length;
- (void)setPrimitiveTimeout_wav_length:(NSNumber*)value;

- (int32_t)primitiveTimeout_wav_lengthValue;
- (void)setPrimitiveTimeout_wav_lengthValue:(int32_t)value_;

- (NSNumber*)primitiveTimeout_wav_start;
- (void)setPrimitiveTimeout_wav_start:(NSNumber*)value;

- (int64_t)primitiveTimeout_wav_startValue;
- (void)setPrimitiveTimeout_wav_startValue:(int64_t)value_;

- (NSNumber*)primitiveTitle_length;
- (void)setPrimitiveTitle_length:(NSNumber*)value;

- (int32_t)primitiveTitle_lengthValue;
- (void)setPrimitiveTitle_lengthValue:(int32_t)value_;

- (NSNumber*)primitiveTitle_start;
- (void)setPrimitiveTitle_start:(NSNumber*)value;

- (int64_t)primitiveTitle_startValue;
- (void)setPrimitiveTitle_startValue:(int64_t)value_;

- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;

- (NSMutableOrderedSet*)primitiveFolders;
- (void)setPrimitiveFolders:(NSMutableOrderedSet*)value;

- (NSMutableSet*)primitiveTestConfigurations;
- (void)setPrimitiveTestConfigurations:(NSMutableSet*)value;

@end
