// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestConfiguration.h instead.

@import CoreData;

extern const struct TestConfigurationAttributes {
	__unsafe_unretained NSString *animation_frame_rate;
	__unsafe_unretained NSString *attempt_facial_recognition;
	__unsafe_unretained NSString *background_colour;
	__unsafe_unretained NSString *button1_bg;
	__unsafe_unretained NSString *button1_fg;
	__unsafe_unretained NSString *button1_h;
	__unsafe_unretained NSString *button1_text;
	__unsafe_unretained NSString *button1_w;
	__unsafe_unretained NSString *button1_x;
	__unsafe_unretained NSString *button1_y;
	__unsafe_unretained NSString *button2_bg;
	__unsafe_unretained NSString *button2_fg;
	__unsafe_unretained NSString *button2_h;
	__unsafe_unretained NSString *button2_text;
	__unsafe_unretained NSString *button2_w;
	__unsafe_unretained NSString *button2_x;
	__unsafe_unretained NSString *button2_y;
	__unsafe_unretained NSString *button3_bg;
	__unsafe_unretained NSString *button3_fg;
	__unsafe_unretained NSString *button3_h;
	__unsafe_unretained NSString *button3_text;
	__unsafe_unretained NSString *button3_w;
	__unsafe_unretained NSString *button3_x;
	__unsafe_unretained NSString *button3_y;
	__unsafe_unretained NSString *button4_bg;
	__unsafe_unretained NSString *button4_fg;
	__unsafe_unretained NSString *button4_h;
	__unsafe_unretained NSString *button4_text;
	__unsafe_unretained NSString *button4_w;
	__unsafe_unretained NSString *button4_x;
	__unsafe_unretained NSString *button4_y;
	__unsafe_unretained NSString *button_presentation_delay;
	__unsafe_unretained NSString *configuration_description;
	__unsafe_unretained NSString *day_of_week_fri;
	__unsafe_unretained NSString *day_of_week_mon;
	__unsafe_unretained NSString *day_of_week_sat;
	__unsafe_unretained NSString *day_of_week_sun;
	__unsafe_unretained NSString *day_of_week_thu;
	__unsafe_unretained NSString *day_of_week_tue;
	__unsafe_unretained NSString *day_of_week_wed;
	__unsafe_unretained NSString *delta_values;
	__unsafe_unretained NSString *enabled;
	__unsafe_unretained NSString *exit_button_bg;
	__unsafe_unretained NSString *exit_button_fg;
	__unsafe_unretained NSString *exit_button_h;
	__unsafe_unretained NSString *exit_button_w;
	__unsafe_unretained NSString *exit_button_x;
	__unsafe_unretained NSString *exit_button_y;
	__unsafe_unretained NSString *finite_presentation_time;
	__unsafe_unretained NSString *finite_response_window;
	__unsafe_unretained NSString *hits_to_finish;
	__unsafe_unretained NSString *infinite_presentation_time;
	__unsafe_unretained NSString *infinite_response_window;
	__unsafe_unretained NSString *is_gallery_configuration;
	__unsafe_unretained NSString *is_practice;
	__unsafe_unretained NSString *loop_animations;
	__unsafe_unretained NSString *maximum_level;
	__unsafe_unretained NSString *minimum_level;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *num_buttons;
	__unsafe_unretained NSString *num_correct_to_get_harder;
	__unsafe_unretained NSString *num_wrong_to_get_easier;
	__unsafe_unretained NSString *number_of_reversals;
	__unsafe_unretained NSString *number_of_staircases;
	__unsafe_unretained NSString *questions_per_folder;
	__unsafe_unretained NSString *require_next;
	__unsafe_unretained NSString *server_id;
	__unsafe_unretained NSString *server_url;
	__unsafe_unretained NSString *show_exit_button;
	__unsafe_unretained NSString *specified_seed;
	__unsafe_unretained NSString *start_level;
	__unsafe_unretained NSString *time_between_question_mean;
	__unsafe_unretained NSString *time_between_question_plusminus;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *use_specified_seed;
	__unsafe_unretained NSString *use_staircase_method;
} TestConfigurationAttributes;

extern const struct TestConfigurationRelationships {
	__unsafe_unretained NSString *sequence;
	__unsafe_unretained NSString *user;
} TestConfigurationRelationships;

@class TestSequence;
@class User;

@interface TestConfigurationID : NSManagedObjectID {}
@end

@interface _TestConfiguration : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TestConfigurationID* objectID;

@property (nonatomic, strong) NSNumber* animation_frame_rate;

@property (atomic) int16_t animation_frame_rateValue;
- (int16_t)animation_frame_rateValue;
- (void)setAnimation_frame_rateValue:(int16_t)value_;

//- (BOOL)validateAnimation_frame_rate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* attempt_facial_recognition;

@property (atomic) BOOL attempt_facial_recognitionValue;
- (BOOL)attempt_facial_recognitionValue;
- (void)setAttempt_facial_recognitionValue:(BOOL)value_;

//- (BOOL)validateAttempt_facial_recognition:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* background_colour;

//- (BOOL)validateBackground_colour:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* button1_bg;

//- (BOOL)validateButton1_bg:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* button1_fg;

//- (BOOL)validateButton1_fg:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* button1_h;

@property (atomic) int16_t button1_hValue;
- (int16_t)button1_hValue;
- (void)setButton1_hValue:(int16_t)value_;

//- (BOOL)validateButton1_h:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* button1_text;

//- (BOOL)validateButton1_text:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* button1_w;

@property (atomic) int16_t button1_wValue;
- (int16_t)button1_wValue;
- (void)setButton1_wValue:(int16_t)value_;

//- (BOOL)validateButton1_w:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* button1_x;

@property (atomic) int16_t button1_xValue;
- (int16_t)button1_xValue;
- (void)setButton1_xValue:(int16_t)value_;

//- (BOOL)validateButton1_x:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* button1_y;

@property (atomic) int16_t button1_yValue;
- (int16_t)button1_yValue;
- (void)setButton1_yValue:(int16_t)value_;

//- (BOOL)validateButton1_y:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* button2_bg;

//- (BOOL)validateButton2_bg:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* button2_fg;

//- (BOOL)validateButton2_fg:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* button2_h;

@property (atomic) int16_t button2_hValue;
- (int16_t)button2_hValue;
- (void)setButton2_hValue:(int16_t)value_;

//- (BOOL)validateButton2_h:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* button2_text;

//- (BOOL)validateButton2_text:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* button2_w;

@property (atomic) int16_t button2_wValue;
- (int16_t)button2_wValue;
- (void)setButton2_wValue:(int16_t)value_;

//- (BOOL)validateButton2_w:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* button2_x;

@property (atomic) int16_t button2_xValue;
- (int16_t)button2_xValue;
- (void)setButton2_xValue:(int16_t)value_;

//- (BOOL)validateButton2_x:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* button2_y;

@property (atomic) int16_t button2_yValue;
- (int16_t)button2_yValue;
- (void)setButton2_yValue:(int16_t)value_;

//- (BOOL)validateButton2_y:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* button3_bg;

//- (BOOL)validateButton3_bg:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* button3_fg;

//- (BOOL)validateButton3_fg:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* button3_h;

@property (atomic) int16_t button3_hValue;
- (int16_t)button3_hValue;
- (void)setButton3_hValue:(int16_t)value_;

//- (BOOL)validateButton3_h:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* button3_text;

//- (BOOL)validateButton3_text:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* button3_w;

@property (atomic) int16_t button3_wValue;
- (int16_t)button3_wValue;
- (void)setButton3_wValue:(int16_t)value_;

//- (BOOL)validateButton3_w:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* button3_x;

@property (atomic) int16_t button3_xValue;
- (int16_t)button3_xValue;
- (void)setButton3_xValue:(int16_t)value_;

//- (BOOL)validateButton3_x:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* button3_y;

@property (atomic) int16_t button3_yValue;
- (int16_t)button3_yValue;
- (void)setButton3_yValue:(int16_t)value_;

//- (BOOL)validateButton3_y:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* button4_bg;

//- (BOOL)validateButton4_bg:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* button4_fg;

//- (BOOL)validateButton4_fg:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* button4_h;

@property (atomic) int16_t button4_hValue;
- (int16_t)button4_hValue;
- (void)setButton4_hValue:(int16_t)value_;

//- (BOOL)validateButton4_h:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* button4_text;

//- (BOOL)validateButton4_text:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* button4_w;

@property (atomic) int16_t button4_wValue;
- (int16_t)button4_wValue;
- (void)setButton4_wValue:(int16_t)value_;

//- (BOOL)validateButton4_w:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* button4_x;

@property (atomic) int16_t button4_xValue;
- (int16_t)button4_xValue;
- (void)setButton4_xValue:(int16_t)value_;

//- (BOOL)validateButton4_x:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* button4_y;

@property (atomic) int16_t button4_yValue;
- (int16_t)button4_yValue;
- (void)setButton4_yValue:(int16_t)value_;

//- (BOOL)validateButton4_y:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* button_presentation_delay;

@property (atomic) float button_presentation_delayValue;
- (float)button_presentation_delayValue;
- (void)setButton_presentation_delayValue:(float)value_;

//- (BOOL)validateButton_presentation_delay:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* configuration_description;

//- (BOOL)validateConfiguration_description:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* day_of_week_fri;

@property (atomic) BOOL day_of_week_friValue;
- (BOOL)day_of_week_friValue;
- (void)setDay_of_week_friValue:(BOOL)value_;

//- (BOOL)validateDay_of_week_fri:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* day_of_week_mon;

@property (atomic) BOOL day_of_week_monValue;
- (BOOL)day_of_week_monValue;
- (void)setDay_of_week_monValue:(BOOL)value_;

//- (BOOL)validateDay_of_week_mon:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* day_of_week_sat;

@property (atomic) BOOL day_of_week_satValue;
- (BOOL)day_of_week_satValue;
- (void)setDay_of_week_satValue:(BOOL)value_;

//- (BOOL)validateDay_of_week_sat:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* day_of_week_sun;

@property (atomic) BOOL day_of_week_sunValue;
- (BOOL)day_of_week_sunValue;
- (void)setDay_of_week_sunValue:(BOOL)value_;

//- (BOOL)validateDay_of_week_sun:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* day_of_week_thu;

@property (atomic) BOOL day_of_week_thuValue;
- (BOOL)day_of_week_thuValue;
- (void)setDay_of_week_thuValue:(BOOL)value_;

//- (BOOL)validateDay_of_week_thu:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* day_of_week_tue;

@property (atomic) BOOL day_of_week_tueValue;
- (BOOL)day_of_week_tueValue;
- (void)setDay_of_week_tueValue:(BOOL)value_;

//- (BOOL)validateDay_of_week_tue:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* day_of_week_wed;

@property (atomic) BOOL day_of_week_wedValue;
- (BOOL)day_of_week_wedValue;
- (void)setDay_of_week_wedValue:(BOOL)value_;

//- (BOOL)validateDay_of_week_wed:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* delta_values;

//- (BOOL)validateDelta_values:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* enabled;

@property (atomic) BOOL enabledValue;
- (BOOL)enabledValue;
- (void)setEnabledValue:(BOOL)value_;

//- (BOOL)validateEnabled:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* exit_button_bg;

//- (BOOL)validateExit_button_bg:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* exit_button_fg;

//- (BOOL)validateExit_button_fg:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* exit_button_h;

@property (atomic) int16_t exit_button_hValue;
- (int16_t)exit_button_hValue;
- (void)setExit_button_hValue:(int16_t)value_;

//- (BOOL)validateExit_button_h:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* exit_button_w;

@property (atomic) int16_t exit_button_wValue;
- (int16_t)exit_button_wValue;
- (void)setExit_button_wValue:(int16_t)value_;

//- (BOOL)validateExit_button_w:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* exit_button_x;

@property (atomic) int16_t exit_button_xValue;
- (int16_t)exit_button_xValue;
- (void)setExit_button_xValue:(int16_t)value_;

//- (BOOL)validateExit_button_x:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* exit_button_y;

@property (atomic) int16_t exit_button_yValue;
- (int16_t)exit_button_yValue;
- (void)setExit_button_yValue:(int16_t)value_;

//- (BOOL)validateExit_button_y:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* finite_presentation_time;

@property (atomic) float finite_presentation_timeValue;
- (float)finite_presentation_timeValue;
- (void)setFinite_presentation_timeValue:(float)value_;

//- (BOOL)validateFinite_presentation_time:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* finite_response_window;

@property (atomic) float finite_response_windowValue;
- (float)finite_response_windowValue;
- (void)setFinite_response_windowValue:(float)value_;

//- (BOOL)validateFinite_response_window:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* hits_to_finish;

//- (BOOL)validateHits_to_finish:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* infinite_presentation_time;

@property (atomic) BOOL infinite_presentation_timeValue;
- (BOOL)infinite_presentation_timeValue;
- (void)setInfinite_presentation_timeValue:(BOOL)value_;

//- (BOOL)validateInfinite_presentation_time:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* infinite_response_window;

@property (atomic) BOOL infinite_response_windowValue;
- (BOOL)infinite_response_windowValue;
- (void)setInfinite_response_windowValue:(BOOL)value_;

//- (BOOL)validateInfinite_response_window:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* is_gallery_configuration;

@property (atomic) BOOL is_gallery_configurationValue;
- (BOOL)is_gallery_configurationValue;
- (void)setIs_gallery_configurationValue:(BOOL)value_;

//- (BOOL)validateIs_gallery_configuration:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* is_practice;

@property (atomic) BOOL is_practiceValue;
- (BOOL)is_practiceValue;
- (void)setIs_practiceValue:(BOOL)value_;

//- (BOOL)validateIs_practice:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* loop_animations;

@property (atomic) BOOL loop_animationsValue;
- (BOOL)loop_animationsValue;
- (void)setLoop_animationsValue:(BOOL)value_;

//- (BOOL)validateLoop_animations:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* maximum_level;

//- (BOOL)validateMaximum_level:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* minimum_level;

//- (BOOL)validateMinimum_level:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* num_buttons;

@property (atomic) int16_t num_buttonsValue;
- (int16_t)num_buttonsValue;
- (void)setNum_buttonsValue:(int16_t)value_;

//- (BOOL)validateNum_buttons:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* num_correct_to_get_harder;

//- (BOOL)validateNum_correct_to_get_harder:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* num_wrong_to_get_easier;

//- (BOOL)validateNum_wrong_to_get_easier:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* number_of_reversals;

//- (BOOL)validateNumber_of_reversals:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* number_of_staircases;

@property (atomic) int16_t number_of_staircasesValue;
- (int16_t)number_of_staircasesValue;
- (void)setNumber_of_staircasesValue:(int16_t)value_;

//- (BOOL)validateNumber_of_staircases:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* questions_per_folder;

//- (BOOL)validateQuestions_per_folder:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* require_next;

@property (atomic) BOOL require_nextValue;
- (BOOL)require_nextValue;
- (void)setRequire_nextValue:(BOOL)value_;

//- (BOOL)validateRequire_next:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* server_id;

//- (BOOL)validateServer_id:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* server_url;

//- (BOOL)validateServer_url:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* show_exit_button;

@property (atomic) BOOL show_exit_buttonValue;
- (BOOL)show_exit_buttonValue;
- (void)setShow_exit_buttonValue:(BOOL)value_;

//- (BOOL)validateShow_exit_button:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* specified_seed;

@property (atomic) int32_t specified_seedValue;
- (int32_t)specified_seedValue;
- (void)setSpecified_seedValue:(int32_t)value_;

//- (BOOL)validateSpecified_seed:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* start_level;

//- (BOOL)validateStart_level:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* time_between_question_mean;

@property (atomic) float time_between_question_meanValue;
- (float)time_between_question_meanValue;
- (void)setTime_between_question_meanValue:(float)value_;

//- (BOOL)validateTime_between_question_mean:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* time_between_question_plusminus;

@property (atomic) float time_between_question_plusminusValue;
- (float)time_between_question_plusminusValue;
- (void)setTime_between_question_plusminusValue:(float)value_;

//- (BOOL)validateTime_between_question_plusminus:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* use_specified_seed;

@property (atomic) BOOL use_specified_seedValue;
- (BOOL)use_specified_seedValue;
- (void)setUse_specified_seedValue:(BOOL)value_;

//- (BOOL)validateUse_specified_seed:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* use_staircase_method;

@property (atomic) BOOL use_staircase_methodValue;
- (BOOL)use_staircase_methodValue;
- (void)setUse_staircase_methodValue:(BOOL)value_;

//- (BOOL)validateUse_staircase_method:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) TestSequence *sequence;

//- (BOOL)validateSequence:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) User *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@end

@interface _TestConfiguration (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveAnimation_frame_rate;
- (void)setPrimitiveAnimation_frame_rate:(NSNumber*)value;

- (int16_t)primitiveAnimation_frame_rateValue;
- (void)setPrimitiveAnimation_frame_rateValue:(int16_t)value_;

- (NSNumber*)primitiveAttempt_facial_recognition;
- (void)setPrimitiveAttempt_facial_recognition:(NSNumber*)value;

- (BOOL)primitiveAttempt_facial_recognitionValue;
- (void)setPrimitiveAttempt_facial_recognitionValue:(BOOL)value_;

- (NSString*)primitiveBackground_colour;
- (void)setPrimitiveBackground_colour:(NSString*)value;

- (NSString*)primitiveButton1_bg;
- (void)setPrimitiveButton1_bg:(NSString*)value;

- (NSString*)primitiveButton1_fg;
- (void)setPrimitiveButton1_fg:(NSString*)value;

- (NSNumber*)primitiveButton1_h;
- (void)setPrimitiveButton1_h:(NSNumber*)value;

- (int16_t)primitiveButton1_hValue;
- (void)setPrimitiveButton1_hValue:(int16_t)value_;

- (NSString*)primitiveButton1_text;
- (void)setPrimitiveButton1_text:(NSString*)value;

- (NSNumber*)primitiveButton1_w;
- (void)setPrimitiveButton1_w:(NSNumber*)value;

- (int16_t)primitiveButton1_wValue;
- (void)setPrimitiveButton1_wValue:(int16_t)value_;

- (NSNumber*)primitiveButton1_x;
- (void)setPrimitiveButton1_x:(NSNumber*)value;

- (int16_t)primitiveButton1_xValue;
- (void)setPrimitiveButton1_xValue:(int16_t)value_;

- (NSNumber*)primitiveButton1_y;
- (void)setPrimitiveButton1_y:(NSNumber*)value;

- (int16_t)primitiveButton1_yValue;
- (void)setPrimitiveButton1_yValue:(int16_t)value_;

- (NSString*)primitiveButton2_bg;
- (void)setPrimitiveButton2_bg:(NSString*)value;

- (NSString*)primitiveButton2_fg;
- (void)setPrimitiveButton2_fg:(NSString*)value;

- (NSNumber*)primitiveButton2_h;
- (void)setPrimitiveButton2_h:(NSNumber*)value;

- (int16_t)primitiveButton2_hValue;
- (void)setPrimitiveButton2_hValue:(int16_t)value_;

- (NSString*)primitiveButton2_text;
- (void)setPrimitiveButton2_text:(NSString*)value;

- (NSNumber*)primitiveButton2_w;
- (void)setPrimitiveButton2_w:(NSNumber*)value;

- (int16_t)primitiveButton2_wValue;
- (void)setPrimitiveButton2_wValue:(int16_t)value_;

- (NSNumber*)primitiveButton2_x;
- (void)setPrimitiveButton2_x:(NSNumber*)value;

- (int16_t)primitiveButton2_xValue;
- (void)setPrimitiveButton2_xValue:(int16_t)value_;

- (NSNumber*)primitiveButton2_y;
- (void)setPrimitiveButton2_y:(NSNumber*)value;

- (int16_t)primitiveButton2_yValue;
- (void)setPrimitiveButton2_yValue:(int16_t)value_;

- (NSString*)primitiveButton3_bg;
- (void)setPrimitiveButton3_bg:(NSString*)value;

- (NSString*)primitiveButton3_fg;
- (void)setPrimitiveButton3_fg:(NSString*)value;

- (NSNumber*)primitiveButton3_h;
- (void)setPrimitiveButton3_h:(NSNumber*)value;

- (int16_t)primitiveButton3_hValue;
- (void)setPrimitiveButton3_hValue:(int16_t)value_;

- (NSString*)primitiveButton3_text;
- (void)setPrimitiveButton3_text:(NSString*)value;

- (NSNumber*)primitiveButton3_w;
- (void)setPrimitiveButton3_w:(NSNumber*)value;

- (int16_t)primitiveButton3_wValue;
- (void)setPrimitiveButton3_wValue:(int16_t)value_;

- (NSNumber*)primitiveButton3_x;
- (void)setPrimitiveButton3_x:(NSNumber*)value;

- (int16_t)primitiveButton3_xValue;
- (void)setPrimitiveButton3_xValue:(int16_t)value_;

- (NSNumber*)primitiveButton3_y;
- (void)setPrimitiveButton3_y:(NSNumber*)value;

- (int16_t)primitiveButton3_yValue;
- (void)setPrimitiveButton3_yValue:(int16_t)value_;

- (NSString*)primitiveButton4_bg;
- (void)setPrimitiveButton4_bg:(NSString*)value;

- (NSString*)primitiveButton4_fg;
- (void)setPrimitiveButton4_fg:(NSString*)value;

- (NSNumber*)primitiveButton4_h;
- (void)setPrimitiveButton4_h:(NSNumber*)value;

- (int16_t)primitiveButton4_hValue;
- (void)setPrimitiveButton4_hValue:(int16_t)value_;

- (NSString*)primitiveButton4_text;
- (void)setPrimitiveButton4_text:(NSString*)value;

- (NSNumber*)primitiveButton4_w;
- (void)setPrimitiveButton4_w:(NSNumber*)value;

- (int16_t)primitiveButton4_wValue;
- (void)setPrimitiveButton4_wValue:(int16_t)value_;

- (NSNumber*)primitiveButton4_x;
- (void)setPrimitiveButton4_x:(NSNumber*)value;

- (int16_t)primitiveButton4_xValue;
- (void)setPrimitiveButton4_xValue:(int16_t)value_;

- (NSNumber*)primitiveButton4_y;
- (void)setPrimitiveButton4_y:(NSNumber*)value;

- (int16_t)primitiveButton4_yValue;
- (void)setPrimitiveButton4_yValue:(int16_t)value_;

- (NSNumber*)primitiveButton_presentation_delay;
- (void)setPrimitiveButton_presentation_delay:(NSNumber*)value;

- (float)primitiveButton_presentation_delayValue;
- (void)setPrimitiveButton_presentation_delayValue:(float)value_;

- (NSString*)primitiveConfiguration_description;
- (void)setPrimitiveConfiguration_description:(NSString*)value;

- (NSNumber*)primitiveDay_of_week_fri;
- (void)setPrimitiveDay_of_week_fri:(NSNumber*)value;

- (BOOL)primitiveDay_of_week_friValue;
- (void)setPrimitiveDay_of_week_friValue:(BOOL)value_;

- (NSNumber*)primitiveDay_of_week_mon;
- (void)setPrimitiveDay_of_week_mon:(NSNumber*)value;

- (BOOL)primitiveDay_of_week_monValue;
- (void)setPrimitiveDay_of_week_monValue:(BOOL)value_;

- (NSNumber*)primitiveDay_of_week_sat;
- (void)setPrimitiveDay_of_week_sat:(NSNumber*)value;

- (BOOL)primitiveDay_of_week_satValue;
- (void)setPrimitiveDay_of_week_satValue:(BOOL)value_;

- (NSNumber*)primitiveDay_of_week_sun;
- (void)setPrimitiveDay_of_week_sun:(NSNumber*)value;

- (BOOL)primitiveDay_of_week_sunValue;
- (void)setPrimitiveDay_of_week_sunValue:(BOOL)value_;

- (NSNumber*)primitiveDay_of_week_thu;
- (void)setPrimitiveDay_of_week_thu:(NSNumber*)value;

- (BOOL)primitiveDay_of_week_thuValue;
- (void)setPrimitiveDay_of_week_thuValue:(BOOL)value_;

- (NSNumber*)primitiveDay_of_week_tue;
- (void)setPrimitiveDay_of_week_tue:(NSNumber*)value;

- (BOOL)primitiveDay_of_week_tueValue;
- (void)setPrimitiveDay_of_week_tueValue:(BOOL)value_;

- (NSNumber*)primitiveDay_of_week_wed;
- (void)setPrimitiveDay_of_week_wed:(NSNumber*)value;

- (BOOL)primitiveDay_of_week_wedValue;
- (void)setPrimitiveDay_of_week_wedValue:(BOOL)value_;

- (NSString*)primitiveDelta_values;
- (void)setPrimitiveDelta_values:(NSString*)value;

- (NSNumber*)primitiveEnabled;
- (void)setPrimitiveEnabled:(NSNumber*)value;

- (BOOL)primitiveEnabledValue;
- (void)setPrimitiveEnabledValue:(BOOL)value_;

- (NSString*)primitiveExit_button_bg;
- (void)setPrimitiveExit_button_bg:(NSString*)value;

- (NSString*)primitiveExit_button_fg;
- (void)setPrimitiveExit_button_fg:(NSString*)value;

- (NSNumber*)primitiveExit_button_h;
- (void)setPrimitiveExit_button_h:(NSNumber*)value;

- (int16_t)primitiveExit_button_hValue;
- (void)setPrimitiveExit_button_hValue:(int16_t)value_;

- (NSNumber*)primitiveExit_button_w;
- (void)setPrimitiveExit_button_w:(NSNumber*)value;

- (int16_t)primitiveExit_button_wValue;
- (void)setPrimitiveExit_button_wValue:(int16_t)value_;

- (NSNumber*)primitiveExit_button_x;
- (void)setPrimitiveExit_button_x:(NSNumber*)value;

- (int16_t)primitiveExit_button_xValue;
- (void)setPrimitiveExit_button_xValue:(int16_t)value_;

- (NSNumber*)primitiveExit_button_y;
- (void)setPrimitiveExit_button_y:(NSNumber*)value;

- (int16_t)primitiveExit_button_yValue;
- (void)setPrimitiveExit_button_yValue:(int16_t)value_;

- (NSNumber*)primitiveFinite_presentation_time;
- (void)setPrimitiveFinite_presentation_time:(NSNumber*)value;

- (float)primitiveFinite_presentation_timeValue;
- (void)setPrimitiveFinite_presentation_timeValue:(float)value_;

- (NSNumber*)primitiveFinite_response_window;
- (void)setPrimitiveFinite_response_window:(NSNumber*)value;

- (float)primitiveFinite_response_windowValue;
- (void)setPrimitiveFinite_response_windowValue:(float)value_;

- (NSString*)primitiveHits_to_finish;
- (void)setPrimitiveHits_to_finish:(NSString*)value;

- (NSNumber*)primitiveInfinite_presentation_time;
- (void)setPrimitiveInfinite_presentation_time:(NSNumber*)value;

- (BOOL)primitiveInfinite_presentation_timeValue;
- (void)setPrimitiveInfinite_presentation_timeValue:(BOOL)value_;

- (NSNumber*)primitiveInfinite_response_window;
- (void)setPrimitiveInfinite_response_window:(NSNumber*)value;

- (BOOL)primitiveInfinite_response_windowValue;
- (void)setPrimitiveInfinite_response_windowValue:(BOOL)value_;

- (NSNumber*)primitiveIs_gallery_configuration;
- (void)setPrimitiveIs_gallery_configuration:(NSNumber*)value;

- (BOOL)primitiveIs_gallery_configurationValue;
- (void)setPrimitiveIs_gallery_configurationValue:(BOOL)value_;

- (NSNumber*)primitiveIs_practice;
- (void)setPrimitiveIs_practice:(NSNumber*)value;

- (BOOL)primitiveIs_practiceValue;
- (void)setPrimitiveIs_practiceValue:(BOOL)value_;

- (NSNumber*)primitiveLoop_animations;
- (void)setPrimitiveLoop_animations:(NSNumber*)value;

- (BOOL)primitiveLoop_animationsValue;
- (void)setPrimitiveLoop_animationsValue:(BOOL)value_;

- (NSString*)primitiveMaximum_level;
- (void)setPrimitiveMaximum_level:(NSString*)value;

- (NSString*)primitiveMinimum_level;
- (void)setPrimitiveMinimum_level:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitiveNum_buttons;
- (void)setPrimitiveNum_buttons:(NSNumber*)value;

- (int16_t)primitiveNum_buttonsValue;
- (void)setPrimitiveNum_buttonsValue:(int16_t)value_;

- (NSString*)primitiveNum_correct_to_get_harder;
- (void)setPrimitiveNum_correct_to_get_harder:(NSString*)value;

- (NSString*)primitiveNum_wrong_to_get_easier;
- (void)setPrimitiveNum_wrong_to_get_easier:(NSString*)value;

- (NSString*)primitiveNumber_of_reversals;
- (void)setPrimitiveNumber_of_reversals:(NSString*)value;

- (NSNumber*)primitiveNumber_of_staircases;
- (void)setPrimitiveNumber_of_staircases:(NSNumber*)value;

- (int16_t)primitiveNumber_of_staircasesValue;
- (void)setPrimitiveNumber_of_staircasesValue:(int16_t)value_;

- (NSString*)primitiveQuestions_per_folder;
- (void)setPrimitiveQuestions_per_folder:(NSString*)value;

- (NSNumber*)primitiveRequire_next;
- (void)setPrimitiveRequire_next:(NSNumber*)value;

- (BOOL)primitiveRequire_nextValue;
- (void)setPrimitiveRequire_nextValue:(BOOL)value_;

- (NSString*)primitiveServer_id;
- (void)setPrimitiveServer_id:(NSString*)value;

- (NSString*)primitiveServer_url;
- (void)setPrimitiveServer_url:(NSString*)value;

- (NSNumber*)primitiveShow_exit_button;
- (void)setPrimitiveShow_exit_button:(NSNumber*)value;

- (BOOL)primitiveShow_exit_buttonValue;
- (void)setPrimitiveShow_exit_buttonValue:(BOOL)value_;

- (NSNumber*)primitiveSpecified_seed;
- (void)setPrimitiveSpecified_seed:(NSNumber*)value;

- (int32_t)primitiveSpecified_seedValue;
- (void)setPrimitiveSpecified_seedValue:(int32_t)value_;

- (NSString*)primitiveStart_level;
- (void)setPrimitiveStart_level:(NSString*)value;

- (NSNumber*)primitiveTime_between_question_mean;
- (void)setPrimitiveTime_between_question_mean:(NSNumber*)value;

- (float)primitiveTime_between_question_meanValue;
- (void)setPrimitiveTime_between_question_meanValue:(float)value_;

- (NSNumber*)primitiveTime_between_question_plusminus;
- (void)setPrimitiveTime_between_question_plusminus:(NSNumber*)value;

- (float)primitiveTime_between_question_plusminusValue;
- (void)setPrimitiveTime_between_question_plusminusValue:(float)value_;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSNumber*)primitiveUse_specified_seed;
- (void)setPrimitiveUse_specified_seed:(NSNumber*)value;

- (BOOL)primitiveUse_specified_seedValue;
- (void)setPrimitiveUse_specified_seedValue:(BOOL)value_;

- (NSNumber*)primitiveUse_staircase_method;
- (void)setPrimitiveUse_staircase_method:(NSNumber*)value;

- (BOOL)primitiveUse_staircase_methodValue;
- (void)setPrimitiveUse_staircase_methodValue:(BOOL)value_;

- (TestSequence*)primitiveSequence;
- (void)setPrimitiveSequence:(TestSequence*)value;

- (User*)primitiveUser;
- (void)setPrimitiveUser:(User*)value;

@end
