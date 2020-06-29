// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestSequence.m instead.

#import "_TestSequence.h"

@implementation TestSequenceID
@end

@implementation _TestSequence

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
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
	if ([key isEqualToString:@"button1_image_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button1_image_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button1_image_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button1_image_start"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button2_image_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button2_image_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button2_image_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button2_image_start"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button3_image_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button3_image_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button3_image_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button3_image_start"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button4_image_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button4_image_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button4_image_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button4_image_start"];
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
	if ([key isEqualToString:@"secondary_button1_image_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"secondary_button1_image_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"secondary_button1_image_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"secondary_button1_image_start"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"secondary_button2_image_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"secondary_button2_image_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"secondary_button2_image_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"secondary_button2_image_start"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"secondary_button3_image_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"secondary_button3_image_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"secondary_button3_image_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"secondary_button3_image_start"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"secondary_button4_image_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"secondary_button4_image_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"secondary_button4_image_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"secondary_button4_image_start"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"secondary_image1_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"secondary_image1_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"secondary_image1_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"secondary_image1_start"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"secondary_image2_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"secondary_image2_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"secondary_image2_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"secondary_image2_start"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"secondary_image3_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"secondary_image3_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"secondary_image3_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"secondary_image3_start"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"secondary_image4_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"secondary_image4_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"secondary_image4_startValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"secondary_image4_start"];
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

@dynamic button1_image_length;

- (int32_t)button1_image_lengthValue {
	NSNumber *result = [self button1_image_length];
	return [result intValue];
}

- (void)setButton1_image_lengthValue:(int32_t)value_ {
	[self setButton1_image_length:@(value_)];
}

- (int32_t)primitiveButton1_image_lengthValue {
	NSNumber *result = [self primitiveButton1_image_length];
	return [result intValue];
}

- (void)setPrimitiveButton1_image_lengthValue:(int32_t)value_ {
	[self setPrimitiveButton1_image_length:@(value_)];
}

@dynamic button1_image_start;

- (int64_t)button1_image_startValue {
	NSNumber *result = [self button1_image_start];
	return [result longLongValue];
}

- (void)setButton1_image_startValue:(int64_t)value_ {
	[self setButton1_image_start:@(value_)];
}

- (int64_t)primitiveButton1_image_startValue {
	NSNumber *result = [self primitiveButton1_image_start];
	return [result longLongValue];
}

- (void)setPrimitiveButton1_image_startValue:(int64_t)value_ {
	[self setPrimitiveButton1_image_start:@(value_)];
}

@dynamic button2_image_length;

- (int32_t)button2_image_lengthValue {
	NSNumber *result = [self button2_image_length];
	return [result intValue];
}

- (void)setButton2_image_lengthValue:(int32_t)value_ {
	[self setButton2_image_length:@(value_)];
}

- (int32_t)primitiveButton2_image_lengthValue {
	NSNumber *result = [self primitiveButton2_image_length];
	return [result intValue];
}

- (void)setPrimitiveButton2_image_lengthValue:(int32_t)value_ {
	[self setPrimitiveButton2_image_length:@(value_)];
}

@dynamic button2_image_start;

- (int64_t)button2_image_startValue {
	NSNumber *result = [self button2_image_start];
	return [result longLongValue];
}

- (void)setButton2_image_startValue:(int64_t)value_ {
	[self setButton2_image_start:@(value_)];
}

- (int64_t)primitiveButton2_image_startValue {
	NSNumber *result = [self primitiveButton2_image_start];
	return [result longLongValue];
}

- (void)setPrimitiveButton2_image_startValue:(int64_t)value_ {
	[self setPrimitiveButton2_image_start:@(value_)];
}

@dynamic button3_image_length;

- (int32_t)button3_image_lengthValue {
	NSNumber *result = [self button3_image_length];
	return [result intValue];
}

- (void)setButton3_image_lengthValue:(int32_t)value_ {
	[self setButton3_image_length:@(value_)];
}

- (int32_t)primitiveButton3_image_lengthValue {
	NSNumber *result = [self primitiveButton3_image_length];
	return [result intValue];
}

- (void)setPrimitiveButton3_image_lengthValue:(int32_t)value_ {
	[self setPrimitiveButton3_image_length:@(value_)];
}

@dynamic button3_image_start;

- (int64_t)button3_image_startValue {
	NSNumber *result = [self button3_image_start];
	return [result longLongValue];
}

- (void)setButton3_image_startValue:(int64_t)value_ {
	[self setButton3_image_start:@(value_)];
}

- (int64_t)primitiveButton3_image_startValue {
	NSNumber *result = [self primitiveButton3_image_start];
	return [result longLongValue];
}

- (void)setPrimitiveButton3_image_startValue:(int64_t)value_ {
	[self setPrimitiveButton3_image_start:@(value_)];
}

@dynamic button4_image_length;

- (int32_t)button4_image_lengthValue {
	NSNumber *result = [self button4_image_length];
	return [result intValue];
}

- (void)setButton4_image_lengthValue:(int32_t)value_ {
	[self setButton4_image_length:@(value_)];
}

- (int32_t)primitiveButton4_image_lengthValue {
	NSNumber *result = [self primitiveButton4_image_length];
	return [result intValue];
}

- (void)setPrimitiveButton4_image_lengthValue:(int32_t)value_ {
	[self setPrimitiveButton4_image_length:@(value_)];
}

@dynamic button4_image_start;

- (int64_t)button4_image_startValue {
	NSNumber *result = [self button4_image_start];
	return [result longLongValue];
}

- (void)setButton4_image_startValue:(int64_t)value_ {
	[self setButton4_image_start:@(value_)];
}

- (int64_t)primitiveButton4_image_startValue {
	NSNumber *result = [self primitiveButton4_image_start];
	return [result longLongValue];
}

- (void)setPrimitiveButton4_image_startValue:(int64_t)value_ {
	[self setPrimitiveButton4_image_start:@(value_)];
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

@dynamic secondary_button1_image_length;

- (int32_t)secondary_button1_image_lengthValue {
	NSNumber *result = [self secondary_button1_image_length];
	return [result intValue];
}

- (void)setSecondary_button1_image_lengthValue:(int32_t)value_ {
	[self setSecondary_button1_image_length:@(value_)];
}

- (int32_t)primitiveSecondary_button1_image_lengthValue {
	NSNumber *result = [self primitiveSecondary_button1_image_length];
	return [result intValue];
}

- (void)setPrimitiveSecondary_button1_image_lengthValue:(int32_t)value_ {
	[self setPrimitiveSecondary_button1_image_length:@(value_)];
}

@dynamic secondary_button1_image_start;

- (int64_t)secondary_button1_image_startValue {
	NSNumber *result = [self secondary_button1_image_start];
	return [result longLongValue];
}

- (void)setSecondary_button1_image_startValue:(int64_t)value_ {
	[self setSecondary_button1_image_start:@(value_)];
}

- (int64_t)primitiveSecondary_button1_image_startValue {
	NSNumber *result = [self primitiveSecondary_button1_image_start];
	return [result longLongValue];
}

- (void)setPrimitiveSecondary_button1_image_startValue:(int64_t)value_ {
	[self setPrimitiveSecondary_button1_image_start:@(value_)];
}

@dynamic secondary_button2_image_length;

- (int32_t)secondary_button2_image_lengthValue {
	NSNumber *result = [self secondary_button2_image_length];
	return [result intValue];
}

- (void)setSecondary_button2_image_lengthValue:(int32_t)value_ {
	[self setSecondary_button2_image_length:@(value_)];
}

- (int32_t)primitiveSecondary_button2_image_lengthValue {
	NSNumber *result = [self primitiveSecondary_button2_image_length];
	return [result intValue];
}

- (void)setPrimitiveSecondary_button2_image_lengthValue:(int32_t)value_ {
	[self setPrimitiveSecondary_button2_image_length:@(value_)];
}

@dynamic secondary_button2_image_start;

- (int64_t)secondary_button2_image_startValue {
	NSNumber *result = [self secondary_button2_image_start];
	return [result longLongValue];
}

- (void)setSecondary_button2_image_startValue:(int64_t)value_ {
	[self setSecondary_button2_image_start:@(value_)];
}

- (int64_t)primitiveSecondary_button2_image_startValue {
	NSNumber *result = [self primitiveSecondary_button2_image_start];
	return [result longLongValue];
}

- (void)setPrimitiveSecondary_button2_image_startValue:(int64_t)value_ {
	[self setPrimitiveSecondary_button2_image_start:@(value_)];
}

@dynamic secondary_button3_image_length;

- (int32_t)secondary_button3_image_lengthValue {
	NSNumber *result = [self secondary_button3_image_length];
	return [result intValue];
}

- (void)setSecondary_button3_image_lengthValue:(int32_t)value_ {
	[self setSecondary_button3_image_length:@(value_)];
}

- (int32_t)primitiveSecondary_button3_image_lengthValue {
	NSNumber *result = [self primitiveSecondary_button3_image_length];
	return [result intValue];
}

- (void)setPrimitiveSecondary_button3_image_lengthValue:(int32_t)value_ {
	[self setPrimitiveSecondary_button3_image_length:@(value_)];
}

@dynamic secondary_button3_image_start;

- (int64_t)secondary_button3_image_startValue {
	NSNumber *result = [self secondary_button3_image_start];
	return [result longLongValue];
}

- (void)setSecondary_button3_image_startValue:(int64_t)value_ {
	[self setSecondary_button3_image_start:@(value_)];
}

- (int64_t)primitiveSecondary_button3_image_startValue {
	NSNumber *result = [self primitiveSecondary_button3_image_start];
	return [result longLongValue];
}

- (void)setPrimitiveSecondary_button3_image_startValue:(int64_t)value_ {
	[self setPrimitiveSecondary_button3_image_start:@(value_)];
}

@dynamic secondary_button4_image_length;

- (int32_t)secondary_button4_image_lengthValue {
	NSNumber *result = [self secondary_button4_image_length];
	return [result intValue];
}

- (void)setSecondary_button4_image_lengthValue:(int32_t)value_ {
	[self setSecondary_button4_image_length:@(value_)];
}

- (int32_t)primitiveSecondary_button4_image_lengthValue {
	NSNumber *result = [self primitiveSecondary_button4_image_length];
	return [result intValue];
}

- (void)setPrimitiveSecondary_button4_image_lengthValue:(int32_t)value_ {
	[self setPrimitiveSecondary_button4_image_length:@(value_)];
}

@dynamic secondary_button4_image_start;

- (int64_t)secondary_button4_image_startValue {
	NSNumber *result = [self secondary_button4_image_start];
	return [result longLongValue];
}

- (void)setSecondary_button4_image_startValue:(int64_t)value_ {
	[self setSecondary_button4_image_start:@(value_)];
}

- (int64_t)primitiveSecondary_button4_image_startValue {
	NSNumber *result = [self primitiveSecondary_button4_image_start];
	return [result longLongValue];
}

- (void)setPrimitiveSecondary_button4_image_startValue:(int64_t)value_ {
	[self setPrimitiveSecondary_button4_image_start:@(value_)];
}

@dynamic secondary_image1_length;

- (int32_t)secondary_image1_lengthValue {
	NSNumber *result = [self secondary_image1_length];
	return [result intValue];
}

- (void)setSecondary_image1_lengthValue:(int32_t)value_ {
	[self setSecondary_image1_length:@(value_)];
}

- (int32_t)primitiveSecondary_image1_lengthValue {
	NSNumber *result = [self primitiveSecondary_image1_length];
	return [result intValue];
}

- (void)setPrimitiveSecondary_image1_lengthValue:(int32_t)value_ {
	[self setPrimitiveSecondary_image1_length:@(value_)];
}

@dynamic secondary_image1_start;

- (int64_t)secondary_image1_startValue {
	NSNumber *result = [self secondary_image1_start];
	return [result longLongValue];
}

- (void)setSecondary_image1_startValue:(int64_t)value_ {
	[self setSecondary_image1_start:@(value_)];
}

- (int64_t)primitiveSecondary_image1_startValue {
	NSNumber *result = [self primitiveSecondary_image1_start];
	return [result longLongValue];
}

- (void)setPrimitiveSecondary_image1_startValue:(int64_t)value_ {
	[self setPrimitiveSecondary_image1_start:@(value_)];
}

@dynamic secondary_image2_length;

- (int32_t)secondary_image2_lengthValue {
	NSNumber *result = [self secondary_image2_length];
	return [result intValue];
}

- (void)setSecondary_image2_lengthValue:(int32_t)value_ {
	[self setSecondary_image2_length:@(value_)];
}

- (int32_t)primitiveSecondary_image2_lengthValue {
	NSNumber *result = [self primitiveSecondary_image2_length];
	return [result intValue];
}

- (void)setPrimitiveSecondary_image2_lengthValue:(int32_t)value_ {
	[self setPrimitiveSecondary_image2_length:@(value_)];
}

@dynamic secondary_image2_start;

- (int64_t)secondary_image2_startValue {
	NSNumber *result = [self secondary_image2_start];
	return [result longLongValue];
}

- (void)setSecondary_image2_startValue:(int64_t)value_ {
	[self setSecondary_image2_start:@(value_)];
}

- (int64_t)primitiveSecondary_image2_startValue {
	NSNumber *result = [self primitiveSecondary_image2_start];
	return [result longLongValue];
}

- (void)setPrimitiveSecondary_image2_startValue:(int64_t)value_ {
	[self setPrimitiveSecondary_image2_start:@(value_)];
}

@dynamic secondary_image3_length;

- (int32_t)secondary_image3_lengthValue {
	NSNumber *result = [self secondary_image3_length];
	return [result intValue];
}

- (void)setSecondary_image3_lengthValue:(int32_t)value_ {
	[self setSecondary_image3_length:@(value_)];
}

- (int32_t)primitiveSecondary_image3_lengthValue {
	NSNumber *result = [self primitiveSecondary_image3_length];
	return [result intValue];
}

- (void)setPrimitiveSecondary_image3_lengthValue:(int32_t)value_ {
	[self setPrimitiveSecondary_image3_length:@(value_)];
}

@dynamic secondary_image3_start;

- (int64_t)secondary_image3_startValue {
	NSNumber *result = [self secondary_image3_start];
	return [result longLongValue];
}

- (void)setSecondary_image3_startValue:(int64_t)value_ {
	[self setSecondary_image3_start:@(value_)];
}

- (int64_t)primitiveSecondary_image3_startValue {
	NSNumber *result = [self primitiveSecondary_image3_start];
	return [result longLongValue];
}

- (void)setPrimitiveSecondary_image3_startValue:(int64_t)value_ {
	[self setPrimitiveSecondary_image3_start:@(value_)];
}

@dynamic secondary_image4_length;

- (int32_t)secondary_image4_lengthValue {
	NSNumber *result = [self secondary_image4_length];
	return [result intValue];
}

- (void)setSecondary_image4_lengthValue:(int32_t)value_ {
	[self setSecondary_image4_length:@(value_)];
}

- (int32_t)primitiveSecondary_image4_lengthValue {
	NSNumber *result = [self primitiveSecondary_image4_length];
	return [result intValue];
}

- (void)setPrimitiveSecondary_image4_lengthValue:(int32_t)value_ {
	[self setPrimitiveSecondary_image4_length:@(value_)];
}

@dynamic secondary_image4_start;

- (int64_t)secondary_image4_startValue {
	NSNumber *result = [self secondary_image4_start];
	return [result longLongValue];
}

- (void)setSecondary_image4_startValue:(int64_t)value_ {
	[self setSecondary_image4_start:@(value_)];
}

- (int64_t)primitiveSecondary_image4_startValue {
	NSNumber *result = [self primitiveSecondary_image4_start];
	return [result longLongValue];
}

- (void)setPrimitiveSecondary_image4_startValue:(int64_t)value_ {
	[self setPrimitiveSecondary_image4_start:@(value_)];
}

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

- (NSMutableOrderedSet<TestSequenceFolder*>*)foldersSet {
	[self willAccessValueForKey:@"folders"];

	NSMutableOrderedSet<TestSequenceFolder*> *result = (NSMutableOrderedSet<TestSequenceFolder*>*)[self mutableOrderedSetValueForKey:@"folders"];

	[self didAccessValueForKey:@"folders"];
	return result;
}

@dynamic testConfigurations;

- (NSMutableSet<TestConfiguration*>*)testConfigurationsSet {
	[self willAccessValueForKey:@"testConfigurations"];

	NSMutableSet<TestConfiguration*> *result = (NSMutableSet<TestConfiguration*>*)[self mutableSetValueForKey:@"testConfigurations"];

	[self didAccessValueForKey:@"testConfigurations"];
	return result;
}

@end

@implementation _TestSequence (FoldersCoreDataGeneratedAccessors)
- (void)addFolders:(NSOrderedSet<TestSequenceFolder*>*)value_ {
	[self.foldersSet unionOrderedSet:value_];
}
- (void)removeFolders:(NSOrderedSet<TestSequenceFolder*>*)value_ {
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
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self folders] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"folders"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"folders"];
}
- (void)removeObjectFromFoldersAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"folders"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self folders] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"folders"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"folders"];
}
- (void)insertFolders:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"folders"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self folders] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"folders"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"folders"];
}
- (void)removeFoldersAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"folders"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self folders] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"folders"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"folders"];
}
- (void)replaceObjectInFoldersAtIndex:(NSUInteger)idx withObject:(TestSequenceFolder*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"folders"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self folders] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"folders"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"folders"];
}
- (void)replaceFoldersAtIndexes:(NSIndexSet *)indexes withFolders:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"folders"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self folders] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"folders"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"folders"];
}
@end

@implementation TestSequenceAttributes 
+ (NSString *)background_length {
	return @"background_length";
}
+ (NSString *)background_start {
	return @"background_start";
}
+ (NSString *)button1_image_length {
	return @"button1_image_length";
}
+ (NSString *)button1_image_start {
	return @"button1_image_start";
}
+ (NSString *)button2_image_length {
	return @"button2_image_length";
}
+ (NSString *)button2_image_start {
	return @"button2_image_start";
}
+ (NSString *)button3_image_length {
	return @"button3_image_length";
}
+ (NSString *)button3_image_start {
	return @"button3_image_start";
}
+ (NSString *)button4_image_length {
	return @"button4_image_length";
}
+ (NSString *)button4_image_start {
	return @"button4_image_start";
}
+ (NSString *)correct_wav_length {
	return @"correct_wav_length";
}
+ (NSString *)correct_wav_start {
	return @"correct_wav_start";
}
+ (NSString *)incorrect_wav_length {
	return @"incorrect_wav_length";
}
+ (NSString *)incorrect_wav_start {
	return @"incorrect_wav_start";
}
+ (NSString *)name {
	return @"name";
}
+ (NSString *)off_wav_length {
	return @"off_wav_length";
}
+ (NSString *)off_wav_start {
	return @"off_wav_start";
}
+ (NSString *)on_wav_length {
	return @"on_wav_length";
}
+ (NSString *)on_wav_start {
	return @"on_wav_start";
}
+ (NSString *)path {
	return @"path";
}
+ (NSString *)secondary_button1_image_length {
	return @"secondary_button1_image_length";
}
+ (NSString *)secondary_button1_image_start {
	return @"secondary_button1_image_start";
}
+ (NSString *)secondary_button2_image_length {
	return @"secondary_button2_image_length";
}
+ (NSString *)secondary_button2_image_start {
	return @"secondary_button2_image_start";
}
+ (NSString *)secondary_button3_image_length {
	return @"secondary_button3_image_length";
}
+ (NSString *)secondary_button3_image_start {
	return @"secondary_button3_image_start";
}
+ (NSString *)secondary_button4_image_length {
	return @"secondary_button4_image_length";
}
+ (NSString *)secondary_button4_image_start {
	return @"secondary_button4_image_start";
}
+ (NSString *)secondary_image1_length {
	return @"secondary_image1_length";
}
+ (NSString *)secondary_image1_start {
	return @"secondary_image1_start";
}
+ (NSString *)secondary_image2_length {
	return @"secondary_image2_length";
}
+ (NSString *)secondary_image2_start {
	return @"secondary_image2_start";
}
+ (NSString *)secondary_image3_length {
	return @"secondary_image3_length";
}
+ (NSString *)secondary_image3_start {
	return @"secondary_image3_start";
}
+ (NSString *)secondary_image4_length {
	return @"secondary_image4_length";
}
+ (NSString *)secondary_image4_start {
	return @"secondary_image4_start";
}
+ (NSString *)timeout_wav_length {
	return @"timeout_wav_length";
}
+ (NSString *)timeout_wav_start {
	return @"timeout_wav_start";
}
+ (NSString *)title_length {
	return @"title_length";
}
+ (NSString *)title_start {
	return @"title_start";
}
+ (NSString *)url {
	return @"url";
}
@end

@implementation TestSequenceRelationships 
+ (NSString *)folders {
	return @"folders";
}
+ (NSString *)testConfigurations {
	return @"testConfigurations";
}
@end

