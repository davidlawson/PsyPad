//
// Created by David Lawson on 3/11/2013.
// Copyright (c) 2013 David Lawson. All rights reserved.
//


#import <Foundation/Foundation.h>

@class User;

@interface APIController : NSObject

- (void)loadServerParticipants:(void (^)(NSMutableArray *serverUsers))success failure:(void (^)())failure;

- (void)downloadParticipant:(NSString *)username progress:(void (^)(NSString *status, float _progress))progress success:(void (^)(User *newUser))success failure:(void (^)())failure supressErrors:(BOOL)supressErrors;

- (void)uploadUser:(User *)user success:(void (^)())success failure:(void (^)())failure;

- (void)downloadAllParticipants:(void (^)(NSString *status, float _progress))progress success:(void (^)(NSMutableArray *newUsers))success failure:(void (^)())failure;

- (void)uploadAllUsers:(NSArray *)users success:(void (^)())success failure:(void (^)())failure;

- (void)uploadLogs:(NSArray *)users progress:(void (^)(NSString *status, float _progress))progress success:(void (^)())success failure:(void (^)())failure;
@end
