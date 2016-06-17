// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestLog.m instead.

#import "_TestLog.h"

@implementation TestLogID
@end

@implementation _TestLog

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TestLog" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TestLog";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TestLog" inManagedObjectContext:moc_];
}

- (TestLogID*)objectID {
	return (TestLogID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"uploadedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"uploaded"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic timestamp;

@dynamic uploaded;

- (BOOL)uploadedValue {
	NSNumber *result = [self uploaded];
	return [result boolValue];
}

- (void)setUploadedValue:(BOOL)value_ {
	[self setUploaded:@(value_)];
}

- (BOOL)primitiveUploadedValue {
	NSNumber *result = [self primitiveUploaded];
	return [result boolValue];
}

- (void)setPrimitiveUploadedValue:(BOOL)value_ {
	[self setPrimitiveUploaded:@(value_)];
}

@dynamic logitems;

- (NSMutableOrderedSet<TestLogItem*>*)logitemsSet {
	[self willAccessValueForKey:@"logitems"];

	NSMutableOrderedSet<TestLogItem*> *result = (NSMutableOrderedSet<TestLogItem*>*)[self mutableOrderedSetValueForKey:@"logitems"];

	[self didAccessValueForKey:@"logitems"];
	return result;
}

@dynamic user;

@end

@implementation _TestLog (LogitemsCoreDataGeneratedAccessors)
- (void)addLogitems:(NSOrderedSet<TestLogItem*>*)value_ {
	[self.logitemsSet unionOrderedSet:value_];
}
- (void)removeLogitems:(NSOrderedSet<TestLogItem*>*)value_ {
	[self.logitemsSet minusOrderedSet:value_];
}
- (void)addLogitemsObject:(TestLogItem*)value_ {
	[self.logitemsSet addObject:value_];
}
- (void)removeLogitemsObject:(TestLogItem*)value_ {
	[self.logitemsSet removeObject:value_];
}
- (void)insertObject:(TestLogItem*)value inLogitemsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"logitems"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self logitems]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"logitems"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"logitems"];
}
- (void)removeObjectFromLogitemsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"logitems"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self logitems]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"logitems"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"logitems"];
}
- (void)insertLogitems:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"logitems"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self logitems]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"logitems"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"logitems"];
}
- (void)removeLogitemsAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"logitems"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self logitems]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"logitems"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"logitems"];
}
- (void)replaceObjectInLogitemsAtIndex:(NSUInteger)idx withObject:(TestLogItem*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"logitems"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self logitems]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"logitems"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"logitems"];
}
- (void)replaceLogitemsAtIndexes:(NSIndexSet *)indexes withLogitems:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"logitems"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self logitems]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"logitems"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"logitems"];
}
@end

@implementation TestLogAttributes 
+ (NSString *)timestamp {
	return @"timestamp";
}
+ (NSString *)uploaded {
	return @"uploaded";
}
@end

@implementation TestLogRelationships 
+ (NSString *)logitems {
	return @"logitems";
}
+ (NSString *)user {
	return @"user";
}
@end

