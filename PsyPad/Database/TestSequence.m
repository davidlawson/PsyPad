//
//  TestSequence.m
//  eTASM
//
//  Created by David Lawson on 4/12/12.
//

#import "TestSequence.h"
#import "TestSequenceFolder.h"
#import "TestSequenceImage.h"

@implementation TestSequence
{
    int _nextFolder;
}

@dynamic name;
@dynamic path, url;
@dynamic folders;

- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    if (self)
    {
        _nextFolder = 0;
    }

    return self;
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

    abort(); // folder not found
}

- (void)reset
{
    _nextFolder = 0;
    for (TestSequenceFolder *folder in self.folders)
    {
        [folder reset];
    }
}

- (void)removeFoldersObject:(TestSequenceFolder *)value
{
    NSMutableOrderedSet *tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.folders];
    [tempSet removeObject:value];
    self.folders = tempSet;
}

- (void)addFolders:(NSOrderedSet *)values
{
    NSMutableOrderedSet *tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.folders];
    for (TestSequenceFolder *folder in values)
    {
        [tempSet addObject:folder];
    }
    self.folders = tempSet;
}

- (void)prepareForDeletion
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.path])
    {
        NSLog(@"deletingsequencefiles");
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:self.path error:&error];
        
        if (error)
        {
            NSLog(@"Error deleting files: %@", [error localizedDescription]);
        }
    }

    [super prepareForDeletion];
}


@end
