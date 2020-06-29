//
//  DLServerManager.m
//  Boilerplate
//
//  Created by David Lawson on 16/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "DLServerManager.h"
#import "AFNetworking.h"

@interface DLServerManager ()

@end

@implementation DLServerManager

- (id<DLUserAccount>)currentUser { //NSLog(@"WARNING: please override");
    return nil;
    
}

- (void)didLoginWithEmail:(NSString *)email authToken:(NSString *)authToken { //NSLog(@"WARNING: please override");
    
}
- (void)didLogout { //NSLog(@"WARNING: please override");
    
}

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

- (AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    return manager;
}

- (void(^)(NSURLSessionDataTask *operation, NSError *error))failureBlock:(void (^)(NSString *))failure
{
    return ^(NSURLSessionDataTask *operation, NSError *error)
    {
        NSString* response = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];

        NSLog(@"FAILURE BLOCK");
        //NSLog(@"%@",operation);
        //NSLog(@"%@",error);
        failure(response);
    };
}

- (void)loginWithEmail:(NSString *)email password:(NSString *)password success:(void (^)(void))success failure:(void (^)(NSString *))failure
{
    assert(self.requestManager);
    
    void (^successBlock)(NSURLSessionDataTask *, NSDictionary *) = ^(NSURLSessionDataTask *operation, NSDictionary *response)
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
        
        //failure(__(@"Unknown error"));
    };
    
    [self.requestManager POST:@"api/users/sign_in"
                   parameters:@{ @"user": @{ @"email" : email, @"password" : password } }
                      headers:nil
                     progress:nil
                      success:successBlock
                     failure:[self failureBlock:failure]];
}

- (void)signUpWithEmail:(NSString *)email password:(NSString *)password info:(NSDictionary *)info success:(void (^)(void))success failure:(void (^)(NSString *))failure
{
    assert(self.requestManager);
    
    void (^successBlock)(NSURLSessionDataTask *, NSDictionary *) = ^(NSURLSessionDataTask *operation, NSDictionary *response)
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
        
        //failure(__(@"Unknown error"));
    };
    
    NSMutableDictionary *data = info.mutableCopy;
    data[@"email"] = email;
    data[@"password"] = password;
    data[@"password_confirmation"] = password;
    
    [self.requestManager POST:@"api/users"
                   parameters:@{ @"user": data }
                      headers:nil
                     progress:nil
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
                            headers:nil
                            success:nil
                            failure:nil];
        
        [self.currentUser loggedOut];
    }
    
    [self didLogout];
}

@end
