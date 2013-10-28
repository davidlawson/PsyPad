//
//  TestSequence.h
//  eTASM
//
//  Created by David Lawson on 4/12/12.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TestSequenceFolder;
@class TestSequenceImage;

@interface TestSequence : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSOrderedSet *folders;

- (TestSequenceImage *)nextImage:(unsigned short *)state;

- (TestSequenceImage *)nextImageFromFolder:(int)level withState:(unsigned short *)state;

- (void)reset;

@end

@interface TestSequence (CoreDataGeneratedAccessors)

- (void)insertObject:(TestSequenceFolder *)value inFoldersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromFoldersAtIndex:(NSUInteger)idx;
- (void)insertFolders:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeFoldersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInFoldersAtIndex:(NSUInteger)idx withObject:(TestSequenceFolder *)value;
- (void)replaceFoldersAtIndexes:(NSIndexSet *)indexes withFolders:(NSArray *)values;
- (void)addFoldersObject:(TestSequenceFolder *)value;
- (void)removeFoldersObject:(TestSequenceFolder *)value;
- (void)addFolders:(NSOrderedSet *)values;
- (void)removeFolders:(NSOrderedSet *)values;

@end
