// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestSequenceImage.m instead.

#import "_TestSequenceImage.h"

const struct TestSequenceImageAttributes TestSequenceImageAttributes = {
	.animated_images = @"animated_images",
	.is_animated = @"is_animated",
	.length = @"length",
	.name = @"name",
	.start = @"start",
};

const struct TestSequenceImageRelationships TestSequenceImageRelationships = {
	.folder = @"folder",
};

@implementation TestSequenceImageID
@end

@implementation _TestSequenceImage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TestSequenceImage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TestSequenceImage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TestSequenceImage" inManagedObjectContext:moc_];
}

- (TestSequenceImageID*)objectID {
	return (TestSequenceImageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"is_animatedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"is_animated"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"start"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic animated_images;

@dynamic is_animated;

- (BOOL)is_animatedValue {
	NSNumber *result = [self is_animated];
	return [result boolValue];
}

- (void)setIs_animatedValue:(BOOL)value_ {
	[self setIs_animated:@(value_)];
}

- (BOOL)primitiveIs_animatedValue {
	NSNumber *result = [self primitiveIs_animated];
	return [result boolValue];
}

- (void)setPrimitiveIs_animatedValue:(BOOL)value_ {
	[self setPrimitiveIs_animated:@(value_)];
}

@dynamic length;

- (int32_t)lengthValue {
	NSNumber *result = [self length];
	return [result intValue];
}

- (void)setLengthValue:(int32_t)value_ {
	[self setLength:@(value_)];
}

- (int32_t)primitiveLengthValue {
	NSNumber *result = [self primitiveLength];
	return [result intValue];
}

- (void)setPrimitiveLengthValue:(int32_t)value_ {
	[self setPrimitiveLength:@(value_)];
}

@dynamic name;

@dynamic start;

- (int64_t)startValue {
	NSNumber *result = [self start];
	return [result longLongValue];
}

- (void)setStartValue:(int64_t)value_ {
	[self setStart:@(value_)];
}

- (int64_t)primitiveStartValue {
	NSNumber *result = [self primitiveStart];
	return [result longLongValue];
}

- (void)setPrimitiveStartValue:(int64_t)value_ {
	[self setPrimitiveStart:@(value_)];
}

@dynamic folder;

@end

