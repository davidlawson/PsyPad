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

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;

@end

@implementation DLServerManager

- (NSString *)serverURL { DLLog(@"WARNING: please override"); return @"http://127.0.0.1:3000/"; }

- (id<UserAccount>)currentUser { DLLog(@"WARNING: please override"); return nil; }

- (void)didLoginWithEmail:(NSString *)email authToken:(NSString *)authToken { DLLog(@"WARNING: please override"); }
- (void)didLogout { DLLog(@"WARNING: please override"); }

+ (DLServerManager *)sharedManager
{
    static DLServerManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[DLServerManager alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:self.serverURL]];
        self.requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [self.requestManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    
    return self;
}

- (void(^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock:(void (^)(NSString *))failure
{
    return ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSDictionary *response = operation.responseObject;
        if ([response isKindOfClass:[NSDictionary class]]
            && [response[@"error"] isKindOfClass:[NSString class]])
            failure(response[@"error"]);
        else
            failure(error.localizedDescription);
    };
}

- (void)loginWithEmail:(NSString *)email password:(NSString *)password success:(void (^)())success failure:(void (^)(NSString *))failure
{
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
    
    [self.requestManager POST:@"users/sign_in"
                   parameters:@{ @"user": @{ @"email" : email, @"password" : password } }
                      success:successBlock
                     failure:[self failureBlock:failure]];
}

- (void)signUpWithFirstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email password:(NSString *)password success:(void (^)())success failure:(void (^)(NSString *))failure
{
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
    
    [self.requestManager POST:@"users"
                   parameters:@{ @"user": @{
                                  @"email" : email,
                                  @"password" : password,
                                  @"password_confirmation": password,
                                  @"first_name": firstName,
                                  @"last_name": lastName
                              }}
                      success:successBlock
                      failure:[self failureBlock:failure]];
}

- (void)logout
{
    if (self.currentUser)
    {
        [self.requestManager DELETE:@"users/sign_out"
                       parameters:@{ @"user_email": self.currentUser.email,
                                     @"user_token": self.currentUser.authToken }
                            success:nil
                            failure:nil];
        
        [self.currentUser loggedOut];
    }
    
    [self didLogout];
}

@end