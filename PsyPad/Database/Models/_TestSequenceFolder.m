// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestSequenceFolder.m instead.

#import "_TestSequenceFolder.h"

const struct TestSequenceFolderAttributes TestSequenceFolderAttributes = {
	.name = @"name",
};

const struct TestSequenceFolderRelationships TestSequenceFolderRelationships = {
	.images = @"images",
	.sequence = @"sequence",
};

@implementation TestSequenceFolderID
@end

@implementation _TestSequenceFolder

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TestSequenceFolder" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TestSequenceFolder";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TestSequenceFolder" inManagedObjectContext:moc_];
}

- (TestSequenceFolderID*)objectID {
	return (TestSequenceFolderID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic images;

- (NSMutableOrderedSet*)imagesSet {
	[self willAccessValueForKey:@"images"];

	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"images"];

	[self didAccessValueForKey:@"images"];
	return result;
}

@dynamic sequence;

@end

@implementation _TestSequenceFolder (ImagesCoreDataGeneratedAccessors)
- (void)addImages:(NSOrderedSet*)value_ {
	[self.imagesSet unionOrderedSet:value_];
}
- (void)removeImages:(NSOrderedSet*)value_ {
	[self.imagesSet minusOrderedSet:value_];
}
- (void)addImagesObject:(TestSequenceImage*)value_ {
	[self.imagesSet addObject:value_];
}
- (void)removeImagesObject:(TestSequenceImage*)value_ {
	[self.imagesSet removeObject:value_];
}
- (void)insertObject:(TestSequenceImage*)value inImagesAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"images"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self images]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"images"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"images"];
}
- (void)removeObjectFromImagesAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"images"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self images]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"images"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"images"];
}
- (void)insertImages:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"images"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self images]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"images"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"images"];
}
- (void)removeImagesAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"images"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self images]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"images"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"images"];
}
- (void)replaceObjectInImagesAtIndex:(NSUInteger)idx withObject:(TestSequenceImage*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"images"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self images]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"images"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"images"];
}
- (void)replaceImagesAtIndexes:(NSIndexSet *)indexes withImages:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"images"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self images]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"images"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"images"];
}
@end

