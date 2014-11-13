//
// Created by David Lawson on 3/11/2013.
// Copyright (c) 2013 David Lawson. All rights reserved.
//


#import <AFNetworking/AFNetworking.h>
#import "APIController.h"
#import "AppConfiguration.h"
#import "AppDelegate.h"
#import "User.h"
#import "TestConfiguration.h"
#import "TestLogItem.h"
#import "TestLog.h"

@implementation APIController

+ (APIController *)controllerWithConfiguration:(AppConfiguration *)configuration
{
    APIController *controller = [[self alloc] init];
    controller.appConfiguration = configuration;
    return controller;
}

- (AFHTTPRequestOperation *)operationWithURL:(NSString *)url data:(NSMutableDictionary *)data
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[self.appConfiguration.server_url stringByAppendingString:url]]];
    [request setHTTPMethod:@"POST"];

    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSMutableDictionary *requestData = [NSMutableDictionary dictionary];
    [requestData setObject:self.appConfiguration.server_username forKey:@"username"];
    [requestData setObject:self.appConfiguration.server_password forKey:@"password"];

    if (data)
        [requestData addEntriesFromDictionary:data];

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestData options:nil error:nil];

    [request setHTTPBody:jsonData];

    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    return requestOperation;
}

- (void)showError:(NSString *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:error
                                                   delegate:nil
                                          cancelButtonTitle:@"Close"
                                          otherButtonTitles:nil];

    [alert show];
}

- (void)loadServerParticipants:(void (^)(NSMutableArray *serverUsers))success failure:(void (^)())failure
{
    AFHTTPRequestOperation *operation = [self operationWithURL:@"api/list_participants" data:nil];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *_operation, NSDictionary *responseObject)
    {
        NSMutableArray *serverUsers = [NSMutableArray array];

        if ([responseObject objectForKey:@"error"])
        {
            [self showError:[responseObject objectForKey:@"error"]];
            failure();
            return;
        }
        else if (responseObject.count > 0)
        {
            for (NSString *username in [responseObject.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *a, NSString *b) {
                return [a compare:b];
            }])
            {
                NSMutableDictionary *user = [NSMutableDictionary dictionary];
                [user setObject:username forKey:@"username"];
                [user setObject:[responseObject objectForKey:username] forKey:@"description"];
                [serverUsers addObject:user];
            }

            success(serverUsers);
        }

    } failure:^(AFHTTPRequestOperation *_operation, NSError *error)
    {
        if (_operation.responseObject)
            [self showError:[(NSDictionary *)_operation.responseObject objectForKey:@"error"]];
        else
            [self showError:error.description];

        failure();
    }];

    [operation start];
}

- (void)downloadParticipant:(NSString *)username progress:(void (^)(NSString *status, float progress))progress success:(void (^)(User *newUser))success failure:(void (^)())failure supressErrors:(BOOL)supressErrors
{
    AFHTTPRequestOperation *operation = [self operationWithURL:[NSString stringWithFormat:@"api/load_participant/%@", username] data:nil];

    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long int totalBytesRead, long long int totalBytesExpectedToRead)
    {
        progress(@"Downloading participant...", (float)totalBytesRead/(float)totalBytesExpectedToRead);
    }];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *_operation, id responseObject)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^
        {
            if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject objectForKey:@"error"])
            {
                dispatch_async(dispatch_get_main_queue(), ^
                {
                    [self showError:[responseObject objectForKey:@"error"]];
                    failure();
                });
                return;
            }
            else
            {
                [[APP_DELEGATE managedObjectContext] lock];

                NSArray *existingUsers = [User allUsers];

                User *newUser = nil;

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
                            [[APP_DELEGATE managedObjectContext] deleteObject:configuration];
                        }
                        break;
                    }
                }

                if (!usernameTaken)
                {
                    newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:APP_DELEGATE.managedObjectContext];
                    newUser.id = username;
                }

                for (NSDictionary *configurationData in (NSArray *)responseObject)
                {
                    TestConfiguration *newConfiguration = [NSEntityDescription insertNewObjectForEntityForName:@"TestConfiguration"
                                                                                        inManagedObjectContext:APP_DELEGATE.managedObjectContext];
                    newConfiguration.user = newUser;

                    [newConfiguration loadData:configurationData];

                    if ([configurationData objectForKey:@"imageset_url"])
                    {
                        NSString *image_sequence_url = [self.appConfiguration.server_url stringByAppendingString:[configurationData objectForKey:@"imageset_url"]];
                        NSString *image_sequence_data_string = [configurationData objectForKey:@"imageset_data"];
                        NSDictionary *image_sequence_data = [NSJSONSerialization JSONObjectWithData:[image_sequence_data_string dataUsingEncoding:NSASCIIStringEncoding] options:nil error:nil];

                        dispatch_semaphore_t sema = dispatch_semaphore_create(0);

                        [newConfiguration installSequenceWithURL:image_sequence_url data:image_sequence_data progress:^(NSString *status, float _progress)
                        {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                progress([NSString stringWithFormat:@"Configuration %d/%d, %@",
                                                                    [(NSArray *)responseObject indexOfObject:configurationData] + 1,
                                                                    [(NSArray *)responseObject count],
                                                                    status],
                                        _progress);
                            });
                        } sema:sema];

                        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
                    }

                    [newUser addConfigurationsObject:newConfiguration];
                }

                [APP_DELEGATE saveContext];

                [[APP_DELEGATE managedObjectContext] unlock];

                dispatch_async(dispatch_get_main_queue(), ^
                {
                    success(newUser);
                });
            }
        });
    } failure:^(AFHTTPRequestOperation *_operation, NSError *error)
    {
        if (!supressErrors)
        {
            if (_operation.responseObject)
                [self showError:[(NSDictionary *)_operation.responseObject objectForKey:@"error"]];
            else
                [self showError:error.description];
        }

        failure();
    }];

    [operation start];
}

- (void)uploadUser:(User *)user success:(void (^)())success failure:(void (^)())failure
{
    NSMutableDictionary *requestData = [NSMutableDictionary dictionary];

    NSMutableArray *configurations = [NSMutableArray array];
    for (TestConfiguration *configuration in user.configurations)
    {
        [configurations addObject:configuration.serialise];
    }

    [requestData setObject:configurations forKey:@"configurations"];

    AFHTTPRequestOperation *operation = [self operationWithURL:[NSString stringWithFormat:@"api/save_participant/%@", user.id] data:requestData];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *_operation, NSDictionary *responseObject)
    {
        if ([responseObject objectForKey:@"success"])
            success();
        else
        {
            [self showError:[responseObject objectForKey:@"error"]];
            failure();
        }

    } failure:^(AFHTTPRequestOperation *_operation, NSError *error)
    {
        if (_operation.responseObject)
            [self showError:[(NSDictionary *)_operation.responseObject objectForKey:@"error"]];
        else
            [self showError:error.description];

        failure();
    }];

    [operation start];

    return;
}

- (void)downloadAllParticipants:(void (^)(NSString *status, float progress))progress success:(void (^)(NSMutableArray *newUsers))success failure:(void (^)())failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^
    {
        [self loadServerParticipants:^(NSMutableArray *serverUsers)
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^
            {
                NSMutableArray *loadedParticipants = [NSMutableArray array];
                __block BOOL failed = NO;

                for (NSDictionary *user in serverUsers)
                {
                    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

                    [self downloadParticipant:(NSString *)[user objectForKey:@"username"] progress:^(NSString *status, float _progress)
                    {
                        progress([status stringByAppendingFormat:@" (participant %d/%d)",
                                        [serverUsers indexOfObject:user]+1,
                                        serverUsers.count],
                                _progress);

                    } success:^(User *newUser)
                    {
                        [loadedParticipants addObject:user];
                        dispatch_semaphore_signal(sema);

                    } failure:^
                    {
                        failure();
                        failed = YES;
                        dispatch_semaphore_signal(sema);
                    } supressErrors:NO];

                    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

                    if (failed) break;
                }

                dispatch_async(dispatch_get_main_queue(), ^
                {
                    if (!failed)
                        success(loadedParticipants);
                });
            });
        } failure:^
        {
            failure();
        }];
    });
}

- (void)uploadAllUsers:(NSArray *)users success:(void (^)())success failure:(void (^)())failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^
    {
        __block BOOL failed = NO;

        for (User *user in users)
        {
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);

            [self uploadUser:user success:^
            {
                dispatch_semaphore_signal(sema);

            } failure:^
            {
                failure();
                failed = YES;
                dispatch_semaphore_signal(sema);
            }];

            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

            if (failed) break;
        }

        dispatch_async(dispatch_get_main_queue(), ^
        {
            if (!failed)
                success();
        });
    });
}

- (void)uploadLogs:(NSArray *)users progress:(void (^)(NSString *status, float progress))progress success:(void (^)())success failure:(void (^)())failure
{
    NSMutableDictionary *requestData = [NSMutableDictionary dictionary];

    NSMutableDictionary *logData = [NSMutableDictionary dictionary];

    for (User *user in users)
    {
        NSMutableDictionary *oneUser = [NSMutableDictionary dictionary];

        for (TestLog *log in user.logs)
        {
            NSString *logIdentifier = nil;
            NSMutableString *logContent = [NSMutableString string];
            for (TestLogItem *logItem in log.logitems)
            {
                if (logIdentifier == nil) logIdentifier = [NSString stringWithFormat:@"%.0f", logItem.timestamp.timeIntervalSince1970];
                [logContent appendFormat:@"%.0f|%@|%@\n", logItem.timestamp.timeIntervalSince1970, logItem.type, logItem.info];
            }

            [oneUser setObject:logContent forKey:logIdentifier];
        }

        [logData setObject:oneUser forKey:user.id];
    }

    [requestData setObject:logData forKey:@"log_data"];

    AFHTTPRequestOperation *operation = [self operationWithURL:@"api/upload_logs" data:requestData];

    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite)
    {
        progress(@"Uploading logs...", (float)totalBytesWritten/(float)totalBytesExpectedToWrite);
    }];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *_operation, NSDictionary *responseObject)
    {
        if ([responseObject objectForKey:@"success"])
            success();
        else
        {
            [self showError:[@"Failed to upload logs: " stringByAppendingString:[responseObject objectForKey:@"error"]]];
            failure();
        }

    } failure:^(AFHTTPRequestOperation *_operation, NSError *error)
    {
        if (_operation.responseObject)
            [self showError:[@"Failed to upload logs: " stringByAppendingString:[(NSDictionary *)_operation.responseObject objectForKey:@"error"]]];
        else
            [self showError:[@"Failed to upload logs: " stringByAppendingString:error.description]];

        failure();
    }];

    [operation start];
}

@end