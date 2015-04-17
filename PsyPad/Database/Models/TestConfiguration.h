#import "_TestConfiguration.h"

@interface TestConfiguration : _TestConfiguration {}

- (int)countQuestions;

- (void)installSequenceWithURL:(NSString *)url
                        params:(NSDictionary *)params
                          data:(NSDictionary *)data
                      progress:(void (^)(NSString *status, float _progress))progress
                          sema:(dispatch_semaphore_t)sema
                           MOC:(NSManagedObjectContext *)MOC;

- (int)questions_in_folder:(NSString *)name;

- (void)copyFromConfiguration:(TestConfiguration *)configuration;

- (void)loadData:(NSDictionary *)data;

- (NSDictionary *)serialise;

@end
