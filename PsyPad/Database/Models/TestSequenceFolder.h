#import "_TestSequenceFolder.h"

@interface TestSequenceFolder : _TestSequenceFolder {}

@property (nonatomic, retain) NSOrderedSet *reorderedImages;

- (TestSequenceImage *)nextImage:(unsigned short *)state;
- (void)reset;

- (void)shuffleImages:(unsigned short *)state;

@end
