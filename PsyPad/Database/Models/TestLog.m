#import "TestLog.h"
#import "TestLogItem.h"

@interface TestLog ()

// Private interface goes here.

@end

@implementation TestLog

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
