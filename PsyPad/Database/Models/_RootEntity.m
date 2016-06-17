// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RootEntity.m instead.

#import "_RootEntity.h"

@implementation RootEntityID
@end

@implementation _RootEntity

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
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

	if ([key isEqualToString:@"demoModeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"demoMode"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic admin_password;

@dynamic authToken;

@dynamic demoMode;

- (BOOL)demoModeValue {
	NSNumber *result = [self demoMode];
	return [result boolValue];
}

- (void)setDemoModeValue:(BOOL)value_ {
	[self setDemoMode:@(value_)];
}

- (BOOL)primitiveDemoModeValue {
	NSNumber *result = [self primitiveDemoMode];
	return [result boolValue];
}

- (void)setPrimitiveDemoModeValue:(BOOL)value_ {
	[self setPrimitiveDemoMode:@(value_)];
}

@dynamic email;

@dynamic server_url;

@end

@implementation RootEntityAttributes 
+ (NSString *)admin_password {
	return @"admin_password";
}
+ (NSString *)authToken {
	return @"authToken";
}
+ (NSString *)demoMode {
	return @"demoMode";
}
+ (NSString *)email {
	return @"email";
}
+ (NSString *)server_url {
	return @"server_url";
}
@end

