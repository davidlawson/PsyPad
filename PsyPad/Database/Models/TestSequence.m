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
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to load background image" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
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

@end
