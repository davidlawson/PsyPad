//
//  DLDatabaseManager.h
//  Boilerplate
//
//  Created by David Lawson on 16/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>

///
///  Class that manages Core Data attempting to follow best iOS practices
///
///  In your app delegate (that should subclass `DLAppDelegate`) make sure 
///  to register your `DLDatabaseManager` subclass:
///
///    [DLSettings sharedSettings].databaseManagerClass = [MyDatabaseManager class];
///
@interface DLDatabaseManager : NSObject

///  
///  Managed object model file name (e.g. Model.momd)
///  
+ (NSString *)modelFileName;

///  
///  Name of database file (e.g. Database.sqlite)
///  
+ (NSString *)storeFileName;

///  
///  Names of models to iteratively migrate through,
///  e.g. @[@"Model 1", @"Model 2"]. Warning: when
///  adding a new model, update the iCloudContentNameKey.
///  This will start using a new iCloud persistent
///  store (so some data loss may occur if users use
///  different versions of the app).
///  
+ (NSArray *)modelNames;

///  
///  Name of iCloud container to use,
///  usually iCloud.$(CFBundleIdentifier)
///  
+ (NSString *)iCloudContainer;

///  
///  The NSPersistentStoreUbiquitousContentNameKey
///  to use. Change this if you are migrating to a
///  model version that does not support automatic
///  lightweight migration.
///  
+ (NSString *)iCloudContentNameKey;

///  
///  Called in launch sequence in DLLaunchViewController
///  
+ (void)setup;

///  
///  Return YES if database is empty
///  
+ (BOOL)databaseEmpty;

///  
///  Called if databaseEmpty returned YES
///  
+ (void)populateDatabase;

///  
///  Call this method to save the database
///  Must be called from the main thread
///  
+ (void)save;

///  
///  Called on application quit in DLAppDelegate
///  
+ (void)cleanUp;

@end