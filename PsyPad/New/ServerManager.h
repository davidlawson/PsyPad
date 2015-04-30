//
//  ServerManager.h
//  PsyPad
//
//  Created by David Lawson on 22/03/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import <Boilerplate/DLServerManager.h>

@class User, TestConfiguration;

@interface ServerManager : DLServerManager

- (void)loadConfigurationsWithSuccess:(void(^)(NSArray *updatableConfigurations, NSArray *downloadableConfigurations))success
                              failure:(void(^)(NSString *error))failure;

- (void)downloadConfiguration:(NSString *)configID
                        atURL:(NSString *)url
                     progress:(void (^)(NSString *status, float progress))progress
                      success:(void (^)(TestConfiguration *configuration))success
                      failure:(void (^)(NSString *error))failure;

- (void)loadServerParticipants:(void (^)(NSArray *participants))success
                       failure:(void (^)(NSString *error))failure;

- (void)downloadParticipant:(NSString *)username
                   progress:(void (^)(NSString *status, float progress))progress
                    success:(void (^)(User *newUser))success
                    failure:(void (^)(NSString *error))failure;

- (void)downloadAllParticipants:(void (^)(NSString *status, float progress))progress
                        success:(void (^)(NSMutableArray *newUsers))success
                        failure:(void (^)(NSString *error))failure;

- (void)uploadLogsWithProgress:(void (^)(NSString *status, float progress))progress
                       success:(void (^)())success
                       failure:(void (^)(NSString *error))failure;

@end
