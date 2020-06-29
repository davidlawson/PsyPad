// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestSequence.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class TestSequenceFolder;
@class TestConfiguration;

@interface TestSequenceID : NSManagedObjectID {}
@end

@interface _TestSequence : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TestSequenceID *objectID;

@property (nonatomic, strong, nullable) NSNumber* background_length;

@property (atomic) int32_t background_lengthValue;
- (int32_t)background_lengthValue;
- (void)setBackground_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* background_start;

@property (atomic) int64_t background_startValue;
- (int64_t)background_startValue;
- (void)setBackground_startValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* button1_image_length;

@property (atomic) int32_t button1_image_lengthValue;
- (int32_t)button1_image_lengthValue;
- (void)setButton1_image_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* button1_image_start;

@property (atomic) int64_t button1_image_startValue;
- (int64_t)button1_image_startValue;
- (void)setButton1_image_startValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* button2_image_length;

@property (atomic) int32_t button2_image_lengthValue;
- (int32_t)button2_image_lengthValue;
- (void)setButton2_image_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* button2_image_start;

@property (atomic) int64_t button2_image_startValue;
- (int64_t)button2_image_startValue;
- (void)setButton2_image_startValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* button3_image_length;

@property (atomic) int32_t button3_image_lengthValue;
- (int32_t)button3_image_lengthValue;
- (void)setButton3_image_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* button3_image_start;

@property (atomic) int64_t button3_image_startValue;
- (int64_t)button3_image_startValue;
- (void)setButton3_image_startValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* button4_image_length;

@property (atomic) int32_t button4_image_lengthValue;
- (int32_t)button4_image_lengthValue;
- (void)setButton4_image_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* button4_image_start;

@property (atomic) int64_t button4_image_startValue;
- (int64_t)button4_image_startValue;
- (void)setButton4_image_startValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* correct_wav_length;

@property (atomic) int32_t correct_wav_lengthValue;
- (int32_t)correct_wav_lengthValue;
- (void)setCorrect_wav_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* correct_wav_start;

@property (atomic) int64_t correct_wav_startValue;
- (int64_t)correct_wav_startValue;
- (void)setCorrect_wav_startValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* incorrect_wav_length;

@property (atomic) int32_t incorrect_wav_lengthValue;
- (int32_t)incorrect_wav_lengthValue;
- (void)setIncorrect_wav_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* incorrect_wav_start;

@property (atomic) int64_t incorrect_wav_startValue;
- (int64_t)incorrect_wav_startValue;
- (void)setIncorrect_wav_startValue:(int64_t)value_;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong, nullable) NSNumber* off_wav_length;

@property (atomic) int32_t off_wav_lengthValue;
- (int32_t)off_wav_lengthValue;
- (void)setOff_wav_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* off_wav_start;

@property (atomic) int64_t off_wav_startValue;
- (int64_t)off_wav_startValue;
- (void)setOff_wav_startValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* on_wav_length;

@property (atomic) int32_t on_wav_lengthValue;
- (int32_t)on_wav_lengthValue;
- (void)setOn_wav_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* on_wav_start;

@property (atomic) int64_t on_wav_startValue;
- (int64_t)on_wav_startValue;
- (void)setOn_wav_startValue:(int64_t)value_;

@property (nonatomic, strong) NSString* path;

@property (nonatomic, strong, nullable) NSNumber* secondary_button1_image_length;

@property (atomic) int32_t secondary_button1_image_lengthValue;
- (int32_t)secondary_button1_image_lengthValue;
- (void)setSecondary_button1_image_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_button1_image_start;

@property (atomic) int64_t secondary_button1_image_startValue;
- (int64_t)secondary_button1_image_startValue;
- (void)setSecondary_button1_image_startValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_button2_image_length;

@property (atomic) int32_t secondary_button2_image_lengthValue;
- (int32_t)secondary_button2_image_lengthValue;
- (void)setSecondary_button2_image_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_button2_image_start;

@property (atomic) int64_t secondary_button2_image_startValue;
- (int64_t)secondary_button2_image_startValue;
- (void)setSecondary_button2_image_startValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_button3_image_length;

@property (atomic) int32_t secondary_button3_image_lengthValue;
- (int32_t)secondary_button3_image_lengthValue;
- (void)setSecondary_button3_image_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_button3_image_start;

@property (atomic) int64_t secondary_button3_image_startValue;
- (int64_t)secondary_button3_image_startValue;
- (void)setSecondary_button3_image_startValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_button4_image_length;

@property (atomic) int32_t secondary_button4_image_lengthValue;
- (int32_t)secondary_button4_image_lengthValue;
- (void)setSecondary_button4_image_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_button4_image_start;

@property (atomic) int64_t secondary_button4_image_startValue;
- (int64_t)secondary_button4_image_startValue;
- (void)setSecondary_button4_image_startValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_image1_length;

@property (atomic) int32_t secondary_image1_lengthValue;
- (int32_t)secondary_image1_lengthValue;
- (void)setSecondary_image1_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_image1_start;

@property (atomic) int64_t secondary_image1_startValue;
- (int64_t)secondary_image1_startValue;
- (void)setSecondary_image1_startValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_image2_length;

@property (atomic) int32_t secondary_image2_lengthValue;
- (int32_t)secondary_image2_lengthValue;
- (void)setSecondary_image2_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_image2_start;

@property (atomic) int64_t secondary_image2_startValue;
- (int64_t)secondary_image2_startValue;
- (void)setSecondary_image2_startValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_image3_length;

@property (atomic) int32_t secondary_image3_lengthValue;
- (int32_t)secondary_image3_lengthValue;
- (void)setSecondary_image3_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_image3_start;

@property (atomic) int64_t secondary_image3_startValue;
- (int64_t)secondary_image3_startValue;
- (void)setSecondary_image3_startValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_image4_length;

@property (atomic) int32_t secondary_image4_lengthValue;
- (int32_t)secondary_image4_lengthValue;
- (void)setSecondary_image4_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_image4_start;

@property (atomic) int64_t secondary_image4_startValue;
- (int64_t)secondary_image4_startValue;
- (void)setSecondary_image4_startValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* timeout_wav_length;

@property (atomic) int32_t timeout_wav_lengthValue;
- (int32_t)timeout_wav_lengthValue;
- (void)setTimeout_wav_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* timeout_wav_start;

@property (atomic) int64_t timeout_wav_startValue;
- (int64_t)timeout_wav_startValue;
- (void)setTimeout_wav_startValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* title_length;

@property (atomic) int32_t title_lengthValue;
- (int32_t)title_lengthValue;
- (void)setTitle_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* title_start;

@property (atomic) int64_t title_startValue;
- (int64_t)title_startValue;
- (void)setTitle_startValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSString* url;

@property (nonatomic, strong, nullable) NSOrderedSet<TestSequenceFolder*> *folders;
- (nullable NSMutableOrderedSet<TestSequenceFolder*>*)foldersSet;

@property (nonatomic, strong, nullable) NSSet<TestConfiguration*> *testConfigurations;
- (nullable NSMutableSet<TestConfiguration*>*)testConfigurationsSet;

@end

@interface _TestSequence (FoldersCoreDataGeneratedAccessors)
- (void)addFolders:(NSOrderedSet<TestSequenceFolder*>*)value_;
- (void)removeFolders:(NSOrderedSet<TestSequenceFolder*>*)value_;
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
- (void)addTestConfigurations:(NSSet<TestConfiguration*>*)value_;
- (void)removeTestConfigurations:(NSSet<TestConfiguration*>*)value_;
- (void)addTestConfigurationsObject:(TestConfiguration*)value_;
- (void)removeTestConfigurationsObject:(TestConfiguration*)value_;

@end

@interface _TestSequence (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveBackground_length;
- (void)setPrimitiveBackground_length:(nullable NSNumber*)value;

- (int32_t)primitiveBackground_lengthValue;
- (void)setPrimitiveBackground_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveBackground_start;
- (void)setPrimitiveBackground_start:(nullable NSNumber*)value;

- (int64_t)primitiveBackground_startValue;
- (void)setPrimitiveBackground_startValue:(int64_t)value_;

- (nullable NSNumber*)primitiveButton1_image_length;
- (void)setPrimitiveButton1_image_length:(nullable NSNumber*)value;

- (int32_t)primitiveButton1_image_lengthValue;
- (void)setPrimitiveButton1_image_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveButton1_image_start;
- (void)setPrimitiveButton1_image_start:(nullable NSNumber*)value;

- (int64_t)primitiveButton1_image_startValue;
- (void)setPrimitiveButton1_image_startValue:(int64_t)value_;

- (nullable NSNumber*)primitiveButton2_image_length;
- (void)setPrimitiveButton2_image_length:(nullable NSNumber*)value;

- (int32_t)primitiveButton2_image_lengthValue;
- (void)setPrimitiveButton2_image_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveButton2_image_start;
- (void)setPrimitiveButton2_image_start:(nullable NSNumber*)value;

- (int64_t)primitiveButton2_image_startValue;
- (void)setPrimitiveButton2_image_startValue:(int64_t)value_;

- (nullable NSNumber*)primitiveButton3_image_length;
- (void)setPrimitiveButton3_image_length:(nullable NSNumber*)value;

- (int32_t)primitiveButton3_image_lengthValue;
- (void)setPrimitiveButton3_image_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveButton3_image_start;
- (void)setPrimitiveButton3_image_start:(nullable NSNumber*)value;

- (int64_t)primitiveButton3_image_startValue;
- (void)setPrimitiveButton3_image_startValue:(int64_t)value_;

- (nullable NSNumber*)primitiveButton4_image_length;
- (void)setPrimitiveButton4_image_length:(nullable NSNumber*)value;

- (int32_t)primitiveButton4_image_lengthValue;
- (void)setPrimitiveButton4_image_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveButton4_image_start;
- (void)setPrimitiveButton4_image_start:(nullable NSNumber*)value;

- (int64_t)primitiveButton4_image_startValue;
- (void)setPrimitiveButton4_image_startValue:(int64_t)value_;

- (nullable NSNumber*)primitiveCorrect_wav_length;
- (void)setPrimitiveCorrect_wav_length:(nullable NSNumber*)value;

- (int32_t)primitiveCorrect_wav_lengthValue;
- (void)setPrimitiveCorrect_wav_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveCorrect_wav_start;
- (void)setPrimitiveCorrect_wav_start:(nullable NSNumber*)value;

- (int64_t)primitiveCorrect_wav_startValue;
- (void)setPrimitiveCorrect_wav_startValue:(int64_t)value_;

- (nullable NSNumber*)primitiveIncorrect_wav_length;
- (void)setPrimitiveIncorrect_wav_length:(nullable NSNumber*)value;

- (int32_t)primitiveIncorrect_wav_lengthValue;
- (void)setPrimitiveIncorrect_wav_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveIncorrect_wav_start;
- (void)setPrimitiveIncorrect_wav_start:(nullable NSNumber*)value;

- (int64_t)primitiveIncorrect_wav_startValue;
- (void)setPrimitiveIncorrect_wav_startValue:(int64_t)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (nullable NSNumber*)primitiveOff_wav_length;
- (void)setPrimitiveOff_wav_length:(nullable NSNumber*)value;

- (int32_t)primitiveOff_wav_lengthValue;
- (void)setPrimitiveOff_wav_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveOff_wav_start;
- (void)setPrimitiveOff_wav_start:(nullable NSNumber*)value;

- (int64_t)primitiveOff_wav_startValue;
- (void)setPrimitiveOff_wav_startValue:(int64_t)value_;

- (nullable NSNumber*)primitiveOn_wav_length;
- (void)setPrimitiveOn_wav_length:(nullable NSNumber*)value;

- (int32_t)primitiveOn_wav_lengthValue;
- (void)setPrimitiveOn_wav_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveOn_wav_start;
- (void)setPrimitiveOn_wav_start:(nullable NSNumber*)value;

- (int64_t)primitiveOn_wav_startValue;
- (void)setPrimitiveOn_wav_startValue:(int64_t)value_;

- (NSString*)primitivePath;
- (void)setPrimitivePath:(NSString*)value;

- (nullable NSNumber*)primitiveSecondary_button1_image_length;
- (void)setPrimitiveSecondary_button1_image_length:(nullable NSNumber*)value;

- (int32_t)primitiveSecondary_button1_image_lengthValue;
- (void)setPrimitiveSecondary_button1_image_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveSecondary_button1_image_start;
- (void)setPrimitiveSecondary_button1_image_start:(nullable NSNumber*)value;

- (int64_t)primitiveSecondary_button1_image_startValue;
- (void)setPrimitiveSecondary_button1_image_startValue:(int64_t)value_;

- (nullable NSNumber*)primitiveSecondary_button2_image_length;
- (void)setPrimitiveSecondary_button2_image_length:(nullable NSNumber*)value;

- (int32_t)primitiveSecondary_button2_image_lengthValue;
- (void)setPrimitiveSecondary_button2_image_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveSecondary_button2_image_start;
- (void)setPrimitiveSecondary_button2_image_start:(nullable NSNumber*)value;

- (int64_t)primitiveSecondary_button2_image_startValue;
- (void)setPrimitiveSecondary_button2_image_startValue:(int64_t)value_;

- (nullable NSNumber*)primitiveSecondary_button3_image_length;
- (void)setPrimitiveSecondary_button3_image_length:(nullable NSNumber*)value;

- (int32_t)primitiveSecondary_button3_image_lengthValue;
- (void)setPrimitiveSecondary_button3_image_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveSecondary_button3_image_start;
- (void)setPrimitiveSecondary_button3_image_start:(nullable NSNumber*)value;

- (int64_t)primitiveSecondary_button3_image_startValue;
- (void)setPrimitiveSecondary_button3_image_startValue:(int64_t)value_;

- (nullable NSNumber*)primitiveSecondary_button4_image_length;
- (void)setPrimitiveSecondary_button4_image_length:(nullable NSNumber*)value;

- (int32_t)primitiveSecondary_button4_image_lengthValue;
- (void)setPrimitiveSecondary_button4_image_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveSecondary_button4_image_start;
- (void)setPrimitiveSecondary_button4_image_start:(nullable NSNumber*)value;

- (int64_t)primitiveSecondary_button4_image_startValue;
- (void)setPrimitiveSecondary_button4_image_startValue:(int64_t)value_;

- (nullable NSNumber*)primitiveSecondary_image1_length;
- (void)setPrimitiveSecondary_image1_length:(nullable NSNumber*)value;

- (int32_t)primitiveSecondary_image1_lengthValue;
- (void)setPrimitiveSecondary_image1_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveSecondary_image1_start;
- (void)setPrimitiveSecondary_image1_start:(nullable NSNumber*)value;

- (int64_t)primitiveSecondary_image1_startValue;
- (void)setPrimitiveSecondary_image1_startValue:(int64_t)value_;

- (nullable NSNumber*)primitiveSecondary_image2_length;
- (void)setPrimitiveSecondary_image2_length:(nullable NSNumber*)value;

- (int32_t)primitiveSecondary_image2_lengthValue;
- (void)setPrimitiveSecondary_image2_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveSecondary_image2_start;
- (void)setPrimitiveSecondary_image2_start:(nullable NSNumber*)value;

- (int64_t)primitiveSecondary_image2_startValue;
- (void)setPrimitiveSecondary_image2_startValue:(int64_t)value_;

- (nullable NSNumber*)primitiveSecondary_image3_length;
- (void)setPrimitiveSecondary_image3_length:(nullable NSNumber*)value;

- (int32_t)primitiveSecondary_image3_lengthValue;
- (void)setPrimitiveSecondary_image3_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveSecondary_image3_start;
- (void)setPrimitiveSecondary_image3_start:(nullable NSNumber*)value;

- (int64_t)primitiveSecondary_image3_startValue;
- (void)setPrimitiveSecondary_image3_startValue:(int64_t)value_;

- (nullable NSNumber*)primitiveSecondary_image4_length;
- (void)setPrimitiveSecondary_image4_length:(nullable NSNumber*)value;

- (int32_t)primitiveSecondary_image4_lengthValue;
- (void)setPrimitiveSecondary_image4_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveSecondary_image4_start;
- (void)setPrimitiveSecondary_image4_start:(nullable NSNumber*)value;

- (int64_t)primitiveSecondary_image4_startValue;
- (void)setPrimitiveSecondary_image4_startValue:(int64_t)value_;

- (nullable NSNumber*)primitiveTimeout_wav_length;
- (void)setPrimitiveTimeout_wav_length:(nullable NSNumber*)value;

- (int32_t)primitiveTimeout_wav_lengthValue;
- (void)setPrimitiveTimeout_wav_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveTimeout_wav_start;
- (void)setPrimitiveTimeout_wav_start:(nullable NSNumber*)value;

- (int64_t)primitiveTimeout_wav_startValue;
- (void)setPrimitiveTimeout_wav_startValue:(int64_t)value_;

- (nullable NSNumber*)primitiveTitle_length;
- (void)setPrimitiveTitle_length:(nullable NSNumber*)value;

- (int32_t)primitiveTitle_lengthValue;
- (void)setPrimitiveTitle_lengthValue:(int32_t)value_;

- (nullable NSNumber*)primitiveTitle_start;
- (void)setPrimitiveTitle_start:(nullable NSNumber*)value;

- (int64_t)primitiveTitle_startValue;
- (void)setPrimitiveTitle_startValue:(int64_t)value_;

- (nullable NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(nullable NSString*)value;

- (NSMutableOrderedSet<TestSequenceFolder*>*)primitiveFolders;
- (void)setPrimitiveFolders:(NSMutableOrderedSet<TestSequenceFolder*>*)value;

- (NSMutableSet<TestConfiguration*>*)primitiveTestConfigurations;
- (void)setPrimitiveTestConfigurations:(NSMutableSet<TestConfiguration*>*)value;

@end

@interface TestSequenceAttributes: NSObject 
+ (NSString *)background_length;
+ (NSString *)background_start;
+ (NSString *)button1_image_length;
+ (NSString *)button1_image_start;
+ (NSString *)button2_image_length;
+ (NSString *)button2_image_start;
+ (NSString *)button3_image_length;
+ (NSString *)button3_image_start;
+ (NSString *)button4_image_length;
+ (NSString *)button4_image_start;
+ (NSString *)correct_wav_length;
+ (NSString *)correct_wav_start;
+ (NSString *)incorrect_wav_length;
+ (NSString *)incorrect_wav_start;
+ (NSString *)name;
+ (NSString *)off_wav_length;
+ (NSString *)off_wav_start;
+ (NSString *)on_wav_length;
+ (NSString *)on_wav_start;
+ (NSString *)path;
+ (NSString *)secondary_button1_image_length;
+ (NSString *)secondary_button1_image_start;
+ (NSString *)secondary_button2_image_length;
+ (NSString *)secondary_button2_image_start;
+ (NSString *)secondary_button3_image_length;
+ (NSString *)secondary_button3_image_start;
+ (NSString *)secondary_button4_image_length;
+ (NSString *)secondary_button4_image_start;
+ (NSString *)secondary_image1_length;
+ (NSString *)secondary_image1_start;
+ (NSString *)secondary_image2_length;
+ (NSString *)secondary_image2_start;
+ (NSString *)secondary_image3_length;
+ (NSString *)secondary_image3_start;
+ (NSString *)secondary_image4_length;
+ (NSString *)secondary_image4_start;
+ (NSString *)timeout_wav_length;
+ (NSString *)timeout_wav_start;
+ (NSString *)title_length;
+ (NSString *)title_start;
+ (NSString *)url;
@end

@interface TestSequenceRelationships: NSObject
+ (NSString *)folders;
+ (NSString *)testConfigurations;
@end

NS_ASSUME_NONNULL_END
