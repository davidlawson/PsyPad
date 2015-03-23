#import "TestSequenceFolder.h"
#import "Random.h"

@interface TestSequenceFolder ()

// Private interface goes here.

@end

@implementation TestSequenceFolder
{
    int _nextImage;
}

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
