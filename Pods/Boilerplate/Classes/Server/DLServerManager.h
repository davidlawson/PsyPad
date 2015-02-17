//
//  DLServerManager.h
//  Boilerplate
//
//  Created by David Lawson on 16/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserAccount

- (BOOL)loggedIn;
- (NSString *)email;
- (NSString *)authToken;
- (void)loggedInWithEmail:(NSString *)email authToken:(NSString *)authToken;
- (void)loggedOut;

@end

@interface DLServerManager : NSObject

- (NSString *)serverURL;

- (id<UserAccount>)currentUser;

- (void)didLoginWithEmail:(NSString *)email authToken:(NSString *)authToken;
- (void)didLogout;

- (void)loginWithEmail:(NSString *)email password:(NSString *)password success:(void (^)())success failure:(void (^)(NSString *))failure;
- (void)signUpWithFirstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email password:(NSString *)password success:(void (^)())success failure:(void (^)(NSString *))failure;
- (void)logout;

@end