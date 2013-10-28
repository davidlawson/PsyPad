//
//  AppConfiguration.h
//  PsyPad
//
//  Created by David Lawson on 2/04/13.
//  Copyright (c) 2013 David Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface AppConfiguration : NSManagedObject

@property (nonatomic, retain) NSString *server_url;
@property (nonatomic, retain) NSString *server_username;
@property (nonatomic, retain) NSString *server_password;
@property (nonatomic, retain) NSString *admin_password;

- (void)insertDefaultData;

@end
