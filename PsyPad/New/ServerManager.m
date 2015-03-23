//
//  ServerManager.m
//  PsyPad
//
//  Created by David Lawson on 22/03/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "ServerManager.h"
#import "RootEntity.h"
#import "DatabaseManager.h"

@implementation ServerManager

- (instancetype)init
{
    if (self = [super init])
    {
        self.baseURL = [RootEntity rootEntity].server_url;
    }
    
    return self;
}

- (id<UserAccount>)currentUser
{
    return [RootEntity rootEntity];
}

- (void)didLoginWithEmail:(NSString *)email authToken:(NSString *)authToken
{
    [RootEntity rootEntity].email = email;
    [RootEntity rootEntity].authToken = authToken;
    [DatabaseManager save];
}

- (void)didLogout
{
    [RootEntity rootEntity].email = nil;
    [RootEntity rootEntity].authToken = nil;
    [DatabaseManager save];
}

@end
