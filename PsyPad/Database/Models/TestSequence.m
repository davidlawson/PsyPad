#import "TestSequence.h"
#import "NSURL+CommonURLs.h"
#import "TestSequenceImage.h"
#import "TestSequenceFolder.h"
#import "DatabaseManager.h"
#import <sys/mman.h>

@interface TestSequence ()

// Private interface goes here.

@end

@implementation TestSequence
{
    int _nextFolder;
}

- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    if (self)
    {
        _nextFolder = 0;
    }

    return self;
}

- (NSString *)absolutePath
{
    return [[NSURL documentsDirectory].path stringByAppendingPathComponent:self.path.lastPathComponent];
}

- (TestSequenceImage *)nextImage:(unsigned short *)state
{
    TestSequenceFolder *nextFolder = [self.folders objectAtIndex:(NSUInteger)_nextFolder++ % self.folders.count];
    return [nextFolder nextImage:state];
}

- (TestSequenceImage *)nextImageFromFolder:(int)level withState:(unsigned short *)state
{
    for (TestSequenceFolder *folder in self.folders)
    {
        NSString *wanted = [NSString stringWithFormat:@"%d", level];
        if ([folder.name isEqualToString:wanted])
        {
            return [folder nextImage:state];
        }
    }

    return nil; // folder not found
}

- (void)reset
{
    _nextFolder = 0;
    for (TestSequenceFolder *folder in self.folders)
    {
        [folder reset];
    }
}

- (void)prepareForDeletion
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.absolutePath])
    {
        NSLog(@"deletingsequencefiles");
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:self.absolutePath error:&error];
        
        if (error)
        {
            NSLog(@"Error deleting files: %@", [error localizedDescription]);
        }
    }

    [super prepareForDeletion];
}

- (NSData *)mappedDataWithStart:(long)start length:(size_t)length description:(NSString *)description
{
    FILE *file;
    
    file = fopen([self.absolutePath cStringUsingEncoding:NSASCIIStringEncoding], "rb");
    
    if (file == NULL)
    {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:[NSString stringWithFormat:@"Failed to open %@", description]
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];
        self.url = nil;
        [DatabaseManager save];
        return nil;
    }
    
    int fd = fileno(file);
    
    long page_start = start - (start % getpagesize());
    long offset = start - page_start;
    
    void *data = mmap(NULL, offset + length, PROT_READ, MAP_SHARED, fd, page_start);
    
    NSData *nsData = [NSData dataWithBytes:data + offset length:length];
    
    munmap(data, length);
    
    fclose(file);
    
    return nsData;
}

- (UIImage *)backgroundImage
{
    if (!self.background_start || !self.background_length) return nil;

    NSData *image_data = [self mappedDataWithStart:self.background_start.longValue length:self.background_length.intValue description:@"image set while loading background image"];

    if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
        return [UIImage imageWithData:image_data scale:2];
    else
        return [UIImage imageWithData:image_data];

}

- (UIImage *)titleImage
{
    if (!self.title_start || !self.title_length) return nil;
    
    NSData *image_data = [self mappedDataWithStart:self.title_start.longValue length:self.title_length.intValue description:@"image set while loading title image"];
    
    if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
        return [UIImage imageWithData:image_data scale:2];
    else
        return [UIImage imageWithData:image_data];
    
}

- (NSData *)correctWAVData
{
    if (!self.correct_wav_start || !self.correct_wav_length) return nil;
    
    return [self mappedDataWithStart:self.correct_wav_start.longValue length:self.correct_wav_length.intValue description:@"image set while loading 'correct button' audio file"];
}

- (NSData *)incorrectWAVData
{
    if (!self.incorrect_wav_start || !self.incorrect_wav_length) return nil;
    
    return [self mappedDataWithStart:self.incorrect_wav_start.longValue length:self.incorrect_wav_length.intValue description:@"image set while loading 'incorrect button' audio file"];
}

- (NSData *)onWAVData
{
    if (!self.on_wav_start || !self.on_wav_length) return nil;
    
    return [self mappedDataWithStart:self.on_wav_start.longValue length:self.on_wav_length.intValue description:@"image set while loading 'on' audio file"];
}

- (NSData *)offWAVData
{
    if (!self.off_wav_start || !self.off_wav_length) return nil;
    
    return [self mappedDataWithStart:self.off_wav_start.longValue length:self.off_wav_length.intValue description:@"image set while loading 'off' audio file"];
}

- (NSData *)timeoutWAVData
{
    if (!self.timeout_wav_start || !self.timeout_wav_length) return nil;
    
    return [self mappedDataWithStart:self.timeout_wav_start.longValue length:self.timeout_wav_length.intValue description:@"image set while loading 'timeout' audio file"];
}

- (UIImage *)button1Image
{
    if (!self.button1_image_start || !self.button1_image_length) return nil;
    
    NSData *image_data = [self mappedDataWithStart:self.button1_image_start.longValue length:self.button1_image_length.intValue description:@"image set while loading button 1 image"];
    
    if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
        return [UIImage imageWithData:image_data scale:2];
    else
        return [UIImage imageWithData:image_data];
    
}

- (UIImage *)button2Image
{
    if (!self.button2_image_start || !self.button2_image_length) return nil;
    
    NSData *image_data = [self mappedDataWithStart:self.button2_image_start.longValue length:self.button2_image_length.intValue description:@"image set while loading button 2 image"];
    
    if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
        return [UIImage imageWithData:image_data scale:2];
    else
        return [UIImage imageWithData:image_data];
    
}

- (UIImage *)button3Image
{
    if (!self.button3_image_start || !self.button3_image_length) return nil;
    
    NSData *image_data = [self mappedDataWithStart:self.button3_image_start.longValue length:self.button3_image_length.intValue description:@"image set while loading button 3 image"];
    
    if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
        return [UIImage imageWithData:image_data scale:2];
    else
        return [UIImage imageWithData:image_data];
    
}

- (UIImage *)button4Image
{
    if (!self.button4_image_start || !self.button4_image_length) return nil;
    
    NSData *image_data = [self mappedDataWithStart:self.button4_image_start.longValue length:self.button4_image_length.intValue description:@"image set while loading button 4 image"];
    
    if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
        return [UIImage imageWithData:image_data scale:2];
    else
        return [UIImage imageWithData:image_data];
    
}

- (UIImage *)secondaryButton1Image
{
    if (!self.secondary_button1_image_start || !self.secondary_button1_image_length) return nil;
    
    NSData *image_data = [self mappedDataWithStart:self.secondary_button1_image_start.longValue length:self.secondary_button1_image_length.intValue description:@"image set while loading secondary button 1 image"];
    
    if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
        return [UIImage imageWithData:image_data scale:2];
    else
        return [UIImage imageWithData:image_data];
    
}

- (UIImage *)secondaryButton2Image
{
    if (!self.secondary_button2_image_start || !self.secondary_button2_image_length) return nil;
    
    NSData *image_data = [self mappedDataWithStart:self.secondary_button2_image_start.longValue length:self.secondary_button2_image_length.intValue description:@"image set while loading secondary button 2 image"];
    
    if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
        return [UIImage imageWithData:image_data scale:2];
    else
        return [UIImage imageWithData:image_data];
    
}

- (UIImage *)secondaryButton3Image
{
    if (!self.secondary_button3_image_start || !self.secondary_button3_image_length) return nil;
    
    NSData *image_data = [self mappedDataWithStart:self.secondary_button3_image_start.longValue length:self.secondary_button3_image_length.intValue description:@"image set while loading secondary button 3 image"];
    
    if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
        return [UIImage imageWithData:image_data scale:2];
    else
        return [UIImage imageWithData:image_data];
    
}

- (UIImage *)secondaryButton4Image
{
    if (!self.secondary_button4_image_start || !self.secondary_button4_image_length) return nil;
    
    NSData *image_data = [self mappedDataWithStart:self.secondary_button4_image_start.longValue length:self.secondary_button4_image_length.intValue description:@"image set while loading secondary button 4 image"];
    
    if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
        return [UIImage imageWithData:image_data scale:2];
    else
        return [UIImage imageWithData:image_data];
    
}

- (UIImage *)secondaryImage1
{
    if (!self.secondary_image1_start || !self.secondary_image1_length) return nil;
    
    NSData *image_data = [self mappedDataWithStart:self.secondary_image1_start.longValue length:self.secondary_image1_length.intValue description:@"image set while loading secondary image 1"];
    
    if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
        return [UIImage imageWithData:image_data scale:2];
    else
        return [UIImage imageWithData:image_data];
    
}

- (UIImage *)secondaryImage2
{
    if (!self.secondary_image2_start || !self.secondary_image2_length) return nil;
    
    NSData *image_data = [self mappedDataWithStart:self.secondary_image2_start.longValue length:self.secondary_image2_length.intValue description:@"image set while loading secondary image 2"];
    
    if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
        return [UIImage imageWithData:image_data scale:2];
    else
        return [UIImage imageWithData:image_data];
    
}

- (UIImage *)secondaryImage3
{
    if (!self.secondary_image3_start || !self.secondary_image3_length) return nil;
    
    NSData *image_data = [self mappedDataWithStart:self.secondary_image3_start.longValue length:self.secondary_image3_length.intValue description:@"image set while loading secondary image 3"];
    
    if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
        return [UIImage imageWithData:image_data scale:2];
    else
        return [UIImage imageWithData:image_data];
    
}

- (UIImage *)secondaryImage4
{
    if (!self.secondary_image4_start || !self.secondary_image4_length) return nil;
    
    NSData *image_data = [self mappedDataWithStart:self.secondary_image4_start.longValue length:self.secondary_image4_length.intValue description:@"image set while loading secondary image 4"];
    
    if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
        return [UIImage imageWithData:image_data scale:2];
    else
        return [UIImage imageWithData:image_data];
    
}

@end
