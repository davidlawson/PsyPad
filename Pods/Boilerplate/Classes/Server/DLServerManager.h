//
//  DLServerManager.h
//  Boilerplate
//
//  Created by David Lawson on 16/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLUserAccount.h"

@class AFHTTPRequestOperation;
@class AFHTTPRequestOperationManager;

///  
///  Singleton that interacts with an online API
///  
@interface DLServerManager : NSObject

///  
///  Must be set before server manager can be used
///  
@property (nonatomic, strong) NSString *baseURL;

+ (instancetype)sharedManager;

///  
///  Returns current user (must override)
///  
- (id<DLUserAccount>)currentUser;

///  
///  Called when user successfully logs in (must override)
///  
- (void)didLoginWithEmail:(NSString *)email authToken:(NSString *)authToken;

///  
///  Called when user successfully logs out (must override)
///  
- (void)didLogout;

- (void)loginWithEmail:(NSString *)email password:(NSString *)password success:(void (^)())success failure:(void (^)(NSString *))failure;
- (void)signUpWithEmail:(NSString *)email password:(NSString *)password info:(NSDictionary *)info success:(void (^)())success failure:(void (^)(NSString *))failure;
- (void)logout;

///  
///  Used for subclassing:
///  
@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;
- (void(^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock:(void (^)(NSString *))failure;

@end