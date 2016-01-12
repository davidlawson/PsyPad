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

- (UIImage *)backgroundImage
{
    if (!self.background_start || !self.background_length) return nil;

    FILE *file;

    file = fopen([self.absolutePath cStringUsingEncoding:NSASCIIStringEncoding], "rb");

    if (file == NULL)
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to open image set while loading background image" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
        self.url = nil;
        [DatabaseManager save];
        return nil;
    }

    int fd = fileno(file);

    size_t length = (size_t)self.background_length.intValue;
    long start = self.background_start.longValue;

    long page_start = start - (start % 4096);
    long offset = start - page_start;

    void *data = mmap(NULL, offset + length, PROT_READ, MAP_SHARED, fd, page_start);

    NSData *image_data = [NSData dataWithBytes:data + offset length:length];

    munmap(data, length);

    fclose(file);

    if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
        return [UIImage imageWithData:image_data scale:2];
    else
        return [UIImage imageWithData:image_data];

}

- (UIImage *)titleImage
{
    if (!self.title_start || !self.title_length) return nil;
    
    FILE *file;
    
    file = fopen([self.absolutePath cStringUsingEncoding:NSASCIIStringEncoding], "rb");
    
    if (file == NULL)
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to open image set while loading title image" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
        self.url = nil;
        [DatabaseManager save];
        return nil;
    }
    
    int fd = fileno(file);
    
    size_t length = (size_t)self.title_length.intValue;
    long start = self.title_start.longValue;
    
    long page_start = start - (start % 4096);
    long offset = start - page_start;
    
    void *data = mmap(NULL, offset + length, PROT_READ, MAP_SHARED, fd, page_start);
    
    NSData *image_data = [NSData dataWithBytes:data + offset length:length];
    
    munmap(data, length);
    
    fclose(file);
    
    if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
        return [UIImage imageWithData:image_data scale:2];
    else
        return [UIImage imageWithData:image_data];
    
}

- (NSData *)correctWAVData
{
    if (!self.correct_wav_start || !self.correct_wav_length) return nil;
    
    FILE *file;
    
    file = fopen([self.absolutePath cStringUsingEncoding:NSASCIIStringEncoding], "rb");
    
    if (file == NULL)
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to open image set while loading 'correct button' audio file" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
        self.url = nil;
        [DatabaseManager save];
        return nil;
    }
    
    int fd = fileno(file);
    
    size_t length = (size_t)self.correct_wav_length.intValue;
    long start = self.correct_wav_start.longValue;
    
    long page_start = start - (start % 4096);
    long offset = start - page_start;
    
    void *data = mmap(NULL, offset + length, PROT_READ, MAP_SHARED, fd, page_start);
    
    NSData *wav_data = [NSData dataWithBytes:data + offset length:length];
    
    munmap(data, length);
    
    fclose(file);
    
    return wav_data;
}

- (NSData *)incorrectWAVData
{
    if (!self.incorrect_wav_start || !self.incorrect_wav_length) return nil;
    
    FILE *file;
    
    file = fopen([self.absolutePath cStringUsingEncoding:NSASCIIStringEncoding], "rb");
    
    if (file == NULL)
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to open image set while loading 'incorrect button' audio file" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
        self.url = nil;
        [DatabaseManager save];
        return nil;
    }
    
    int fd = fileno(file);
    
    size_t length = (size_t)self.incorrect_wav_length.intValue;
    long start = self.incorrect_wav_start.longValue;
    
    long page_start = start - (start % 4096);
    long offset = start - page_start;
    
    void *data = mmap(NULL, offset + length, PROT_READ, MAP_SHARED, fd, page_start);
    
    NSData *wav_data = [NSData dataWithBytes:data + offset length:length];
    
    munmap(data, length);
    
    fclose(file);
    
    return wav_data;
}

@end
