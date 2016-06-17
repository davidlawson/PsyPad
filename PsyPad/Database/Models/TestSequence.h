#import "_TestSequence.h"
#import "TestSequenceImage.h"

@interface TestSequence : _TestSequence {}

- (NSString *)absolutePath;

- (TestSequenceImage *)nextImage:(unsigned short *)state;

- (TestSequenceImage *)nextImageFromFolder:(int)level withState:(unsigned short *)state;

- (void)reset;

- (UIImage *)titleImage;
- (UIImage *)backgroundImage;

- (NSData *)correctWAVData;
- (NSData *)incorrectWAVData;
- (NSData *)onWAVData;
- (NSData *)offWAVData;
- (NSData *)timeoutWAVData;

- (UIImage *)button1Image;
- (UIImage *)button2Image;
- (UIImage *)button3Image;
- (UIImage *)button4Image;

- (UIImage *)secondaryButton1Image;
- (UIImage *)secondaryButton2Image;
- (UIImage *)secondaryButton3Image;
- (UIImage *)secondaryButton4Image;

- (UIImage *)secondaryImage1;
- (UIImage *)secondaryImage2;
- (UIImage *)secondaryImage3;
- (UIImage *)secondaryImage4;

@end
