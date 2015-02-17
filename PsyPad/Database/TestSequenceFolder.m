//
//  TestSequenceFolder.m
//  PsyPad
//
//  Created by David Lawson on 4/12/12.
//

#import "TestSequenceFolder.h"
#import "TestSequence.h"
#import "TestSequenceImage.h"
#import "Random.h"

@implementation TestSequenceFolder
{
    int _nextImage;
}

@dynamic name;
@dynamic images;
@dynamic sequence;

@synthesize reorderedImages = _reorderedImages;

- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    if (self)
    {
        _nextImage = 0;
    }

    return self;
}

- (TestSequenceImage *)nextImage:(unsigned short *)state
{
    if (_nextImage % self.images.count == 0)
        [self shuffleImages:state];

    return [self.reorderedImages objectAtIndex:(NSUInteger)_nextImage++ % self.images.count];
}

- (void)reset
{
    _nextImage = 0;
    self.reorderedImages = nil;
}


- (void)addImagesObject:(TestSequenceImage *)value
{
    NSMutableOrderedSet *tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.images];
    [tempSet addObject:value];
    self.images = tempSet;
}

- (void)removeImagesObject:(TestSequenceImage *)value
{
    NSMutableOrderedSet *tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.images];
    [tempSet removeObject:value];
    self.images = tempSet;
}

- (void)addImages:(NSOrderedSet *)values
{
    NSMutableOrderedSet *tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.images];
    for (TestSequenceImage *image in values)
    {
        [tempSet addObject:image];
    }
    self.images = tempSet;
}

// Fisher-Yates shuffle
- (void)shuffleImages:(unsigned short *)state
{
    NSMutableOrderedSet *newSet = [self.images mutableCopy];

    for (int i = (int)newSet.count - 1; i >= 0; i--)
    {
        int j = [Random randiFrom:0 to:i withState:state];

        [newSet exchangeObjectAtIndex:(NSUInteger)i withObjectAtIndex:(NSUInteger)j];
    }

    self.reorderedImages = newSet;
}

@end
