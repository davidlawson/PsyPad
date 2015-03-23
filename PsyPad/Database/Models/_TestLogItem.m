// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestLogItem.m instead.

#import "_TestLogItem.h"

const struct TestLogItemAttributes TestLogItemAttributes = {
	.info = @"info",
	.timestamp = @"timestamp",
	.type = @"type",
};

const struct TestLogItemRelationships TestLogItemRelationships = {
	.log = @"log",
};

@implementation TestLogItemID
@end

@implementation _TestLogItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
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

