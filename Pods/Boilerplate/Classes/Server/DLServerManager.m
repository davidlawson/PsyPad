//
//  DLServerManager.m
//  Boilerplate
//
//  Created by David Lawson on 16/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "DLServerManager.h"
#import <AFNetworking/AFNetworking.h>

@interface DLServerManager ()

@end

@implementation DLServerManager

- (id<DLUserAccount>)currentUser { NSLog(@"WARNING: please override"); return nil; }

- (void)didLoginWithEmail:(NSString *)email authToken:(NSString *)authToken { NSLog(@"WARNING: please override"); }
- (void)didLogout { NSLog(@"WARNING: please override"); }

+ (instancetype)sharedManager
{
    static DLServerManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.requestManager = nil;
    }
    
    return self;
}

- (void)setBaseURL:(NSString *)baseURL
{
    _baseURL = baseURL;
    
    self.requestManager = [self managerWithBaseURL:baseURL];
}

- (AFHTTPRequestOperationManager *)managerWithBaseURL:(NSString *)baseURL
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    return manager;
}

- (void(^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock:(void (^)(NSString *))failure
{
    return ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSDictionary *response = operation.responseObject;
        if ([response isKindOfClass:[NSDictionary class]])
        {
            if ([response[@"error"] isKindOfClass:[NSString class]])
            {
                failure(response[@"error"]);
            }
            else if ([response[@"errors"] isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *errors = response[@"errors"];
                
                NSMutableArray *combinedErrors = @[].mutableCopy;
                [errors enumerateKeysAndObjectsUsingBlock:^(NSString *field, NSString *error, BOOL *stop)
                {
                    [combinedErrors addObject:[NSString stringWithFormat:@"%@ %@", field, error]];
                }];
                
                failure([combinedErrors componentsJoinedByString:@", "]);
            }
        }
        else
        {
            failure(error.localizedDescription);
        }
    };
}

- (void)loginWithEmail:(NSString *)email password:(NSString *)password success:(void (^)())success failure:(void (^)(NSString *))failure
{
    assert(self.requestManager);
    
    void (^successBlock)(AFHTTPRequestOperation *, NSDictionary *) = ^(AFHTTPRequestOperation *operation, NSDictionary *response)
    {
        if ([response isKindOfClass:[NSDictionary class]])
        {
            NSNumber *didSucceed = response[@"success"];
            if (didSucceed && [didSucceed boolValue])
            {
                NSString *authToken = response[@"auth_token"];
                
                [self.currentUser loggedInWithEmail:email authToken:authToken];
                [self didLoginWithEmail:email authToken:authToken];
                
                success();
                return;
            }
        }
        
        failure(__(@"Unknown error"));
    };
    
    [self.requestManager POST:@"api/users/sign_in"
                   parameters:@{ @"user": @{ @"email" : email, @"password" : password } }
                      success:successBlock
                     failure:[self failureBlock:failure]];
}

- (void)signUpWithEmail:(NSString *)email password:(NSString *)password info:(NSDictionary *)info success:(void (^)())success failure:(void (^)(NSString *))failure
{
    assert(self.requestManager);
    
    void (^successBlock)(AFHTTPRequestOperation *, NSDictionary *) = ^(AFHTTPRequestOperation *operation, NSDictionary *response)
    {
        if ([response isKindOfClass:[NSDictionary class]])
        {
            NSNumber *didSucceed = response[@"success"];
            if (didSucceed && [didSucceed boolValue])
            {
                NSString *authToken = response[@"auth_token"];
                
                [self.currentUser loggedInWithEmail:email authToken:authToken];
                [self didLoginWithEmail:email authToken:authToken];
                
                success();
                return;
            }
        }
        
        failure(__(@"Unknown error"));
    };
    
    NSMutableDictionary *data = info.mutableCopy;
    data[@"email"] = email;
    data[@"password"] = password;
    data[@"password_confirmation"] = password;
    
    [self.requestManager POST:@"api/users"
                   parameters:@{ @"user": data }
                      success:successBlock
                      failure:[self failureBlock:failure]];
}

- (void)logout
{
    assert(self.requestManager);
    
    if (self.currentUser)
    {
        [self.requestManager DELETE:@"api/users/sign_out"
                       parameters:@{ @"user_email": self.currentUser.email,
                                     @"user_token": self.currentUser.authToken }
                            success:nil
                            failure:nil];
        
        [self.currentUser loggedOut];
    }
    
    [self didLogout];
}

@end