//
// Created by David Lawson on 3/11/2013.
// Copyright (c) 2013 David Lawson. All rights reserved.
//


#import <AFNetworking/AFNetworking.h>
#import "APIController.h"
#import "RootEntity.h"
#import "AppDelegate.h"
#import "User.h"
#import "TestConfiguration.h"
#import "TestLogItem.h"
#import "TestLog.h"
#import "DatabaseManager.h"

@implementation APIController

- (AFHTTPRequestOperation *)operationWithURL:(NSString *)url data:(NSMutableDictionary *)data
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[[RootEntity rootEntity].server_url stringByAppendingString:url]]];
    [request setHTTPMethod:@"POST"];

    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSMutableDictionary *requestData = [NSMutableDictionary dictionary];
    [requestData setObject:[RootEntity rootEntity].email forKey:@"user_email"];
    [requestData setObject:[RootEntity rootEntity].authToken forKey:@"user_token"];

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

                    /*[self downloadParticipant:(NSString *)[user objectForKey:@"username"] progress:^(NSString *status, float _progress)
                    {
                        progress([status stringByAppendingFormat:@" (participant %d/%d)",
                                        (int)[serverUsers indexOfObject:user]+1,
                                        (int)serverUsers.count],
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
                    } supressErrors:NO];*/

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

@end