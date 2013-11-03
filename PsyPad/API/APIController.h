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

@end