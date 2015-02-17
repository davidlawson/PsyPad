//
//  DLDatabaseManager.m
//  Boilerplate
//
//  Created by David Lawson on 16/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "DLDatabaseManager.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "DLIterativeMigrator.h"
#import "DLServerManager.h"

@implementation DLDatabaseManager

+ (NSString *)modelFileName { return @"Model.momd"; }
+ (NSString *)storeFileName { return @"Database.sqlite"; }
+ (NSArray *)modelNames { return @[@"Model1"]; }

+ (void)setup
{
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
        DLLog(@"Error migrating to latest model: %@\n %@", error, [error userInfo]);
    }

    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:self.storeFileName];

    if ([self databaseEmpty])
        [self populateDatabase];
}

+ (void)save
{
    NSAssert([NSThread isMainThread], @"Attempted to save database on non-main thread");
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

+ (BOOL)databaseEmpty { DLLog(@"WARNING: please override"); return NO; }
+ (void)populateDatabase { DLLog(@"WARNING: please override"); }

+ (void)cleanUp
{
    [MagicalRecord cleanUp];
}

@end