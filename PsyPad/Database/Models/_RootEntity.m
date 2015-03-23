// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RootEntity.m instead.

#import "_RootEntity.h"

const struct RootEntityAttributes RootEntityAttributes = {
	.admin_password = @"admin_password",
	.authToken = @"authToken",
	.email = @"email",
	.server_url = @"server_url",
};

@implementation RootEntityID
@end

@implementation _RootEntity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RootEntity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RootEntity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RootEntity" inManagedObjectContext:moc_];
}

- (RootEntityID*)objectID {
	return (RootEntityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic admin_password;

@dynamic authToken;

@dynamic email;

@dynamic server_url;

@end

