//
//  TestLog.m
//  eTASM
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
        if ([logItem.type isEqualToString:@"config_name"])
        {
            return logItem.info;
        }
    }

    return @"config_name not found";
}

@end
