// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestLogItem.m instead.

#import "_TestLogItem.h"

@implementation TestLogItemID
@end

@implementation _TestLogItem

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TestLogItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TestLogItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TestLogItem" inManagedObjectContext:moc_];
}

- (TestLogItemID*)objectID {
	return (TestLogItemID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic info;

@dynamic timestamp;

@dynamic type;

@dynamic log;

@end

@implementation TestLogItemAttributes 
+ (NSString *)info {
	return @"info";
}
+ (NSString *)timestamp {
	return @"timestamp";
}
+ (NSString *)type {
	return @"type";
}
@end

@implementation TestLogItemRelationships 
+ (NSString *)log {
	return @"log";
}
@end

