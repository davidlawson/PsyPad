#import "_User.h"

@interface User : _User {}

- (NSArray *)nonPracticeConfigurations;
- (NSArray *)practiceConfigurations;

- (NSArray *)enabledConfigurations;
- (NSArray *)enabledPracticeConfigurations;

@end
