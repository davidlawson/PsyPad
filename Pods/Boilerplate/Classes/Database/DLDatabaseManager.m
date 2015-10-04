//
//  DLDatabaseManager.m
//  Boilerplate
//
//  Created by David Lawson on 16/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "DLDatabaseManager.h"
#import "DLIterativeMigrator.h"

@implementation DLDatabaseManager

+ (NSString *)modelFileName        { NSLog(@"WARNING: please override"); return nil; }
+ (NSString *)storeFileName        { NSLog(@"WARNING: please override"); return nil; }
+ (NSArray *)modelNames            { NSLog(@"WARNING: please override"); return nil; }
+ (NSString *)iCloudContainer      { NSLog(@"WARNING: please override"); return nil; }
+ (NSString *)iCloudContentNameKey { NSLog(@"WARNING: please override"); return nil; }

+ (void)setup
{
    assert(self.modelFileName
           && self.storeFileName
           && self.modelNames);
    
    NSManagedObjectModel *model = [NSManagedObjectModel MR_managedObjectModelNamed:self.modelFileName];
    [NSManagedObjectModel MR_setDefaultManagedObjectModel:model];
    
    NSURL *storeURL = [NSPersistentStore MR_urlForStoreName:self.storeFileName];

    NSError *error;
    if (![DLIterativeMigrator iterativeMigrateURL:storeURL
                                           ofType:NSSQLiteStoreType
                                          toModel:model
                                orderedModelNames:self.modelNames
                                            error:&error])
    {
        NSLog(@"Error migrating to latest model: %@\n %@", error, [error userInfo]);
    }

    if (self.iCloudContainer && self.iCloudContentNameKey)
    {
        NSLog(@"Using iCloud Core Data");
        [MagicalRecord setupCoreDataStackWithiCloudContainer:self.iCloudContainer contentNameKey:self.iCloudContentNameKey localStoreAtURL:storeURL cloudStorePathComponent:nil completion:nil];
    }
    else
    {
        NSLog(@"Using non-iCloud Core Data");
        [MagicalRecord setupCoreDataStackWithStoreAtURL:storeURL];
    }

    if ([self databaseEmpty])
        [self populateDatabase];
}

+ (void)save
{
    NSAssert([NSThread isMainThread], @"Attempted to save database on non-main thread");
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

+ (BOOL)databaseEmpty { NSLog(@"WARNING: please override"); return NO; }
+ (void)populateDatabase { NSLog(@"WARNING: please override"); }

+ (void)cleanUp
{
    [MagicalRecord cleanUp];
}

@end