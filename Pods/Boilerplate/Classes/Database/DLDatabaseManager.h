//
//  DLDatabaseManager.h
//  Boilerplate
//
//  Created by David Lawson on 16/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLDatabaseManager : NSObject

+ (NSString *)modelFileName;
+ (NSString *)storeFileName;
+ (NSArray *)modelNames;

+ (void)setup;
+ (BOOL)databaseEmpty;
+ (void)populateDatabase;
+ (void)cleanUp;

+ (void)save;

@end