//
//  DatabaseManager.m
//  PsyPad
//
//  Created by David Lawson on 17/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "DatabaseManager.h"
#import "AppConfiguration.h"

@implementation DatabaseManager

+ (NSArray *)modelNames
{
    return @[
        @"Model",
        @"Model 2",
        @"Model 3",
        @"Model 4"
    ];
}

+ (BOOL)databaseEmpty
{
    return [AppConfiguration MR_countOfEntities] == 0;
}

+ (void)populateDatabase
{
    AppConfiguration *config = [AppConfiguration MR_createEntity];
    [config insertDefaultData];
    
    [self save];
}

@end
