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
#import <AFNetworking/AFNetworking.h>
#import "TestConfiguration.h"
#import "AvailableConfiguration.h"
#import "User.h"

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
}

- (void)didLogout
{
    [User MR_truncateAll];
    [TestConfiguration MR_truncateAll];
    [DatabaseManager save];
}

- (void)loadConfigurationsWithSuccess:(void(^)(NSArray *updatableConfigurations, NSArray *downloadableConfigurations))success
                              failure:(void(^)(NSString *error))failure
{
    void (^successBlock)(AFHTTPRequestOperation *, NSDictionary *) = ^(AFHTTPRequestOperation *operation, NSDictionary *response)
    {
        if ([response isKindOfClass:[NSDictionary class]])
        {
            NSMutableArray *updatableConfigurations = [NSMutableArray new];
            NSMutableArray *downloadableConfigurations = [NSMutableArray new];
            
            NSArray *configurations = response[@"configurations"];
            for (NSDictionary *configuration in configurations)
            {
                NSString *configID = [(NSNumber *)configuration[@"id"] stringValue];
                NSString *name = configuration[@"name"];
                NSString *desc = configuration[@"desc"];
                NSString *url = configuration[@"url"];
                
                TestConfiguration *config = [TestConfiguration MR_findFirstByAttribute:TestConfigurationAttributes.server_id withValue:configID];
                if (config && ![config.server_url isEqualToString:url])
                {
                    AvailableConfiguration *available = [AvailableConfiguration new];
                    available.name = name;
                    
                    if (![desc isEqual:[NSNull null]])
                        available.configurationDescription = desc;
                    
                    available.url = url;
                    available.configID = configID;
                    
                    [updatableConfigurations addObject:available];
                }
                
                if (!config)
                {
                    AvailableConfiguration *available = [AvailableConfiguration new];
                    available.name = name;
                    
                    if (![desc isEqual:[NSNull null]])
                        available.configurationDescription = desc;
                    
                    available.url = url;
                    available.configID = configID;
                    
                    [downloadableConfigurations addObject:available];
                }
            }
            
            success(updatableConfigurations, downloadableConfigurations);
            
            return;
        }
        
        failure(@"Unknown error");
    };
    
    [self.requestManager GET:@"api/configurations"
                  parameters:@{ @"user_email": self.currentUser.email,
                                @"user_token": self.currentUser.authToken }
                     success:successBlock
                     failure:[self failureBlock:failure]];
}

- (void)downloadConfiguration:(NSString *)configID
                        atURL:(NSString *)url
                     progress:(void (^)(NSString *status, float progress))progress
                      success:(void (^)(TestConfiguration *configuration))success
                      failure:(void (^)(NSString *error))failure
{
    void (^successBlock)(AFHTTPRequestOperation *, NSDictionary *) = ^(AFHTTPRequestOperation *operation, NSDictionary *response)
    {
        __block TestConfiguration *newConfiguration = nil;
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext)
         {
             [TestConfiguration MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"server_id == %@", configID] inContext:localContext];
             
             newConfiguration = [TestConfiguration MR_createEntityInContext:localContext];
             
             [newConfiguration loadData:response];
             newConfiguration.server_url = url;
             newConfiguration.server_id = configID;
             
             if ([response objectForKey:@"image_set_url"])
             {
                 NSString *image_sequence_url = [[RootEntity rootEntity].server_url stringByAppendingPathComponent:response[@"image_set_url"]];
                 
                 NSDictionary *image_set_data = response[@"image_set_data"];
                 
                 dispatch_semaphore_t sema = dispatch_semaphore_create(0);
                 
                 [newConfiguration installSequenceWithURL:image_sequence_url
                                                   params:@{ @"user_email": self.currentUser.email,
                                                             @"user_token": self.currentUser.authToken }
                                                     data:image_set_data progress:^(NSString *status, float _progress)
                  {
                      dispatch_async(dispatch_get_main_queue(), ^{
                          progress(@"Downloading configuration...", _progress);
                      });
                  } sema:sema MOC:localContext];
                 
                 dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
             }
         }
                          completion:^(BOOL contextDidSave, NSError *error)
         {
             success((TestConfiguration *)[[NSManagedObjectContext MR_defaultContext] objectWithID:newConfiguration.objectID]);
         }];
    };
    
    [self.requestManager GET:url
                  parameters:@{ @"user_email": self.currentUser.email,
                                @"user_token": self.currentUser.authToken }
                     success:successBlock
                     failure:[self failureBlock:failure]];
}

- (void)loadServerParticipants:(void (^)(NSArray *participants))success
                       failure:(void (^)(NSString *error))failure
{
    void (^successBlock)(AFHTTPRequestOperation *, NSDictionary *) = ^(AFHTTPRequestOperation *operation, NSDictionary *response)
    {
        if ([response isKindOfClass:[NSDictionary class]])
        {
            NSMutableArray *participants = [NSMutableArray new];
            
            for (NSDictionary *participant in response[@"participants"])
            {
                NSString *username = participant[@"username"];
                NSString *desc = participant[@"desc"];
                
                [participants addObject:@{ @"username": username, @"desc": desc }];
            }
            
            success(participants);
            
            return;
        }
        
        failure(@"Unknown error");
    };
    
    [self.requestManager GET:@"api/participants"
                  parameters:@{ @"user_email": self.currentUser.email,
                                @"user_token": self.currentUser.authToken }
                     success:successBlock
                     failure:[self failureBlock:failure]];
}

- (void)downloadParticipant:(NSString *)username
                   progress:(void (^)(NSString *status, float progress))progress
                    success:(void (^)(User *newUser))success
                    failure:(void (^)(NSString *error))failure
{
    void (^successBlock)(AFHTTPRequestOperation *, NSDictionary *) = ^(AFHTTPRequestOperation *operation, NSDictionary *response)
    {
        __block User *newUser = nil;
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext)
        {
            NSArray *existingUsers = [User MR_findAllInContext:localContext];
            
            BOOL usernameTaken = NO;
            for (User *user in existingUsers)
            {
                if ([user.id isEqualToString:username])
                {
                    usernameTaken = YES;
                    newUser = user;
                    for (TestConfiguration *configuration in newUser.configurations)
                    {
                        [newUser removeConfigurationsObject:configuration];
                        [configuration MR_deleteEntity];
                    }
                    break;
                }
            }
            
            if (!usernameTaken)
            {
                newUser = [User MR_createEntityInContext:localContext];
                newUser.id = username;
            }
            
            for (NSDictionary *configurationData in response[@"configurations"])
            {
                TestConfiguration *newConfiguration = [TestConfiguration MR_createEntityInContext:localContext];
                newConfiguration.user = newUser;
                
                [newConfiguration loadData:configurationData];
                
                if ([configurationData objectForKey:@"image_set_url"])
                {
                    NSString *image_sequence_url = [[RootEntity rootEntity].server_url stringByAppendingPathComponent:[configurationData objectForKey:@"image_set_url"]];
                    
                    NSDictionary *image_set_data = configurationData[@"image_set_data"];
                    
                    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
                    
                    [newConfiguration installSequenceWithURL:image_sequence_url
                                                      params:@{ @"user_email": self.currentUser.email,
                                                                @"user_token": self.currentUser.authToken }
                                                        data:image_set_data progress:^(NSString *status, float _progress)
                     {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             progress([NSString stringWithFormat:@"Configuration %d/%d, %@",
                                       (int)[response[@"configurations"] indexOfObject:configurationData] + 1,
                                       (int)[response[@"configurations"] count],
                                       status],
                                      _progress);
                         });
                     } sema:sema MOC:localContext];
                    
                    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
                }
                
                [newUser addConfigurationsObject:newConfiguration];
            }
        }
                          completion:^(BOOL contextDidSave, NSError *error)
        {
            success((User *)[[NSManagedObjectContext MR_defaultContext] objectWithID:newUser.objectID]);
        }];
    };
    
    [self.requestManager GET:[NSString stringWithFormat:@"api/participants/%@", username]
                  parameters:@{ @"user_email": self.currentUser.email,
                                @"user_token": self.currentUser.authToken }
                     success:successBlock
                     failure:[self failureBlock:failure]];
}

@end
