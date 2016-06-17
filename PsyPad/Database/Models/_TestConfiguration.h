// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestConfiguration.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class TestSequence;
@class User;

@interface TestConfigurationID : NSManagedObjectID {}
@end

@interface _TestConfiguration : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TestConfigurationID *objectID;

@property (nonatomic, strong) NSNumber* animation_frame_rate;

@property (atomic) int16_t animation_frame_rateValue;
- (int16_t)animation_frame_rateValue;
- (void)setAnimation_frame_rateValue:(int16_t)value_;

@property (nonatomic, strong) NSNumber* attempt_facial_recognition;

@property (atomic) BOOL attempt_facial_recognitionValue;
- (BOOL)attempt_facial_recognitionValue;
- (void)setAttempt_facial_recognitionValue:(BOOL)value_;

@property (nonatomic, strong) NSString* background_colour;

@property (nonatomic, strong) NSString* button1_bg;

@property (nonatomic, strong) NSString* button1_fg;

@property (nonatomic, strong) NSNumber* button1_h;

@property (atomic) int16_t button1_hValue;
- (int16_t)button1_hValue;
- (void)setButton1_hValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* button1_text;

@property (nonatomic, strong) NSNumber* button1_w;

@property (atomic) int16_t button1_wValue;
- (int16_t)button1_wValue;
- (void)setButton1_wValue:(int16_t)value_;

@property (nonatomic, strong) NSNumber* button1_x;

@property (atomic) int16_t button1_xValue;
- (int16_t)button1_xValue;
- (void)setButton1_xValue:(int16_t)value_;

@property (nonatomic, strong) NSNumber* button1_y;

@property (atomic) int16_t button1_yValue;
- (int16_t)button1_yValue;
- (void)setButton1_yValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* button2_bg;

@property (nonatomic, strong, nullable) NSString* button2_fg;

@property (nonatomic, strong, nullable) NSNumber* button2_h;

@property (atomic) int16_t button2_hValue;
- (int16_t)button2_hValue;
- (void)setButton2_hValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* button2_text;

@property (nonatomic, strong, nullable) NSNumber* button2_w;

@property (atomic) int16_t button2_wValue;
- (int16_t)button2_wValue;
- (void)setButton2_wValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* button2_x;

@property (atomic) int16_t button2_xValue;
- (int16_t)button2_xValue;
- (void)setButton2_xValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* button2_y;

@property (atomic) int16_t button2_yValue;
- (int16_t)button2_yValue;
- (void)setButton2_yValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* button3_bg;

@property (nonatomic, strong, nullable) NSString* button3_fg;

@property (nonatomic, strong, nullable) NSNumber* button3_h;

@property (atomic) int16_t button3_hValue;
- (int16_t)button3_hValue;
- (void)setButton3_hValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* button3_text;

@property (nonatomic, strong, nullable) NSNumber* button3_w;

@property (atomic) int16_t button3_wValue;
- (int16_t)button3_wValue;
- (void)setButton3_wValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* button3_x;

@property (atomic) int16_t button3_xValue;
- (int16_t)button3_xValue;
- (void)setButton3_xValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* button3_y;

@property (atomic) int16_t button3_yValue;
- (int16_t)button3_yValue;
- (void)setButton3_yValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* button4_bg;

@property (nonatomic, strong, nullable) NSString* button4_fg;

@property (nonatomic, strong, nullable) NSNumber* button4_h;

@property (atomic) int16_t button4_hValue;
- (int16_t)button4_hValue;
- (void)setButton4_hValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* button4_text;

@property (nonatomic, strong, nullable) NSNumber* button4_w;

@property (atomic) int16_t button4_wValue;
- (int16_t)button4_wValue;
- (void)setButton4_wValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* button4_x;

@property (atomic) int16_t button4_xValue;
- (int16_t)button4_xValue;
- (void)setButton4_xValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* button4_y;

@property (atomic) int16_t button4_yValue;
- (int16_t)button4_yValue;
- (void)setButton4_yValue:(int16_t)value_;

@property (nonatomic, strong) NSNumber* button_presentation_delay;

@property (atomic) float button_presentation_delayValue;
- (float)button_presentation_delayValue;
- (void)setButton_presentation_delayValue:(float)value_;

@property (nonatomic, strong, nullable) NSString* configuration_description;

@property (nonatomic, strong) NSNumber* day_of_week_fri;

@property (atomic) BOOL day_of_week_friValue;
- (BOOL)day_of_week_friValue;
- (void)setDay_of_week_friValue:(BOOL)value_;

@property (nonatomic, strong) NSNumber* day_of_week_mon;

@property (atomic) BOOL day_of_week_monValue;
- (BOOL)day_of_week_monValue;
- (void)setDay_of_week_monValue:(BOOL)value_;

@property (nonatomic, strong) NSNumber* day_of_week_sat;

@property (atomic) BOOL day_of_week_satValue;
- (BOOL)day_of_week_satValue;
- (void)setDay_of_week_satValue:(BOOL)value_;

@property (nonatomic, strong) NSNumber* day_of_week_sun;

@property (atomic) BOOL day_of_week_sunValue;
- (BOOL)day_of_week_sunValue;
- (void)setDay_of_week_sunValue:(BOOL)value_;

@property (nonatomic, strong) NSNumber* day_of_week_thu;

@property (atomic) BOOL day_of_week_thuValue;
- (BOOL)day_of_week_thuValue;
- (void)setDay_of_week_thuValue:(BOOL)value_;

@property (nonatomic, strong) NSNumber* day_of_week_tue;

@property (atomic) BOOL day_of_week_tueValue;
- (BOOL)day_of_week_tueValue;
- (void)setDay_of_week_tueValue:(BOOL)value_;

@property (nonatomic, strong) NSNumber* day_of_week_wed;

@property (atomic) BOOL day_of_week_wedValue;
- (BOOL)day_of_week_wedValue;
- (void)setDay_of_week_wedValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* delta_values;

@property (nonatomic, strong) NSNumber* enable_secondary_stimuli;

@property (atomic) BOOL enable_secondary_stimuliValue;
- (BOOL)enable_secondary_stimuliValue;
- (void)setEnable_secondary_stimuliValue:(BOOL)value_;

@property (nonatomic, strong) NSNumber* enabled;

@property (atomic) BOOL enabledValue;
- (BOOL)enabledValue;
- (void)setEnabledValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* exit_button_bg;

@property (nonatomic, strong, nullable) NSString* exit_button_fg;

@property (nonatomic, strong, nullable) NSNumber* exit_button_h;

@property (atomic) int16_t exit_button_hValue;
- (int16_t)exit_button_hValue;
- (void)setExit_button_hValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* exit_button_w;

@property (atomic) int16_t exit_button_wValue;
- (int16_t)exit_button_wValue;
- (void)setExit_button_wValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* exit_button_x;

@property (atomic) int16_t exit_button_xValue;
- (int16_t)exit_button_xValue;
- (void)setExit_button_xValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* exit_button_y;

@property (atomic) int16_t exit_button_yValue;
- (int16_t)exit_button_yValue;
- (void)setExit_button_yValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* finite_presentation_time;

@property (atomic) float finite_presentation_timeValue;
- (float)finite_presentation_timeValue;
- (void)setFinite_presentation_timeValue:(float)value_;

@property (nonatomic, strong, nullable) NSNumber* finite_response_window;

@property (atomic) float finite_response_windowValue;
- (float)finite_response_windowValue;
- (void)setFinite_response_windowValue:(float)value_;

@property (nonatomic, strong, nullable) NSString* hits_to_finish;

@property (nonatomic, strong) NSNumber* infinite_presentation_time;

@property (atomic) BOOL infinite_presentation_timeValue;
- (BOOL)infinite_presentation_timeValue;
- (void)setInfinite_presentation_timeValue:(BOOL)value_;

@property (nonatomic, strong) NSNumber* infinite_response_window;

@property (atomic) BOOL infinite_response_windowValue;
- (BOOL)infinite_response_windowValue;
- (void)setInfinite_response_windowValue:(BOOL)value_;

@property (nonatomic, strong) NSNumber* is_gallery_configuration;

@property (atomic) BOOL is_gallery_configurationValue;
- (BOOL)is_gallery_configurationValue;
- (void)setIs_gallery_configurationValue:(BOOL)value_;

@property (nonatomic, strong) NSNumber* is_practice;

@property (atomic) BOOL is_practiceValue;
- (BOOL)is_practiceValue;
- (void)setIs_practiceValue:(BOOL)value_;

@property (nonatomic, strong) NSNumber* loop_animations;

@property (atomic) BOOL loop_animationsValue;
- (BOOL)loop_animationsValue;
- (void)setLoop_animationsValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* maximum_level;

@property (nonatomic, strong, nullable) NSString* minimum_level;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSNumber* num_buttons;

@property (atomic) int16_t num_buttonsValue;
- (int16_t)num_buttonsValue;
- (void)setNum_buttonsValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* num_correct_to_get_harder;

@property (nonatomic, strong) NSNumber* num_secondary_buttons;

@property (atomic) int16_t num_secondary_buttonsValue;
- (int16_t)num_secondary_buttonsValue;
- (void)setNum_secondary_buttonsValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* num_wrong_to_get_easier;

@property (nonatomic, strong) NSString* number_of_reversals;

@property (nonatomic, strong, nullable) NSNumber* number_of_staircases;

@property (atomic) int16_t number_of_staircasesValue;
- (int16_t)number_of_staircasesValue;
- (void)setNumber_of_staircasesValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* questions_per_folder;

@property (nonatomic, strong) NSNumber* require_next;

@property (atomic) BOOL require_nextValue;
- (BOOL)require_nextValue;
- (void)setRequire_nextValue:(BOOL)value_;

@property (nonatomic, strong) NSString* secondary_button1_bg;

@property (nonatomic, strong) NSString* secondary_button1_fg;

@property (nonatomic, strong) NSNumber* secondary_button1_h;

@property (atomic) int16_t secondary_button1_hValue;
- (int16_t)secondary_button1_hValue;
- (void)setSecondary_button1_hValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* secondary_button1_text;

@property (nonatomic, strong) NSNumber* secondary_button1_w;

@property (atomic) int16_t secondary_button1_wValue;
- (int16_t)secondary_button1_wValue;
- (void)setSecondary_button1_wValue:(int16_t)value_;

@property (nonatomic, strong) NSNumber* secondary_button1_x;

@property (atomic) int16_t secondary_button1_xValue;
- (int16_t)secondary_button1_xValue;
- (void)setSecondary_button1_xValue:(int16_t)value_;

@property (nonatomic, strong) NSNumber* secondary_button1_y;

@property (atomic) int16_t secondary_button1_yValue;
- (int16_t)secondary_button1_yValue;
- (void)setSecondary_button1_yValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* secondary_button2_bg;

@property (nonatomic, strong, nullable) NSString* secondary_button2_fg;

@property (nonatomic, strong, nullable) NSNumber* secondary_button2_h;

@property (atomic) int16_t secondary_button2_hValue;
- (int16_t)secondary_button2_hValue;
- (void)setSecondary_button2_hValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* secondary_button2_text;

@property (nonatomic, strong, nullable) NSNumber* secondary_button2_w;

@property (atomic) int16_t secondary_button2_wValue;
- (int16_t)secondary_button2_wValue;
- (void)setSecondary_button2_wValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_button2_x;

@property (atomic) int16_t secondary_button2_xValue;
- (int16_t)secondary_button2_xValue;
- (void)setSecondary_button2_xValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_button2_y;

@property (atomic) int16_t secondary_button2_yValue;
- (int16_t)secondary_button2_yValue;
- (void)setSecondary_button2_yValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* secondary_button3_bg;

@property (nonatomic, strong, nullable) NSString* secondary_button3_fg;

@property (nonatomic, strong, nullable) NSNumber* secondary_button3_h;

@property (atomic) int16_t secondary_button3_hValue;
- (int16_t)secondary_button3_hValue;
- (void)setSecondary_button3_hValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* secondary_button3_text;

@property (nonatomic, strong, nullable) NSNumber* secondary_button3_w;

@property (atomic) int16_t secondary_button3_wValue;
- (int16_t)secondary_button3_wValue;
- (void)setSecondary_button3_wValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_button3_x;

@property (atomic) int16_t secondary_button3_xValue;
- (int16_t)secondary_button3_xValue;
- (void)setSecondary_button3_xValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_button3_y;

@property (atomic) int16_t secondary_button3_yValue;
- (int16_t)secondary_button3_yValue;
- (void)setSecondary_button3_yValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* secondary_button4_bg;

@property (nonatomic, strong, nullable) NSString* secondary_button4_fg;

@property (nonatomic, strong, nullable) NSNumber* secondary_button4_h;

@property (atomic) int16_t secondary_button4_hValue;
- (int16_t)secondary_button4_hValue;
- (void)setSecondary_button4_hValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* secondary_button4_text;

@property (nonatomic, strong, nullable) NSNumber* secondary_button4_w;

@property (atomic) int16_t secondary_button4_wValue;
- (int16_t)secondary_button4_wValue;
- (void)setSecondary_button4_wValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_button4_x;

@property (atomic) int16_t secondary_button4_xValue;
- (int16_t)secondary_button4_xValue;
- (void)setSecondary_button4_xValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* secondary_button4_y;

@property (atomic) int16_t secondary_button4_yValue;
- (int16_t)secondary_button4_yValue;
- (void)setSecondary_button4_yValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* server_id;

@property (nonatomic, strong, nullable) NSString* server_url;

@property (nonatomic, strong) NSNumber* show_exit_button;

@property (atomic) BOOL show_exit_buttonValue;
- (BOOL)show_exit_buttonValue;
- (void)setShow_exit_buttonValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* specified_seed;

@property (atomic) int32_t specified_seedValue;
- (int32_t)specified_seedValue;
- (void)setSpecified_seedValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* start_level;

@property (nonatomic, strong) NSNumber* time_between_question_mean;

@property (atomic) float time_between_question_meanValue;
- (float)time_between_question_meanValue;
- (void)setTime_between_question_meanValue:(float)value_;

@property (nonatomic, strong) NSNumber* time_between_question_plusminus;

@property (atomic) float time_between_question_plusminusValue;
- (float)time_between_question_plusminusValue;
- (void)setTime_between_question_plusminusValue:(float)value_;

@property (nonatomic, strong, nullable) NSString* title;

@property (nonatomic, strong) NSNumber* use_specified_seed;

@property (atomic) BOOL use_specified_seedValue;
- (BOOL)use_specified_seedValue;
- (void)setUse_specified_seedValue:(BOOL)value_;

@property (nonatomic, strong) NSNumber* use_staircase_method;

@property (atomic) BOOL use_staircase_methodValue;
- (BOOL)use_staircase_methodValue;
- (void)setUse_staircase_methodValue:(BOOL)value_;

@property (nonatomic, strong) TestSequence *sequence;

@property (nonatomic, strong, nullable) User *user;

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

- (NSNumber*)primitiveEnable_secondary_stimuli;
- (void)setPrimitiveEnable_secondary_stimuli:(NSNumber*)value;

- (BOOL)primitiveEnable_secondary_stimuliValue;
- (void)setPrimitiveEnable_secondary_stimuliValue:(BOOL)value_;

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

- (NSNumber*)primitiveNum_secondary_buttons;
- (void)setPrimitiveNum_secondary_buttons:(NSNumber*)value;

- (int16_t)primitiveNum_secondary_buttonsValue;
- (void)setPrimitiveNum_secondary_buttonsValue:(int16_t)value_;

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

- (NSString*)primitiveSecondary_button1_bg;
- (void)setPrimitiveSecondary_button1_bg:(NSString*)value;

- (NSString*)primitiveSecondary_button1_fg;
- (void)setPrimitiveSecondary_button1_fg:(NSString*)value;

- (NSNumber*)primitiveSecondary_button1_h;
- (void)setPrimitiveSecondary_button1_h:(NSNumber*)value;

- (int16_t)primitiveSecondary_button1_hValue;
- (void)setPrimitiveSecondary_button1_hValue:(int16_t)value_;

- (NSString*)primitiveSecondary_button1_text;
- (void)setPrimitiveSecondary_button1_text:(NSString*)value;

- (NSNumber*)primitiveSecondary_button1_w;
- (void)setPrimitiveSecondary_button1_w:(NSNumber*)value;

- (int16_t)primitiveSecondary_button1_wValue;
- (void)setPrimitiveSecondary_button1_wValue:(int16_t)value_;

- (NSNumber*)primitiveSecondary_button1_x;
- (void)setPrimitiveSecondary_button1_x:(NSNumber*)value;

- (int16_t)primitiveSecondary_button1_xValue;
- (void)setPrimitiveSecondary_button1_xValue:(int16_t)value_;

- (NSNumber*)primitiveSecondary_button1_y;
- (void)setPrimitiveSecondary_button1_y:(NSNumber*)value;

- (int16_t)primitiveSecondary_button1_yValue;
- (void)setPrimitiveSecondary_button1_yValue:(int16_t)value_;

- (NSString*)primitiveSecondary_button2_bg;
- (void)setPrimitiveSecondary_button2_bg:(NSString*)value;

- (NSString*)primitiveSecondary_button2_fg;
- (void)setPrimitiveSecondary_button2_fg:(NSString*)value;

- (NSNumber*)primitiveSecondary_button2_h;
- (void)setPrimitiveSecondary_button2_h:(NSNumber*)value;

- (int16_t)primitiveSecondary_button2_hValue;
- (void)setPrimitiveSecondary_button2_hValue:(int16_t)value_;

- (NSString*)primitiveSecondary_button2_text;
- (void)setPrimitiveSecondary_button2_text:(NSString*)value;

- (NSNumber*)primitiveSecondary_button2_w;
- (void)setPrimitiveSecondary_button2_w:(NSNumber*)value;

- (int16_t)primitiveSecondary_button2_wValue;
- (void)setPrimitiveSecondary_button2_wValue:(int16_t)value_;

- (NSNumber*)primitiveSecondary_button2_x;
- (void)setPrimitiveSecondary_button2_x:(NSNumber*)value;

- (int16_t)primitiveSecondary_button2_xValue;
- (void)setPrimitiveSecondary_button2_xValue:(int16_t)value_;

- (NSNumber*)primitiveSecondary_button2_y;
- (void)setPrimitiveSecondary_button2_y:(NSNumber*)value;

- (int16_t)primitiveSecondary_button2_yValue;
- (void)setPrimitiveSecondary_button2_yValue:(int16_t)value_;

- (NSString*)primitiveSecondary_button3_bg;
- (void)setPrimitiveSecondary_button3_bg:(NSString*)value;

- (NSString*)primitiveSecondary_button3_fg;
- (void)setPrimitiveSecondary_button3_fg:(NSString*)value;

- (NSNumber*)primitiveSecondary_button3_h;
- (void)setPrimitiveSecondary_button3_h:(NSNumber*)value;

- (int16_t)primitiveSecondary_button3_hValue;
- (void)setPrimitiveSecondary_button3_hValue:(int16_t)value_;

- (NSString*)primitiveSecondary_button3_text;
- (void)setPrimitiveSecondary_button3_text:(NSString*)value;

- (NSNumber*)primitiveSecondary_button3_w;
- (void)setPrimitiveSecondary_button3_w:(NSNumber*)value;

- (int16_t)primitiveSecondary_button3_wValue;
- (void)setPrimitiveSecondary_button3_wValue:(int16_t)value_;

- (NSNumber*)primitiveSecondary_button3_x;
- (void)setPrimitiveSecondary_button3_x:(NSNumber*)value;

- (int16_t)primitiveSecondary_button3_xValue;
- (void)setPrimitiveSecondary_button3_xValue:(int16_t)value_;

- (NSNumber*)primitiveSecondary_button3_y;
- (void)setPrimitiveSecondary_button3_y:(NSNumber*)value;

- (int16_t)primitiveSecondary_button3_yValue;
- (void)setPrimitiveSecondary_button3_yValue:(int16_t)value_;

- (NSString*)primitiveSecondary_button4_bg;
- (void)setPrimitiveSecondary_button4_bg:(NSString*)value;

- (NSString*)primitiveSecondary_button4_fg;
- (void)setPrimitiveSecondary_button4_fg:(NSString*)value;

- (NSNumber*)primitiveSecondary_button4_h;
- (void)setPrimitiveSecondary_button4_h:(NSNumber*)value;

- (int16_t)primitiveSecondary_button4_hValue;
- (void)setPrimitiveSecondary_button4_hValue:(int16_t)value_;

- (NSString*)primitiveSecondary_button4_text;
- (void)setPrimitiveSecondary_button4_text:(NSString*)value;

- (NSNumber*)primitiveSecondary_button4_w;
- (void)setPrimitiveSecondary_button4_w:(NSNumber*)value;

- (int16_t)primitiveSecondary_button4_wValue;
- (void)setPrimitiveSecondary_button4_wValue:(int16_t)value_;

- (NSNumber*)primitiveSecondary_button4_x;
- (void)setPrimitiveSecondary_button4_x:(NSNumber*)value;

- (int16_t)primitiveSecondary_button4_xValue;
- (void)setPrimitiveSecondary_button4_xValue:(int16_t)value_;

- (NSNumber*)primitiveSecondary_button4_y;
- (void)setPrimitiveSecondary_button4_y:(NSNumber*)value;

- (int16_t)primitiveSecondary_button4_yValue;
- (void)setPrimitiveSecondary_button4_yValue:(int16_t)value_;

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

@interface TestConfigurationAttributes: NSObject 
+ (NSString *)animation_frame_rate;
+ (NSString *)attempt_facial_recognition;
+ (NSString *)background_colour;
+ (NSString *)button1_bg;
+ (NSString *)button1_fg;
+ (NSString *)button1_h;
+ (NSString *)button1_text;
+ (NSString *)button1_w;
+ (NSString *)button1_x;
+ (NSString *)button1_y;
+ (NSString *)button2_bg;
+ (NSString *)button2_fg;
+ (NSString *)button2_h;
+ (NSString *)button2_text;
+ (NSString *)button2_w;
+ (NSString *)button2_x;
+ (NSString *)button2_y;
+ (NSString *)button3_bg;
+ (NSString *)button3_fg;
+ (NSString *)button3_h;
+ (NSString *)button3_text;
+ (NSString *)button3_w;
+ (NSString *)button3_x;
+ (NSString *)button3_y;
+ (NSString *)button4_bg;
+ (NSString *)button4_fg;
+ (NSString *)button4_h;
+ (NSString *)button4_text;
+ (NSString *)button4_w;
+ (NSString *)button4_x;
+ (NSString *)button4_y;
+ (NSString *)button_presentation_delay;
+ (NSString *)configuration_description;
+ (NSString *)day_of_week_fri;
+ (NSString *)day_of_week_mon;
+ (NSString *)day_of_week_sat;
+ (NSString *)day_of_week_sun;
+ (NSString *)day_of_week_thu;
+ (NSString *)day_of_week_tue;
+ (NSString *)day_of_week_wed;
+ (NSString *)delta_values;
+ (NSString *)enable_secondary_stimuli;
+ (NSString *)enabled;
+ (NSString *)exit_button_bg;
+ (NSString *)exit_button_fg;
+ (NSString *)exit_button_h;
+ (NSString *)exit_button_w;
+ (NSString *)exit_button_x;
+ (NSString *)exit_button_y;
+ (NSString *)finite_presentation_time;
+ (NSString *)finite_response_window;
+ (NSString *)hits_to_finish;
+ (NSString *)infinite_presentation_time;
+ (NSString *)infinite_response_window;
+ (NSString *)is_gallery_configuration;
+ (NSString *)is_practice;
+ (NSString *)loop_animations;
+ (NSString *)maximum_level;
+ (NSString *)minimum_level;
+ (NSString *)name;
+ (NSString *)num_buttons;
+ (NSString *)num_correct_to_get_harder;
+ (NSString *)num_secondary_buttons;
+ (NSString *)num_wrong_to_get_easier;
+ (NSString *)number_of_reversals;
+ (NSString *)number_of_staircases;
+ (NSString *)questions_per_folder;
+ (NSString *)require_next;
+ (NSString *)secondary_button1_bg;
+ (NSString *)secondary_button1_fg;
+ (NSString *)secondary_button1_h;
+ (NSString *)secondary_button1_text;
+ (NSString *)secondary_button1_w;
+ (NSString *)secondary_button1_x;
+ (NSString *)secondary_button1_y;
+ (NSString *)secondary_button2_bg;
+ (NSString *)secondary_button2_fg;
+ (NSString *)secondary_button2_h;
+ (NSString *)secondary_button2_text;
+ (NSString *)secondary_button2_w;
+ (NSString *)secondary_button2_x;
+ (NSString *)secondary_button2_y;
+ (NSString *)secondary_button3_bg;
+ (NSString *)secondary_button3_fg;
+ (NSString *)secondary_button3_h;
+ (NSString *)secondary_button3_text;
+ (NSString *)secondary_button3_w;
+ (NSString *)secondary_button3_x;
+ (NSString *)secondary_button3_y;
+ (NSString *)secondary_button4_bg;
+ (NSString *)secondary_button4_fg;
+ (NSString *)secondary_button4_h;
+ (NSString *)secondary_button4_text;
+ (NSString *)secondary_button4_w;
+ (NSString *)secondary_button4_x;
+ (NSString *)secondary_button4_y;
+ (NSString *)server_id;
+ (NSString *)server_url;
+ (NSString *)show_exit_button;
+ (NSString *)specified_seed;
+ (NSString *)start_level;
+ (NSString *)time_between_question_mean;
+ (NSString *)time_between_question_plusminus;
+ (NSString *)title;
+ (NSString *)use_specified_seed;
+ (NSString *)use_staircase_method;
@end

@interface TestConfigurationRelationships: NSObject
+ (NSString *)sequence;
+ (NSString *)user;
@end

NS_ASSUME_NONNULL_END
