#import "_TestSequence.h"
#import "TestSequenceImage.h"

@interface TestSequence : _TestSequence {}

- (NSString *)absolutePath;

- (TestSequenceImage *)nextImage:(unsigned short *)state;

- (TestSequenceImage *)nextImageFromFolder:(int)level withState:(unsigned short *)state;

- (void)reset;

- (UIImage *)titleImage;
- (UIImage *)backgroundImage;

@end
