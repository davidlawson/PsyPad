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
    if (self.is_animatedValue == NO)
    {
        FILE *file;

        file = fopen([self.folder.sequence.absolutePath cStringUsingEncoding:NSASCIIStringEncoding], "rb");

        NSLog(@"%@", self.folder.sequence.absolutePath);

        if (file == NULL)
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Error"
                                         message:@"Failed to load image"
                                         preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil]];
            
            UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
            if ( viewController.presentedViewController && !viewController.presentedViewController.isBeingDismissed ) {
                viewController = viewController.presentedViewController;
            }

            NSLayoutConstraint *constraint = [NSLayoutConstraint
                constraintWithItem:alert.view
                attribute:NSLayoutAttributeHeight
                relatedBy:NSLayoutRelationLessThanOrEqual
                toItem:nil
                attribute:NSLayoutAttributeNotAnAttribute
                multiplier:1
                constant:viewController.view.frame.size.height*2.0f];

            [alert.view addConstraint:constraint];
            [viewController presentViewController:alert animated:YES completion:^{}];

            self.folder.sequence.url = nil;
            [DatabaseManager save];
            return nil;
        }
        
        int fd = fileno(file);

        size_t length = (size_t)self.length.intValue;
        long start = self.start.longValue;

        NSLog(@"%ld, %zul", start, length);

        long page_start = start - (start % getpagesize());
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
        NSArray *animImages = [NSJSONSerialization JSONObjectWithData:[self.animated_images dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];

        for (NSDictionary *animImage in [animImages sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *a, NSDictionary *b) {
            return [a[@"n"] compare:b[@"n"]];
        }])
        {
            long start = [animImage[@"s"] longLongValue];
            int length = [animImage[@"l"] intValue];

            FILE *file;

            file = fopen([self.folder.sequence.absolutePath cStringUsingEncoding:NSASCIIStringEncoding], "rb");

            if (file == NULL)
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"Error"
                                             message:@"Failed to load image"
                                             preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil]];
                
                UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
                if ( viewController.presentedViewController && !viewController.presentedViewController.isBeingDismissed ) {
                    viewController = viewController.presentedViewController;
                }

                NSLayoutConstraint *constraint = [NSLayoutConstraint
                    constraintWithItem:alert.view
                    attribute:NSLayoutAttributeHeight
                    relatedBy:NSLayoutRelationLessThanOrEqual
                    toItem:nil
                    attribute:NSLayoutAttributeNotAnAttribute
                    multiplier:1
                    constant:viewController.view.frame.size.height*2.0f];

                [alert.view addConstraint:constraint];
                [viewController presentViewController:alert animated:YES completion:^{}];

                self.folder.sequence.url = nil;
                [DatabaseManager save];
                return nil;
            }

            int fd = fileno(file);

            long page_start = start - (start % getpagesize());
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

    NSArray *animImages = [NSJSONSerialization JSONObjectWithData:[self.animated_images dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];

    for (NSDictionary *animImage in [animImages sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *a, NSDictionary *b) {
        return [a[@"n"] compare:b[@"n"]];
    }])
    {
        long start = [animImage[@"s"] longLongValue];
        int length = [animImage[@"l"] intValue];

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
