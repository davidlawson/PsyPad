//
// Created by David Lawson on 3/11/2013.
// Copyright (c) 2013 David Lawson. All rights reserved.
//


#import <Foundation/Foundation.h>

@class AppConfiguration;

@interface APIController : NSObject

@property (strong, nonatomic) AppConfiguration *appConfiguration;

+ (APIController *)controllerWithConfiguration:(AppConfiguration *)configuration;

- (void)loadServerParticipants:(void (^)(NSMutableArray *serverUsers))success failure:(void (^)())failure;

- (void)downloadParticipant:(NSString *)username progress:(void (^)(NSString *status, float progress))progress success:(void (^)(User *newUser))success failure:(void (^)())failure;

- (void)uploadUser:(User *)user success:(void (^)())success failure:(void (^)())failure;

- (void)downloadAllParticipants:(void (^)(NSString *status, float progress))progress success:(void (^)(NSMutableArray *newUsers))success failure:(void (^)())failure;

- (void)uploadAllUsers:(NSArray *)users success:(void (^)())success failure:(void (^)())failure;

- (void)uploadLogs:(NSArray *)users progress:(void (^)(NSString *status, float progress))progress success:(void (^)())success failure:(void (^)())failure;
@end