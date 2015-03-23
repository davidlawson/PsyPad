#import "_TestConfiguration.h"

@interface TestConfiguration : _TestConfiguration {}

- (int)countQuestions;

- (void)installSequenceWithURL:(NSString *)url data:(NSDictionary *)data progress:(void (^)(NSString *status, float _progress))progress sema:(dispatch_semaphore_t)sema;

- (int)questions_in_folder:(NSString *)name;

- (void)copyFromConfiguration:(TestConfiguration *)configuration;

- (void)loadData:(NSDictionary *)data;

- (NSDictionary *)serialise;

@end
