// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestSequence.m instead.

#import "_TestSequence.h"

const struct TestSequenceAttributes TestSequenceAttributes = {
	.background_length = @"background_length",
	.background_start = @"background_start",
	.name = @"name",
	.path = @"path",
	.title_length = @"title_length",
	.title_start = @"title_start",
	.url = @"url",
};

const struct TestSequenceRelationships TestSequenceRelationships = {
	.folders = @"folders",
	.testConfigurations = @"testConfigurations",
};

@implementation TestSequenceID
@end

@implementation _TestSequence

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TestSequence" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TestSequence";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TestSequence" inManagedObjectContext:moc_];
}

- (TestSequenceID*)objectID {
	return (TestSequenceID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"background_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"background_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"background_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"background_start"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"title_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"title_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"title_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"title_start"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic background_length;

- (int32_t)background_lengthValue {
	NSNumber *result = [self background_length];
	return [result intValue];
}

- (void)setBackground_lengthValue:(int32_t)value_ {
	[self setBackground_length:@(value_)];
}

- (int32_t)primitiveBackground_lengthValue {
	NSNumber *result = [self primitiveBackground_length];
	return [result intValue];
}

- (void)setPrimitiveBackground_lengthValue:(int32_t)value_ {
	[self setPrimitiveBackground_length:@(value_)];
}

@dynamic background_start;

- (int64_t)background_startValue {
	NSNumber *result = [self background_start];
	return [result longLongValue];
}

- (void)setBackground_startValue:(int64_t)value_ {
	[self setBackground_start:@(value_)];
}

- (int64_t)primitiveBackground_startValue {
	NSNumber *result = [self primitiveBackground_start];
	return [result longLongValue];
}

- (void)setPrimitiveBackground_startValue:(int64_t)value_ {
	[self setPrimitiveBackground_start:@(value_)];
}

@dynamic name;

@dynamic path;

@dynamic title_length;

- (int32_t)title_lengthValue {
	NSNumber *result = [self title_length];
	return [result intValue];
}

- (void)setTitle_lengthValue:(int32_t)value_ {
	[self setTitle_length:@(value_)];
}

- (int32_t)primitiveTitle_lengthValue {
	NSNumber *result = [self primitiveTitle_length];
	return [result intValue];
}

- (void)setPrimitiveTitle_lengthValue:(int32_t)value_ {
	[self setPrimitiveTitle_length:@(value_)];
}

@dynamic title_start;

- (int64_t)title_startValue {
	NSNumber *result = [self title_start];
	return [result longLongValue];
}

- (void)setTitle_startValue:(int64_t)value_ {
	[self setTitle_start:@(value_)];
}

- (int64_t)primitiveTitle_startValue {
	NSNumber *result = [self primitiveTitle_start];
	return [result longLongValue];
}

- (void)setPrimitiveTitle_startValue:(int64_t)value_ {
	[self setPrimitiveTitle_start:@(value_)];
}

@dynamic url;

@dynamic folders;

- (NSMutableOrderedSet*)foldersSet {
	[self willAccessValueForKey:@"folders"];

	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"folders"];

	[self didAccessValueForKey:@"folders"];
	return result;
}

@dynamic testConfigurations;

- (NSMutableSet*)testConfigurationsSet {
	[self willAccessValueForKey:@"testConfigurations"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"testConfigurations"];

	[self didAccessValueForKey:@"testConfigurations"];
	return result;
}

@end

@implementation _TestSequence (FoldersCoreDataGeneratedAccessors)
- (void)addFolders:(NSOrderedSet*)value_ {
	[self.foldersSet unionOrderedSet:value_];
}
- (void)removeFolders:(NSOrderedSet*)value_ {
	[self.foldersSet minusOrderedSet:value_];
}
- (void)addFoldersObject:(TestSequenceFolder*)value_ {
	[self.foldersSet addObject:value_];
}
- (void)removeFoldersObject:(TestSequenceFolder*)value_ {
	[self.foldersSet removeObject:value_];
}
- (void)insertObject:(TestSequenceFolder*)value inFoldersAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"folders"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self folders]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"folders"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"folders"];
}
- (void)removeObjectFromFoldersAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"folders"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self folders]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"folders"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"folders"];
}
- (void)insertFolders:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"folders"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self folders]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"folders"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"folders"];
}
- (void)removeFoldersAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"folders"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self folders]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"folders"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"folders"];
}
- (void)replaceObjectInFoldersAtIndex:(NSUInteger)idx withObject:(TestSequenceFolder*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"folders"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self folders]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"folders"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"folders"];
}
- (void)replaceFoldersAtIndexes:(NSIndexSet *)indexes withFolders:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"folders"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self folders]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"folders"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"folders"];
}
@end

