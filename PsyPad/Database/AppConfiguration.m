//
//  AppConfiguration.m
//  PsyPad
//
//  Created by David Lawson on 2/04/13.
//  Copyright (c) 2013 David Lawson. All rights reserved.
//

#import "AppConfiguration.h"

@implementation AppConfiguration

@dynamic server_url, server_username, server_password, admin_password;

- (void)insertDefaultData
{
    self.server_url = @"http://www.psypad.net.au/server/";
    self.server_username = @"";
    self.server_password = @""; // TODO handle this!
    self.admin_password = @"admin"; // more error handling lease
    // and informative views
}

@end
