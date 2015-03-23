#import "TestSequenceImage.h"
#import "TestSequenceFolder.h"
#include <sys/mman.h>
#import "TestSequence.h"
#import "DatabaseManager.h"

@interface TestSequenceImage ()

// Private interface goes here.

@end

@implementation TestSequenceImage

- (UIImage *)image
{
    if (self.is_animated.boolValue == NO)
    {
        FILE *file;

        file = fopen([self.folder.sequence.absolutePath cStringUsingEncoding:NSASCIIStringEncoding], "rb");

        NSLog(@"%@", self.folder.sequence.absolutePath);

        if (file == NULL)
        {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to load image" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
            self.folder.sequence.url = nil;
            [DatabaseManager save];
            return nil;
        }
        
        int fd = fileno(file);

        size_t length = (size_t)self.length.intValue;
        long start = self.start.longValue;

        NSLog(@"%ld, %zul", start, length);

        long page_start = start - (start % 4096);
        long offset = start - page_start;

        void *data = mmap(NULL, offset + length, PROT_READ, MAP_SHARED, fd, page_start);

        NSLog(@"%d", errno);

        NSData *image_data = [NSData dataWithBytes:data + offset length:length];

        munmap(data, length);

        fclose(file);

        if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
            return [UIImage imageWithData:image_data scale:2];
        else
            return [UIImage imageWithData:image_data];
    }
    else
    {
        NSDictionary *animImages = [NSJSONSerialization JSONObjectWithData:[self.animated_images dataUsingEncoding:NSASCIIStringEncoding] options:nil error:nil];

        for (NSString *name in [animImages.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *a, NSString *b) {
            return [a compare:b];
        }])
        {
            NSArray *image_info = [animImages objectForKey:name];
            NSString *image_data_start = [image_info objectAtIndex:0];
            NSString *image_data_length = [image_info objectAtIndex:1];

            long start = (long)image_data_start.longLongValue;
            int length = image_data_length.intValue;

            FILE *file;

            file = fopen([self.folder.sequence.absolutePath cStringUsingEncoding:NSASCIIStringEncoding], "rb");

            if (file == NULL)
            {
                [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to load image" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
                self.folder.sequence.url = nil;
                [DatabaseManager save];
                return nil;
            }

            int fd = fileno(file);

            long page_start = start - (start % 4096);
            long offset = start - page_start;
            
            void *data = mmap(NULL, offset + length, PROT_READ, MAP_SHARED, fd, page_start);
            
            NSLog(@"Start: %ld, length: %d", start, length);
            NSData *image_data = [NSData dataWithBytes:data length:(NSUInteger)length];

            munmap(data, (size_t)length);

            fclose(file);

            if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
                return [UIImage imageWithData:image_data scale:2];
            else
                return [UIImage imageWithData:image_data];
        }
    }

    return nil;
}

- (NSArray *)images
{
    NSMutableArray *allImages = [NSMutableArray array];

    NSDictionary *animImages = [NSJSONSerialization JSONObjectWithData:[self.animated_images dataUsingEncoding:NSASCIIStringEncoding] options:nil error:nil];

    for (NSString *name in [animImages.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *a, NSString *b) {
        return [a compare:b];
    }])
    {
        NSArray *image_info = [animImages objectForKey:name];
        NSString *image_data_start = [image_info objectAtIndex:0];
        NSString *image_data_length = [image_info objectAtIndex:1];

        long start = (long)image_data_start.longLongValue;
        int length = image_data_length.intValue;

        FILE *file;

        file = fopen([self.folder.sequence.absolutePath cStringUsingEncoding:NSASCIIStringEncoding], "r");

        fseek(file, start, SEEK_SET);

        size_t bytes = (size_t)length;
        void *data = malloc(bytes);
        fread(data, 1, bytes, file);

        fclose(file);

        NSData *image_data = [NSData dataWithBytes:data length:bytes];

        free(data);

        UIImage *newImage;
        if([[UIScreen mainScreen] scale] == 2.0 && [UIImage respondsToSelector:@selector(imageWithData:scale:)])
            newImage = [UIImage imageWithData:image_data scale:2];
        else
            newImage = [UIImage imageWithData:image_data];

        if (newImage != nil)
            [allImages addObject:newImage];
    }

    return allImages;
}

@end
