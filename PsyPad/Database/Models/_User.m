// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.m instead.

#import "_User.h"

@implementation UserID
@end

@implementation _User

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"User";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"User" inManagedObjectContext:moc_];
}

- (UserID*)objectID {
	return (UserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic id;

@dynamic configurations;

- (NSMutableOrderedSet<TestConfiguration*>*)configurationsSet {
	[self willAccessValueForKey:@"configurations"];

	NSMutableOrderedSet<TestConfiguration*> *result = (NSMutableOrderedSet<TestConfiguration*>*)[self mutableOrderedSetValueForKey:@"configurations"];

	[self didAccessValueForKey:@"configurations"];
	return result;
}

@dynamic logs;

- (NSMutableOrderedSet<TestLog*>*)logsSet {
	[self willAccessValueForKey:@"logs"];

	NSMutableOrderedSet<TestLog*> *result = (NSMutableOrderedSet<TestLog*>*)[self mutableOrderedSetValueForKey:@"logs"];

	[self didAccessValueForKey:@"logs"];
	return result;
}

@end

@implementation _User (ConfigurationsCoreDataGeneratedAccessors)
- (void)addConfigurations:(NSOrderedSet<TestConfiguration*>*)value_ {
	[self.configurationsSet unionOrderedSet:value_];
}
- (void)removeConfigurations:(NSOrderedSet<TestConfiguration*>*)value_ {
	[self.configurationsSet minusOrderedSet:value_];
}
- (void)addConfigurationsObject:(TestConfiguration*)value_ {
	[self.configurationsSet addObject:value_];
}
- (void)removeConfigurationsObject:(TestConfiguration*)value_ {
	[self.configurationsSet removeObject:value_];
}
- (void)insertObject:(TestConfiguration*)value inConfigurationsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"configurations"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self configurations]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"configurations"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"configurations"];
}
- (void)removeObjectFromConfigurationsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"configurations"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self configurations]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"configurations"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"configurations"];
}
- (void)insertConfigurations:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"configurations"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self configurations]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"configurations"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"configurations"];
}
- (void)removeConfigurationsAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"configurations"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self configurations]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"configurations"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"configurations"];
}
- (void)replaceObjectInConfigurationsAtIndex:(NSUInteger)idx withObject:(TestConfiguration*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"configurations"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self configurations]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"configurations"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"configurations"];
}
- (void)replaceConfigurationsAtIndexes:(NSIndexSet *)indexes withConfigurations:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"configurations"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self configurations]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"configurations"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"configurations"];
}
@end

@implementation _User (LogsCoreDataGeneratedAccessors)
- (void)addLogs:(NSOrderedSet<TestLog*>*)value_ {
	[self.logsSet unionOrderedSet:value_];
}
- (void)removeLogs:(NSOrderedSet<TestLog*>*)value_ {
	[self.logsSet minusOrderedSet:value_];
}
- (void)addLogsObject:(TestLog*)value_ {
	[self.logsSet addObject:value_];
}
- (void)removeLogsObject:(TestLog*)value_ {
	[self.logsSet removeObject:value_];
}
- (void)insertObject:(TestLog*)value inLogsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"logs"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self logs]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"logs"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"logs"];
}
- (void)removeObjectFromLogsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"logs"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self logs]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"logs"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"logs"];
}
- (void)insertLogs:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"logs"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self logs]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"logs"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"logs"];
}
- (void)removeLogsAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"logs"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self logs]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"logs"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"logs"];
}
- (void)replaceObjectInLogsAtIndex:(NSUInteger)idx withObject:(TestLog*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"logs"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self logs]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"logs"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"logs"];
}
- (void)replaceLogsAtIndexes:(NSIndexSet *)indexes withLogs:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"logs"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self logs]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"logs"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"logs"];
}
@end

@implementation UserAttributes 
+ (NSString *)id {
	return @"id";
}
@end

@implementation UserRelationships 
+ (NSString *)configurations {
	return @"configurations";
}
+ (NSString *)logs {
	return @"logs";
}
@end

