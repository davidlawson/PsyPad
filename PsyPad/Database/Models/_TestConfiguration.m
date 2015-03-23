// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestConfiguration.m instead.

#import "_TestConfiguration.h"

const struct TestConfigurationAttributes TestConfigurationAttributes = {
	.animation_frame_rate = @"animation_frame_rate",
	.attempt_facial_recognition = @"attempt_facial_recognition",
	.background_colour = @"background_colour",
	.button1_bg = @"button1_bg",
	.button1_fg = @"button1_fg",
	.button1_h = @"button1_h",
	.button1_w = @"button1_w",
	.button1_x = @"button1_x",
	.button1_y = @"button1_y",
	.button2_bg = @"button2_bg",
	.button2_fg = @"button2_fg",
	.button2_h = @"button2_h",
	.button2_w = @"button2_w",
	.button2_x = @"button2_x",
	.button2_y = @"button2_y",
	.button3_bg = @"button3_bg",
	.button3_fg = @"button3_fg",
	.button3_h = @"button3_h",
	.button3_w = @"button3_w",
	.button3_x = @"button3_x",
	.button3_y = @"button3_y",
	.button4_bg = @"button4_bg",
	.button4_fg = @"button4_fg",
	.button4_h = @"button4_h",
	.button4_w = @"button4_w",
	.button4_x = @"button4_x",
	.button4_y = @"button4_y",
	.button_presentation_delay = @"button_presentation_delay",
	.button_text_four = @"button_text_four",
	.button_text_one = @"button_text_one",
	.button_text_three = @"button_text_three",
	.button_text_two = @"button_text_two",
	.day_of_week_fri = @"day_of_week_fri",
	.day_of_week_mon = @"day_of_week_mon",
	.day_of_week_sat = @"day_of_week_sat",
	.day_of_week_sun = @"day_of_week_sun",
	.day_of_week_thu = @"day_of_week_thu",
	.day_of_week_tue = @"day_of_week_tue",
	.day_of_week_wed = @"day_of_week_wed",
	.enabled = @"enabled",
	.exit_button_bg = @"exit_button_bg",
	.exit_button_fg = @"exit_button_fg",
	.exit_button_h = @"exit_button_h",
	.exit_button_w = @"exit_button_w",
	.exit_button_x = @"exit_button_x",
	.exit_button_y = @"exit_button_y",
	.images_together_presentation_time = @"images_together_presentation_time",
	.images_together_presentation_time_is_infinite = @"images_together_presentation_time_is_infinite",
	.loop_animated_images = @"loop_animated_images",
	.name = @"name",
	.num_staircases_interleaved = @"num_staircases_interleaved",
	.number_of_buttons = @"number_of_buttons",
	.practice_configuration = @"practice_configuration",
	.questions_per_folder = @"questions_per_folder",
	.randomisation_specified_seed = @"randomisation_specified_seed",
	.randomisation_use_specified_seed = @"randomisation_use_specified_seed",
	.require_next = @"require_next",
	.response_window = @"response_window",
	.response_window_is_infinite = @"response_window_is_infinite",
	.show_exit_button = @"show_exit_button",
	.staircase_deltas = @"staircase_deltas",
	.staircase_floor_ceiling_hits = @"staircase_floor_ceiling_hits",
	.staircase_max_level = @"staircase_max_level",
	.staircase_min_level = @"staircase_min_level",
	.staircase_num_correct_to_get_harder = @"staircase_num_correct_to_get_harder",
	.staircase_num_incorrect_to_get_easier = @"staircase_num_incorrect_to_get_easier",
	.staircase_num_reversals = @"staircase_num_reversals",
	.staircase_start_level = @"staircase_start_level",
	.time_between_question_mean = @"time_between_question_mean",
	.time_between_question_plusminus = @"time_between_question_plusminus",
	.use_staircase_method = @"use_staircase_method",
};

const struct TestConfigurationRelationships TestConfigurationRelationships = {
	.sequence = @"sequence",
	.user = @"user",
};

@implementation TestConfigurationID
@end

@implementation _TestConfiguration

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TestConfiguration" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TestConfiguration";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TestConfiguration" inManagedObjectContext:moc_];
}

- (TestConfigurationID*)objectID {
	return (TestConfigurationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"animation_frame_rateValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"animation_frame_rate"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"attempt_facial_recognitionValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"attempt_facial_recognition"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button1_hValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button1_h"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button1_wValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button1_w"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button1_xValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button1_x"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button1_yValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button1_y"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button2_hValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button2_h"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button2_wValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button2_w"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button2_xValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button2_x"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button2_yValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button2_y"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button3_hValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button3_h"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button3_wValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button3_w"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button3_xValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button3_x"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button3_yValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button3_y"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button4_hValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button4_h"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button4_wValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button4_w"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button4_xValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button4_x"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button4_yValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button4_y"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"button_presentation_delayValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"button_presentation_delay"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"day_of_week_friValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"day_of_week_fri"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"day_of_week_monValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"day_of_week_mon"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"day_of_week_satValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"day_of_week_sat"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"day_of_week_sunValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"day_of_week_sun"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"day_of_week_thuValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"day_of_week_thu"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"day_of_week_tueValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"day_of_week_tue"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"day_of_week_wedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"day_of_week_wed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"enabledValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"enabled"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"exit_button_hValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"exit_button_h"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"exit_button_wValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"exit_button_w"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"exit_button_xValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"exit_button_x"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"exit_button_yValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"exit_button_y"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"images_together_presentation_timeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"images_together_presentation_time"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"images_together_presentation_time_is_infiniteValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"images_together_presentation_time_is_infinite"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"loop_animated_imagesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"loop_animated_images"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"num_staircases_interleavedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"num_staircases_interleaved"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"number_of_buttonsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"number_of_buttons"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"practice_configurationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"practice_configuration"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"randomisation_specified_seedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"randomisation_specified_seed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"randomisation_use_specified_seedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"randomisation_use_specified_seed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"require_nextValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"require_next"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"response_windowValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"response_window"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"response_window_is_infiniteValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"response_window_is_infinite"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"show_exit_buttonValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"show_exit_button"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"time_between_question_meanValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"time_between_question_mean"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"time_between_question_plusminusValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"time_between_question_plusminus"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"use_staircase_methodValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"use_staircase_method"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic animation_frame_rate;

- (int16_t)animation_frame_rateValue {
	NSNumber *result = [self animation_frame_rate];
	return [result shortValue];
}

- (void)setAnimation_frame_rateValue:(int16_t)value_ {
	[self setAnimation_frame_rate:@(value_)];
}

- (int16_t)primitiveAnimation_frame_rateValue {
	NSNumber *result = [self primitiveAnimation_frame_rate];
	return [result shortValue];
}

- (void)setPrimitiveAnimation_frame_rateValue:(int16_t)value_ {
	[self setPrimitiveAnimation_frame_rate:@(value_)];
}

@dynamic attempt_facial_recognition;

- (BOOL)attempt_facial_recognitionValue {
	NSNumber *result = [self attempt_facial_recognition];
	return [result boolValue];
}

- (void)setAttempt_facial_recognitionValue:(BOOL)value_ {
	[self setAttempt_facial_recognition:@(value_)];
}

- (BOOL)primitiveAttempt_facial_recognitionValue {
	NSNumber *result = [self primitiveAttempt_facial_recognition];
	return [result boolValue];
}

- (void)setPrimitiveAttempt_facial_recognitionValue:(BOOL)value_ {
	[self setPrimitiveAttempt_facial_recognition:@(value_)];
}

@dynamic background_colour;

@dynamic button1_bg;

@dynamic button1_fg;

@dynamic button1_h;

- (int16_t)button1_hValue {
	NSNumber *result = [self button1_h];
	return [result shortValue];
}

- (void)setButton1_hValue:(int16_t)value_ {
	[self setButton1_h:@(value_)];
}

- (int16_t)primitiveButton1_hValue {
	NSNumber *result = [self primitiveButton1_h];
	return [result shortValue];
}

- (void)setPrimitiveButton1_hValue:(int16_t)value_ {
	[self setPrimitiveButton1_h:@(value_)];
}

@dynamic button1_w;

- (int16_t)button1_wValue {
	NSNumber *result = [self button1_w];
	return [result shortValue];
}

- (void)setButton1_wValue:(int16_t)value_ {
	[self setButton1_w:@(value_)];
}

- (int16_t)primitiveButton1_wValue {
	NSNumber *result = [self primitiveButton1_w];
	return [result shortValue];
}

- (void)setPrimitiveButton1_wValue:(int16_t)value_ {
	[self setPrimitiveButton1_w:@(value_)];
}

@dynamic button1_x;

- (int16_t)button1_xValue {
	NSNumber *result = [self button1_x];
	return [result shortValue];
}

- (void)setButton1_xValue:(int16_t)value_ {
	[self setButton1_x:@(value_)];
}

- (int16_t)primitiveButton1_xValue {
	NSNumber *result = [self primitiveButton1_x];
	return [result shortValue];
}

- (void)setPrimitiveButton1_xValue:(int16_t)value_ {
	[self setPrimitiveButton1_x:@(value_)];
}

@dynamic button1_y;

- (int16_t)button1_yValue {
	NSNumber *result = [self button1_y];
	return [result shortValue];
}

- (void)setButton1_yValue:(int16_t)value_ {
	[self setButton1_y:@(value_)];
}

- (int16_t)primitiveButton1_yValue {
	NSNumber *result = [self primitiveButton1_y];
	return [result shortValue];
}

- (void)setPrimitiveButton1_yValue:(int16_t)value_ {
	[self setPrimitiveButton1_y:@(value_)];
}

@dynamic button2_bg;

@dynamic button2_fg;

@dynamic button2_h;

- (int16_t)button2_hValue {
	NSNumber *result = [self button2_h];
	return [result shortValue];
}

- (void)setButton2_hValue:(int16_t)value_ {
	[self setButton2_h:@(value_)];
}

- (int16_t)primitiveButton2_hValue {
	NSNumber *result = [self primitiveButton2_h];
	return [result shortValue];
}

- (void)setPrimitiveButton2_hValue:(int16_t)value_ {
	[self setPrimitiveButton2_h:@(value_)];
}

@dynamic button2_w;

- (int16_t)button2_wValue {
	NSNumber *result = [self button2_w];
	return [result shortValue];
}

- (void)setButton2_wValue:(int16_t)value_ {
	[self setButton2_w:@(value_)];
}

- (int16_t)primitiveButton2_wValue {
	NSNumber *result = [self primitiveButton2_w];
	return [result shortValue];
}

- (void)setPrimitiveButton2_wValue:(int16_t)value_ {
	[self setPrimitiveButton2_w:@(value_)];
}

@dynamic button2_x;

- (int16_t)button2_xValue {
	NSNumber *result = [self button2_x];
	return [result shortValue];
}

- (void)setButton2_xValue:(int16_t)value_ {
	[self setButton2_x:@(value_)];
}

- (int16_t)primitiveButton2_xValue {
	NSNumber *result = [self primitiveButton2_x];
	return [result shortValue];
}

- (void)setPrimitiveButton2_xValue:(int16_t)value_ {
	[self setPrimitiveButton2_x:@(value_)];
}

@dynamic button2_y;

- (int16_t)button2_yValue {
	NSNumber *result = [self button2_y];
	return [result shortValue];
}

- (void)setButton2_yValue:(int16_t)value_ {
	[self setButton2_y:@(value_)];
}

- (int16_t)primitiveButton2_yValue {
	NSNumber *result = [self primitiveButton2_y];
	return [result shortValue];
}

- (void)setPrimitiveButton2_yValue:(int16_t)value_ {
	[self setPrimitiveButton2_y:@(value_)];
}

@dynamic button3_bg;

@dynamic button3_fg;

@dynamic button3_h;

- (int16_t)button3_hValue {
	NSNumber *result = [self button3_h];
	return [result shortValue];
}

- (void)setButton3_hValue:(int16_t)value_ {
	[self setButton3_h:@(value_)];
}

- (int16_t)primitiveButton3_hValue {
	NSNumber *result = [self primitiveButton3_h];
	return [result shortValue];
}

- (void)setPrimitiveButton3_hValue:(int16_t)value_ {
	[self setPrimitiveButton3_h:@(value_)];
}

@dynamic button3_w;

- (int16_t)button3_wValue {
	NSNumber *result = [self button3_w];
	return [result shortValue];
}

- (void)setButton3_wValue:(int16_t)value_ {
	[self setButton3_w:@(value_)];
}

- (int16_t)primitiveButton3_wValue {
	NSNumber *result = [self primitiveButton3_w];
	return [result shortValue];
}

- (void)setPrimitiveButton3_wValue:(int16_t)value_ {
	[self setPrimitiveButton3_w:@(value_)];
}

@dynamic button3_x;

- (int16_t)button3_xValue {
	NSNumber *result = [self button3_x];
	return [result shortValue];
}

- (void)setButton3_xValue:(int16_t)value_ {
	[self setButton3_x:@(value_)];
}

- (int16_t)primitiveButton3_xValue {
	NSNumber *result = [self primitiveButton3_x];
	return [result shortValue];
}

- (void)setPrimitiveButton3_xValue:(int16_t)value_ {
	[self setPrimitiveButton3_x:@(value_)];
}

@dynamic button3_y;

- (int16_t)button3_yValue {
	NSNumber *result = [self button3_y];
	return [result shortValue];
}

- (void)setButton3_yValue:(int16_t)value_ {
	[self setButton3_y:@(value_)];
}

- (int16_t)primitiveButton3_yValue {
	NSNumber *result = [self primitiveButton3_y];
	return [result shortValue];
}

- (void)setPrimitiveButton3_yValue:(int16_t)value_ {
	[self setPrimitiveButton3_y:@(value_)];
}

@dynamic button4_bg;

@dynamic button4_fg;

@dynamic button4_h;

- (int16_t)button4_hValue {
	NSNumber *result = [self button4_h];
	return [result shortValue];
}

- (void)setButton4_hValue:(int16_t)value_ {
	[self setButton4_h:@(value_)];
}

- (int16_t)primitiveButton4_hValue {
	NSNumber *result = [self primitiveButton4_h];
	return [result shortValue];
}

- (void)setPrimitiveButton4_hValue:(int16_t)value_ {
	[self setPrimitiveButton4_h:@(value_)];
}

@dynamic button4_w;

- (int16_t)button4_wValue {
	NSNumber *result = [self button4_w];
	return [result shortValue];
}

- (void)setButton4_wValue:(int16_t)value_ {
	[self setButton4_w:@(value_)];
}

- (int16_t)primitiveButton4_wValue {
	NSNumber *result = [self primitiveButton4_w];
	return [result shortValue];
}

- (void)setPrimitiveButton4_wValue:(int16_t)value_ {
	[self setPrimitiveButton4_w:@(value_)];
}

@dynamic button4_x;

- (int16_t)button4_xValue {
	NSNumber *result = [self button4_x];
	return [result shortValue];
}

- (void)setButton4_xValue:(int16_t)value_ {
	[self setButton4_x:@(value_)];
}

- (int16_t)primitiveButton4_xValue {
	NSNumber *result = [self primitiveButton4_x];
	return [result shortValue];
}

- (void)setPrimitiveButton4_xValue:(int16_t)value_ {
	[self setPrimitiveButton4_x:@(value_)];
}

@dynamic button4_y;

- (int16_t)button4_yValue {
	NSNumber *result = [self button4_y];
	return [result shortValue];
}

- (void)setButton4_yValue:(int16_t)value_ {
	[self setButton4_y:@(value_)];
}

- (int16_t)primitiveButton4_yValue {
	NSNumber *result = [self primitiveButton4_y];
	return [result shortValue];
}

- (void)setPrimitiveButton4_yValue:(int16_t)value_ {
	[self setPrimitiveButton4_y:@(value_)];
}

@dynamic button_presentation_delay;

- (float)button_presentation_delayValue {
	NSNumber *result = [self button_presentation_delay];
	return [result floatValue];
}

- (void)setButton_presentation_delayValue:(float)value_ {
	[self setButton_presentation_delay:@(value_)];
}

- (float)primitiveButton_presentation_delayValue {
	NSNumber *result = [self primitiveButton_presentation_delay];
	return [result floatValue];
}

- (void)setPrimitiveButton_presentation_delayValue:(float)value_ {
	[self setPrimitiveButton_presentation_delay:@(value_)];
}

@dynamic button_text_four;

@dynamic button_text_one;

@dynamic button_text_three;

@dynamic button_text_two;

@dynamic day_of_week_fri;

- (BOOL)day_of_week_friValue {
	NSNumber *result = [self day_of_week_fri];
	return [result boolValue];
}

- (void)setDay_of_week_friValue:(BOOL)value_ {
	[self setDay_of_week_fri:@(value_)];
}

- (BOOL)primitiveDay_of_week_friValue {
	NSNumber *result = [self primitiveDay_of_week_fri];
	return [result boolValue];
}

- (void)setPrimitiveDay_of_week_friValue:(BOOL)value_ {
	[self setPrimitiveDay_of_week_fri:@(value_)];
}

@dynamic day_of_week_mon;

- (BOOL)day_of_week_monValue {
	NSNumber *result = [self day_of_week_mon];
	return [result boolValue];
}

- (void)setDay_of_week_monValue:(BOOL)value_ {
	[self setDay_of_week_mon:@(value_)];
}

- (BOOL)primitiveDay_of_week_monValue {
	NSNumber *result = [self primitiveDay_of_week_mon];
	return [result boolValue];
}

- (void)setPrimitiveDay_of_week_monValue:(BOOL)value_ {
	[self setPrimitiveDay_of_week_mon:@(value_)];
}

@dynamic day_of_week_sat;

- (BOOL)day_of_week_satValue {
	NSNumber *result = [self day_of_week_sat];
	return [result boolValue];
}

- (void)setDay_of_week_satValue:(BOOL)value_ {
	[self setDay_of_week_sat:@(value_)];
}

- (BOOL)primitiveDay_of_week_satValue {
	NSNumber *result = [self primitiveDay_of_week_sat];
	return [result boolValue];
}

- (void)setPrimitiveDay_of_week_satValue:(BOOL)value_ {
	[self setPrimitiveDay_of_week_sat:@(value_)];
}

@dynamic day_of_week_sun;

- (BOOL)day_of_week_sunValue {
	NSNumber *result = [self day_of_week_sun];
	return [result boolValue];
}

- (void)setDay_of_week_sunValue:(BOOL)value_ {
	[self setDay_of_week_sun:@(value_)];
}

- (BOOL)primitiveDay_of_week_sunValue {
	NSNumber *result = [self primitiveDay_of_week_sun];
	return [result boolValue];
}

- (void)setPrimitiveDay_of_week_sunValue:(BOOL)value_ {
	[self setPrimitiveDay_of_week_sun:@(value_)];
}

@dynamic day_of_week_thu;

- (BOOL)day_of_week_thuValue {
	NSNumber *result = [self day_of_week_thu];
	return [result boolValue];
}

- (void)setDay_of_week_thuValue:(BOOL)value_ {
	[self setDay_of_week_thu:@(value_)];
}

- (BOOL)primitiveDay_of_week_thuValue {
	NSNumber *result = [self primitiveDay_of_week_thu];
	return [result boolValue];
}

- (void)setPrimitiveDay_of_week_thuValue:(BOOL)value_ {
	[self setPrimitiveDay_of_week_thu:@(value_)];
}

@dynamic day_of_week_tue;

- (BOOL)day_of_week_tueValue {
	NSNumber *result = [self day_of_week_tue];
	return [result boolValue];
}

- (void)setDay_of_week_tueValue:(BOOL)value_ {
	[self setDay_of_week_tue:@(value_)];
}

- (BOOL)primitiveDay_of_week_tueValue {
	NSNumber *result = [self primitiveDay_of_week_tue];
	return [result boolValue];
}

- (void)setPrimitiveDay_of_week_tueValue:(BOOL)value_ {
	[self setPrimitiveDay_of_week_tue:@(value_)];
}

@dynamic day_of_week_wed;

- (BOOL)day_of_week_wedValue {
	NSNumber *result = [self day_of_week_wed];
	return [result boolValue];
}

- (void)setDay_of_week_wedValue:(BOOL)value_ {
	[self setDay_of_week_wed:@(value_)];
}

- (BOOL)primitiveDay_of_week_wedValue {
	NSNumber *result = [self primitiveDay_of_week_wed];
	return [result boolValue];
}

- (void)setPrimitiveDay_of_week_wedValue:(BOOL)value_ {
	[self setPrimitiveDay_of_week_wed:@(value_)];
}

@dynamic enabled;

- (BOOL)enabledValue {
	NSNumber *result = [self enabled];
	return [result boolValue];
}

- (void)setEnabledValue:(BOOL)value_ {
	[self setEnabled:@(value_)];
}

- (BOOL)primitiveEnabledValue {
	NSNumber *result = [self primitiveEnabled];
	return [result boolValue];
}

- (void)setPrimitiveEnabledValue:(BOOL)value_ {
	[self setPrimitiveEnabled:@(value_)];
}

@dynamic exit_button_bg;

@dynamic exit_button_fg;

@dynamic exit_button_h;

- (int16_t)exit_button_hValue {
	NSNumber *result = [self exit_button_h];
	return [result shortValue];
}

- (void)setExit_button_hValue:(int16_t)value_ {
	[self setExit_button_h:@(value_)];
}

- (int16_t)primitiveExit_button_hValue {
	NSNumber *result = [self primitiveExit_button_h];
	return [result shortValue];
}

- (void)setPrimitiveExit_button_hValue:(int16_t)value_ {
	[self setPrimitiveExit_button_h:@(value_)];
}

@dynamic exit_button_w;

- (int16_t)exit_button_wValue {
	NSNumber *result = [self exit_button_w];
	return [result shortValue];
}

- (void)setExit_button_wValue:(int16_t)value_ {
	[self setExit_button_w:@(value_)];
}

- (int16_t)primitiveExit_button_wValue {
	NSNumber *result = [self primitiveExit_button_w];
	return [result shortValue];
}

- (void)setPrimitiveExit_button_wValue:(int16_t)value_ {
	[self setPrimitiveExit_button_w:@(value_)];
}

@dynamic exit_button_x;

- (int16_t)exit_button_xValue {
	NSNumber *result = [self exit_button_x];
	return [result shortValue];
}

- (void)setExit_button_xValue:(int16_t)value_ {
	[self setExit_button_x:@(value_)];
}

- (int16_t)primitiveExit_button_xValue {
	NSNumber *result = [self primitiveExit_button_x];
	return [result shortValue];
}

- (void)setPrimitiveExit_button_xValue:(int16_t)value_ {
	[self setPrimitiveExit_button_x:@(value_)];
}

@dynamic exit_button_y;

- (int16_t)exit_button_yValue {
	NSNumber *result = [self exit_button_y];
	return [result shortValue];
}

- (void)setExit_button_yValue:(int16_t)value_ {
	[self setExit_button_y:@(value_)];
}

- (int16_t)primitiveExit_button_yValue {
	NSNumber *result = [self primitiveExit_button_y];
	return [result shortValue];
}

- (void)setPrimitiveExit_button_yValue:(int16_t)value_ {
	[self setPrimitiveExit_button_y:@(value_)];
}

@dynamic images_together_presentation_time;

- (float)images_together_presentation_timeValue {
	NSNumber *result = [self images_together_presentation_time];
	return [result floatValue];
}

- (void)setImages_together_presentation_timeValue:(float)value_ {
	[self setImages_together_presentation_time:@(value_)];
}

- (float)primitiveImages_together_presentation_timeValue {
	NSNumber *result = [self primitiveImages_together_presentation_time];
	return [result floatValue];
}

- (void)setPrimitiveImages_together_presentation_timeValue:(float)value_ {
	[self setPrimitiveImages_together_presentation_time:@(value_)];
}

@dynamic images_together_presentation_time_is_infinite;

- (BOOL)images_together_presentation_time_is_infiniteValue {
	NSNumber *result = [self images_together_presentation_time_is_infinite];
	return [result boolValue];
}

- (void)setImages_together_presentation_time_is_infiniteValue:(BOOL)value_ {
	[self setImages_together_presentation_time_is_infinite:@(value_)];
}

- (BOOL)primitiveImages_together_presentation_time_is_infiniteValue {
	NSNumber *result = [self primitiveImages_together_presentation_time_is_infinite];
	return [result boolValue];
}

- (void)setPrimitiveImages_together_presentation_time_is_infiniteValue:(BOOL)value_ {
	[self setPrimitiveImages_together_presentation_time_is_infinite:@(value_)];
}

@dynamic loop_animated_images;

- (BOOL)loop_animated_imagesValue {
	NSNumber *result = [self loop_animated_images];
	return [result boolValue];
}

- (void)setLoop_animated_imagesValue:(BOOL)value_ {
	[self setLoop_animated_images:@(value_)];
}

- (BOOL)primitiveLoop_animated_imagesValue {
	NSNumber *result = [self primitiveLoop_animated_images];
	return [result boolValue];
}

- (void)setPrimitiveLoop_animated_imagesValue:(BOOL)value_ {
	[self setPrimitiveLoop_animated_images:@(value_)];
}

@dynamic name;

@dynamic num_staircases_interleaved;

- (int16_t)num_staircases_interleavedValue {
	NSNumber *result = [self num_staircases_interleaved];
	return [result shortValue];
}

- (void)setNum_staircases_interleavedValue:(int16_t)value_ {
	[self setNum_staircases_interleaved:@(value_)];
}

- (int16_t)primitiveNum_staircases_interleavedValue {
	NSNumber *result = [self primitiveNum_staircases_interleaved];
	return [result shortValue];
}

- (void)setPrimitiveNum_staircases_interleavedValue:(int16_t)value_ {
	[self setPrimitiveNum_staircases_interleaved:@(value_)];
}

@dynamic number_of_buttons;

- (int16_t)number_of_buttonsValue {
	NSNumber *result = [self number_of_buttons];
	return [result shortValue];
}

- (void)setNumber_of_buttonsValue:(int16_t)value_ {
	[self setNumber_of_buttons:@(value_)];
}

- (int16_t)primitiveNumber_of_buttonsValue {
	NSNumber *result = [self primitiveNumber_of_buttons];
	return [result shortValue];
}

- (void)setPrimitiveNumber_of_buttonsValue:(int16_t)value_ {
	[self setPrimitiveNumber_of_buttons:@(value_)];
}

@dynamic practice_configuration;

- (BOOL)practice_configurationValue {
	NSNumber *result = [self practice_configuration];
	return [result boolValue];
}

- (void)setPractice_configurationValue:(BOOL)value_ {
	[self setPractice_configuration:@(value_)];
}

- (BOOL)primitivePractice_configurationValue {
	NSNumber *result = [self primitivePractice_configuration];
	return [result boolValue];
}

- (void)setPrimitivePractice_configurationValue:(BOOL)value_ {
	[self setPrimitivePractice_configuration:@(value_)];
}

@dynamic questions_per_folder;

@dynamic randomisation_specified_seed;

- (int32_t)randomisation_specified_seedValue {
	NSNumber *result = [self randomisation_specified_seed];
	return [result intValue];
}

- (void)setRandomisation_specified_seedValue:(int32_t)value_ {
	[self setRandomisation_specified_seed:@(value_)];
}

- (int32_t)primitiveRandomisation_specified_seedValue {
	NSNumber *result = [self primitiveRandomisation_specified_seed];
	return [result intValue];
}

- (void)setPrimitiveRandomisation_specified_seedValue:(int32_t)value_ {
	[self setPrimitiveRandomisation_specified_seed:@(value_)];
}

@dynamic randomisation_use_specified_seed;

- (BOOL)randomisation_use_specified_seedValue {
	NSNumber *result = [self randomisation_use_specified_seed];
	return [result boolValue];
}

- (void)setRandomisation_use_specified_seedValue:(BOOL)value_ {
	[self setRandomisation_use_specified_seed:@(value_)];
}

- (BOOL)primitiveRandomisation_use_specified_seedValue {
	NSNumber *result = [self primitiveRandomisation_use_specified_seed];
	return [result boolValue];
}

- (void)setPrimitiveRandomisation_use_specified_seedValue:(BOOL)value_ {
	[self setPrimitiveRandomisation_use_specified_seed:@(value_)];
}

@dynamic require_next;

- (BOOL)require_nextValue {
	NSNumber *result = [self require_next];
	return [result boolValue];
}

- (void)setRequire_nextValue:(BOOL)value_ {
	[self setRequire_next:@(value_)];
}

- (BOOL)primitiveRequire_nextValue {
	NSNumber *result = [self primitiveRequire_next];
	return [result boolValue];
}

- (void)setPrimitiveRequire_nextValue:(BOOL)value_ {
	[self setPrimitiveRequire_next:@(value_)];
}

@dynamic response_window;

- (float)response_windowValue {
	NSNumber *result = [self response_window];
	return [result floatValue];
}

- (void)setResponse_windowValue:(float)value_ {
	[self setResponse_window:@(value_)];
}

- (float)primitiveResponse_windowValue {
	NSNumber *result = [self primitiveResponse_window];
	return [result floatValue];
}

- (void)setPrimitiveResponse_windowValue:(float)value_ {
	[self setPrimitiveResponse_window:@(value_)];
}

@dynamic response_window_is_infinite;

- (BOOL)response_window_is_infiniteValue {
	NSNumber *result = [self response_window_is_infinite];
	return [result boolValue];
}

- (void)setResponse_window_is_infiniteValue:(BOOL)value_ {
	[self setResponse_window_is_infinite:@(value_)];
}

- (BOOL)primitiveResponse_window_is_infiniteValue {
	NSNumber *result = [self primitiveResponse_window_is_infinite];
	return [result boolValue];
}

- (void)setPrimitiveResponse_window_is_infiniteValue:(BOOL)value_ {
	[self setPrimitiveResponse_window_is_infinite:@(value_)];
}

@dynamic show_exit_button;

- (BOOL)show_exit_buttonValue {
	NSNumber *result = [self show_exit_button];
	return [result boolValue];
}

- (void)setShow_exit_buttonValue:(BOOL)value_ {
	[self setShow_exit_button:@(value_)];
}

- (BOOL)primitiveShow_exit_buttonValue {
	NSNumber *result = [self primitiveShow_exit_button];
	return [result boolValue];
}

- (void)setPrimitiveShow_exit_buttonValue:(BOOL)value_ {
	[self setPrimitiveShow_exit_button:@(value_)];
}

@dynamic staircase_deltas;

@dynamic staircase_floor_ceiling_hits;

@dynamic staircase_max_level;

@dynamic staircase_min_level;

@dynamic staircase_num_correct_to_get_harder;

@dynamic staircase_num_incorrect_to_get_easier;

@dynamic staircase_num_reversals;

@dynamic staircase_start_level;

@dynamic time_between_question_mean;

- (float)time_between_question_meanValue {
	NSNumber *result = [self time_between_question_mean];
	return [result floatValue];
}

- (void)setTime_between_question_meanValue:(float)value_ {
	[self setTime_between_question_mean:@(value_)];
}

- (float)primitiveTime_between_question_meanValue {
	NSNumber *result = [self primitiveTime_between_question_mean];
	return [result floatValue];
}

- (void)setPrimitiveTime_between_question_meanValue:(float)value_ {
	[self setPrimitiveTime_between_question_mean:@(value_)];
}

@dynamic time_between_question_plusminus;

- (float)time_between_question_plusminusValue {
	NSNumber *result = [self time_between_question_plusminus];
	return [result floatValue];
}

- (void)setTime_between_question_plusminusValue:(float)value_ {
	[self setTime_between_question_plusminus:@(value_)];
}

- (float)primitiveTime_between_question_plusminusValue {
	NSNumber *result = [self primitiveTime_between_question_plusminus];
	return [result floatValue];
}

- (void)setPrimitiveTime_between_question_plusminusValue:(float)value_ {
	[self setPrimitiveTime_between_question_plusminus:@(value_)];
}

@dynamic use_staircase_method;

- (BOOL)use_staircase_methodValue {
	NSNumber *result = [self use_staircase_method];
	return [result boolValue];
}

- (void)setUse_staircase_methodValue:(BOOL)value_ {
	[self setUse_staircase_method:@(value_)];
}

- (BOOL)primitiveUse_staircase_methodValue {
	NSNumber *result = [self primitiveUse_staircase_method];
	return [result boolValue];
}

- (void)setPrimitiveUse_staircase_methodValue:(BOOL)value_ {
	[self setPrimitiveUse_staircase_method:@(value_)];
}

@dynamic sequence;

@dynamic user;

@end

