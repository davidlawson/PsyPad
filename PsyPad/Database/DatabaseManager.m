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

+ (NSArray *)modelNames
{
    return @[
        @"Model1"
    ];
}

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
