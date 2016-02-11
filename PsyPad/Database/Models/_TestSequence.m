// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestSequence.m instead.

#import "_TestSequence.h"

const struct TestSequenceAttributes TestSequenceAttributes = {
	.background_length = @"background_length",
	.background_start = @"background_start",
	.correct_wav_length = @"correct_wav_length",
	.correct_wav_start = @"correct_wav_start",
	.incorrect_wav_length = @"incorrect_wav_length",
	.incorrect_wav_start = @"incorrect_wav_start",
	.name = @"name",
	.off_wav_length = @"off_wav_length",
	.off_wav_start = @"off_wav_start",
	.on_wav_length = @"on_wav_length",
	.on_wav_start = @"on_wav_start",
	.path = @"path",
	.timeout_wav_length = @"timeout_wav_length",
	.timeout_wav_start = @"timeout_wav_start",
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
	if ([key isEqualToString:@"correct_wav_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"correct_wav_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"correct_wav_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"correct_wav_start"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"incorrect_wav_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"incorrect_wav_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"incorrect_wav_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"incorrect_wav_start"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"off_wav_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"off_wav_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"off_wav_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"off_wav_start"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"on_wav_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"on_wav_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"on_wav_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"on_wav_start"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"timeout_wav_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"timeout_wav_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"timeout_wav_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"timeout_wav_start"];
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

@dynamic correct_wav_length;

- (int32_t)correct_wav_lengthValue {
	NSNumber *result = [self correct_wav_length];
	return [result intValue];
}

- (void)setCorrect_wav_lengthValue:(int32_t)value_ {
	[self setCorrect_wav_length:@(value_)];
}

- (int32_t)primitiveCorrect_wav_lengthValue {
	NSNumber *result = [self primitiveCorrect_wav_length];
	return [result intValue];
}

- (void)setPrimitiveCorrect_wav_lengthValue:(int32_t)value_ {
	[self setPrimitiveCorrect_wav_length:@(value_)];
}

@dynamic correct_wav_start;

- (int64_t)correct_wav_startValue {
	NSNumber *result = [self correct_wav_start];
	return [result longLongValue];
}

- (void)setCorrect_wav_startValue:(int64_t)value_ {
	[self setCorrect_wav_start:@(value_)];
}

- (int64_t)primitiveCorrect_wav_startValue {
	NSNumber *result = [self primitiveCorrect_wav_start];
	return [result longLongValue];
}

- (void)setPrimitiveCorrect_wav_startValue:(int64_t)value_ {
	[self setPrimitiveCorrect_wav_start:@(value_)];
}

@dynamic incorrect_wav_length;

- (int32_t)incorrect_wav_lengthValue {
	NSNumber *result = [self incorrect_wav_length];
	return [result intValue];
}

- (void)setIncorrect_wav_lengthValue:(int32_t)value_ {
	[self setIncorrect_wav_length:@(value_)];
}

- (int32_t)primitiveIncorrect_wav_lengthValue {
	NSNumber *result = [self primitiveIncorrect_wav_length];
	return [result intValue];
}

- (void)setPrimitiveIncorrect_wav_lengthValue:(int32_t)value_ {
	[self setPrimitiveIncorrect_wav_length:@(value_)];
}

@dynamic incorrect_wav_start;

- (int64_t)incorrect_wav_startValue {
	NSNumber *result = [self incorrect_wav_start];
	return [result longLongValue];
}

- (void)setIncorrect_wav_startValue:(int64_t)value_ {
	[self setIncorrect_wav_start:@(value_)];
}

- (int64_t)primitiveIncorrect_wav_startValue {
	NSNumber *result = [self primitiveIncorrect_wav_start];
	return [result longLongValue];
}

- (void)setPrimitiveIncorrect_wav_startValue:(int64_t)value_ {
	[self setPrimitiveIncorrect_wav_start:@(value_)];
}

@dynamic name;

@dynamic off_wav_length;

- (int32_t)off_wav_lengthValue {
	NSNumber *result = [self off_wav_length];
	return [result intValue];
}

- (void)setOff_wav_lengthValue:(int32_t)value_ {
	[self setOff_wav_length:@(value_)];
}

- (int32_t)primitiveOff_wav_lengthValue {
	NSNumber *result = [self primitiveOff_wav_length];
	return [result intValue];
}

- (void)setPrimitiveOff_wav_lengthValue:(int32_t)value_ {
	[self setPrimitiveOff_wav_length:@(value_)];
}

@dynamic off_wav_start;

- (int64_t)off_wav_startValue {
	NSNumber *result = [self off_wav_start];
	return [result longLongValue];
}

- (void)setOff_wav_startValue:(int64_t)value_ {
	[self setOff_wav_start:@(value_)];
}

- (int64_t)primitiveOff_wav_startValue {
	NSNumber *result = [self primitiveOff_wav_start];
	return [result longLongValue];
}

- (void)setPrimitiveOff_wav_startValue:(int64_t)value_ {
	[self setPrimitiveOff_wav_start:@(value_)];
}

@dynamic on_wav_length;

- (int32_t)on_wav_lengthValue {
	NSNumber *result = [self on_wav_length];
	return [result intValue];
}

- (void)setOn_wav_lengthValue:(int32_t)value_ {
	[self setOn_wav_length:@(value_)];
}

- (int32_t)primitiveOn_wav_lengthValue {
	NSNumber *result = [self primitiveOn_wav_length];
	return [result intValue];
}

- (void)setPrimitiveOn_wav_lengthValue:(int32_t)value_ {
	[self setPrimitiveOn_wav_length:@(value_)];
}

@dynamic on_wav_start;

- (int64_t)on_wav_startValue {
	NSNumber *result = [self on_wav_start];
	return [result longLongValue];
}

- (void)setOn_wav_startValue:(int64_t)value_ {
	[self setOn_wav_start:@(value_)];
}

- (int64_t)primitiveOn_wav_startValue {
	NSNumber *result = [self primitiveOn_wav_start];
	return [result longLongValue];
}

- (void)setPrimitiveOn_wav_startValue:(int64_t)value_ {
	[self setPrimitiveOn_wav_start:@(value_)];
}

@dynamic path;

@dynamic timeout_wav_length;

- (int32_t)timeout_wav_lengthValue {
	NSNumber *result = [self timeout_wav_length];
	return [result intValue];
}

- (void)setTimeout_wav_lengthValue:(int32_t)value_ {
	[self setTimeout_wav_length:@(value_)];
}

- (int32_t)primitiveTimeout_wav_lengthValue {
	NSNumber *result = [self primitiveTimeout_wav_length];
	return [result intValue];
}

- (void)setPrimitiveTimeout_wav_lengthValue:(int32_t)value_ {
	[self setPrimitiveTimeout_wav_length:@(value_)];
}

@dynamic timeout_wav_start;

- (int64_t)timeout_wav_startValue {
	NSNumber *result = [self timeout_wav_start];
	return [result longLongValue];
}

- (void)setTimeout_wav_startValue:(int64_t)value_ {
	[self setTimeout_wav_start:@(value_)];
}

- (int64_t)primitiveTimeout_wav_startValue {
	NSNumber *result = [self primitiveTimeout_wav_start];
	return [result longLongValue];
}

- (void)setPrimitiveTimeout_wav_startValue:(int64_t)value_ {
	[self setPrimitiveTimeout_wav_start:@(value_)];
}

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

