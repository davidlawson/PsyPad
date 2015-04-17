#import "RootEntity.h"

@interface RootEntity ()

// Private interface goes here.

@end

@implementation RootEntity

+ (instancetype)rootEntity
{
    return [self MR_findFirst];
}

- (BOOL)loggedIn
{
    return self.email.length > 0 && self.authToken.length > 0;
}

- (void)loggedInWithEmail:(NSString *)email authToken:(NSString *)authToken
{
    self.email = email;
    self.authToken = authToken;
    self.demoMode = @YES;
    [self.managedObjectContext MR_saveToPersistentStoreAndWait];
}

- (void)loggedOut
{
    self.email = nil;
    self.authToken = nil;
    self.demoMode = @YES;
    [self.managedObjectContext MR_saveToPersistentStoreAndWait];
}

- (void)setServer_url:(NSString *)server_url
{
    [self willChangeValueForKey:RootEntityAttributes.server_url];
    [self setPrimitiveValue:server_url forKey:RootEntityAttributes.server_url];
    [self didChangeValueForKey:RootEntityAttributes.server_url];
    
    [ServerManager sharedManager].baseURL = server_url;
}

@end
