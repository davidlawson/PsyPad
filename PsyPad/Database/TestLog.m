//
//  TestLog.m
//  PsyPad
//
//  Created by David Lawson on 13/12/12.
//

#import "TestLog.h"
#import "User.h"
#import "TestLogItem.h"

@implementation TestLog

@dynamic timestamp;
@dynamic logitems;
@dynamic user;

- (NSString *)getConfigName
{
    for (TestLogItem *logItem in self.logitems)
    {
        if ([logItem.type isEqualToString:@"test_begin"])
        {
            NSDictionary *data = [NSJSONSerialization JSONObjectWithData:[logItem.info dataUsingEncoding:NSUTF8StringEncoding] options:nil error:nil];
            if (data[@"name"])
                return data[@"name"];
        }
    }

    return @"configuration name not found";
}

@end
