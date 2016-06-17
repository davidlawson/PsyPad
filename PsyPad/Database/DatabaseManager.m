//
//  DatabaseManager.m
//  PsyPad
//
//  Created by David Lawson on 17/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "DatabaseManager.h"
#import "RootEntity.h"

@implementation DatabaseManager

+ (NSString *)modelFileName        { return @"Model.momd"; }
+ (NSString *)storeFileName        { return @"Database.sqlite"; }
+ (NSArray *)modelNames            { return @[@"Model1", @"Model2", @"Model3", @"Model4"]; }
+ (NSString *)iCloudContainer      { return nil; }
+ (NSString *)iCloudContentNameKey { return nil; }

+ (BOOL)databaseEmpty
{
    return [RootEntity MR_countOfEntities] == 0;
}

+ (void)populateDatabase
{
    [RootEntity MR_createEntity];
    [self save];
}

@end
