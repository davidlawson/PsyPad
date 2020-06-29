//
//  DLSettings.m
//  Boilerplate
//
//  Created by David Lawson on 5/03/15.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "DLSettings.h"
#import "DLDatabaseManager.h"

@implementation DLSettings

+ (DLSettings *)sharedSettings
{
    static DLSettings *sharedSettings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSettings = [[DLSettings alloc] init];
    });
    return sharedSettings;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.databaseManagerClass = [DLDatabaseManager class];
    }

    return self;
}

@end