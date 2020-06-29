// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestSequenceFolder.m instead.

#import "_TestSequenceFolder.h"

@implementation TestSequenceFolderID
@end

@implementation _TestSequenceFolder

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
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

- (NSMutableOrderedSet<TestSequenceImage*>*)imagesSet {
	[self willAccessValueForKey:@"images"];

	NSMutableOrderedSet<TestSequenceImage*> *result = (NSMutableOrderedSet<TestSequenceImage*>*)[self mutableOrderedSetValueForKey:@"images"];

	[self didAccessValueForKey:@"images"];
	return result;
}

@dynamic sequence;

@end

@implementation _TestSequenceFolder (ImagesCoreDataGeneratedAccessors)
- (void)addImages:(NSOrderedSet<TestSequenceImage*>*)value_ {
	[self.imagesSet unionOrderedSet:value_];
}
- (void)removeImages:(NSOrderedSet<TestSequenceImage*>*)value_ {
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
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self images] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"images"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"images"];
}
- (void)removeObjectFromImagesAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"images"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self images] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"images"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"images"];
}
- (void)insertImages:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"images"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self images] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"images"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"images"];
}
- (void)removeImagesAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"images"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self images] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"images"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"images"];
}
- (void)replaceObjectInImagesAtIndex:(NSUInteger)idx withObject:(TestSequenceImage*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"images"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self images] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"images"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"images"];
}
- (void)replaceImagesAtIndexes:(NSIndexSet *)indexes withImages:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"images"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self images] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"images"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"images"];
}
@end

@implementation TestSequenceFolderAttributes 
+ (NSString *)name {
	return @"name";
}
@end

@implementation TestSequenceFolderRelationships 
+ (NSString *)images {
	return @"images";
}
+ (NSString *)sequence {
	return @"sequence";
}
@end

