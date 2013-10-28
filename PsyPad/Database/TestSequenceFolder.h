//
//  TestSequenceFolder.h
//  PsyPad
//
//  Created by David Lawson on 4/12/12.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TestSequence, TestSequenceImage;

@interface TestSequenceFolder : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSOrderedSet *images;
@property (nonatomic, retain) NSOrderedSet *reorderedImages;
@property (nonatomic, retain) TestSequence *sequence;

- (TestSequenceImage *)nextImage:(unsigned short *)state;
- (void)reset;

- (void)shuffleImages:(unsigned short *)state;
@end

@interface TestSequenceFolder (CoreDataGeneratedAccessors)

- (void)insertObject:(TestSequenceImage *)value inImagesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromImagesAtIndex:(NSUInteger)idx;
- (void)insertImages:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeImagesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInImagesAtIndex:(NSUInteger)idx withObject:(TestSequenceImage *)value;
- (void)replaceImagesAtIndexes:(NSIndexSet *)indexes withImages:(NSArray *)values;
- (void)addImagesObject:(TestSequenceImage *)value;
- (void)removeImagesObject:(TestSequenceImage *)value;
- (void)addImages:(NSOrderedSet *)values;
- (void)removeImages:(NSOrderedSet *)values;

@end
