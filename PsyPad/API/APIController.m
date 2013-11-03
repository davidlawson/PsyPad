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

    return [[AFHTTPRequestOperation alloc] initWithRequest:request];
}

- (void)showError:(NSString *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:error
                                                   delegate:nil
                                          cancelButtonTitle:@"Close"
                                          otherButtonTitles:nil];

    dispatch_async(dispatch_get_main_queue(), ^{
        [alert show];
    });
}

- (void)loadServerParticipants:(void (^)(NSMutableArray *serverUsers))success failure:(void (^)())failure
{
    AFHTTPRequestOperation *operation = [self operationWithURL:@"api/list_participants" data:nil];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *_operation, id responseObject)
    {
        NSMutableArray *serverUsers = [NSMutableArray array];

        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:_operation.responseData options:0 error:nil];
        if (!data)
        {
            [self showError:_operation.responseString];
            dispatch_async(dispatch_get_main_queue(), ^{ failure(); });
            return;
        }
        else if (data.count > 0)
        {
            for (NSString *username in [data.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *a, NSString *b) {
                return [a compare:b];
            }])
            {
                NSMutableDictionary *user = [NSMutableDictionary dictionary];
                [user setObject:username forKey:@"username"];
                [user setObject:[data objectForKey:username] forKey:@"description"];
                [serverUsers addObject:user];
            }

            dispatch_async(dispatch_get_main_queue(), ^{ success(serverUsers); });
        }

    } failure:^(AFHTTPRequestOperation *_operation, NSError *error)
    {
        [self showError:error.description];
        dispatch_async(dispatch_get_main_queue(), ^{ failure(); });
    }];

    [operation start];
}

- (void)downloadParticipant:(NSString *)username progress:(void (^)(NSString *status, float progress))progress success:(void (^)(User *newUser))success failure:(void (^)())failure
{
    AFHTTPRequestOperation *operation = [self operationWithURL:[NSString stringWithFormat:@"api/load_participant/%@", username] data:nil];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *_operation, id responseObject)
    {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:_operation.responseData options:0 error:nil];
        if (!data)
        {
            [self showError:_operation.responseString];
            dispatch_async(dispatch_get_main_queue(), ^{ failure(); });
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

            for (NSDictionary *configurationData in data)
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
                    [newConfiguration installSequenceWithURL:image_sequence_url data:image_sequence_data progress:progress sema:sema];
                    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
                }

                [newUser addConfigurationsObject:newConfiguration];
            }

            [APP_DELEGATE saveContext];

            [[APP_DELEGATE managedObjectContext] unlock];

            dispatch_async(dispatch_get_main_queue(), ^{ success(newUser); });
        }
    } failure:^(AFHTTPRequestOperation *_operation, NSError *error)
    {
        [self showError:error.description];
        dispatch_async(dispatch_get_main_queue(), ^{ failure(); });
    }];

    [operation start];
}

@end