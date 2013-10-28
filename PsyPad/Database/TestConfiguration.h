//
//  TestConfiguration.h
//  eTASM
//
//  Created by David Lawson on 5/12/12.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SSZipArchive.h"

@class TestSequence;
@class TestLog;
@class User;
@class MBProgressHUD;

@interface TestConfiguration : NSManagedObject <SSZipArchiveDelegate>

// id irrelevant
// position stored with relationship

@property (nonatomic, retain) NSNumber * animation_frame_rate;
@property (nonatomic, retain) NSNumber * attempt_facial_recognition;
@property (nonatomic, retain) NSString * background_colour;
@property (nonatomic, retain) NSString * button_text_four;
@property (nonatomic, retain) NSString * button_text_one;
@property (nonatomic, retain) NSString * button_text_three;
@property (nonatomic, retain) NSString * button_text_two;
@property (nonatomic, retain) NSString * button1_bg;
@property (nonatomic, retain) NSString * button1_fg;
@property (nonatomic, retain) NSNumber * button1_h;
@property (nonatomic, retain) NSNumber * button1_w;
@property (nonatomic, retain) NSNumber * button1_x;
@property (nonatomic, retain) NSNumber * button1_y;
@property (nonatomic, retain) NSString * button2_bg;
@property (nonatomic, retain) NSString * button2_fg;
@property (nonatomic, retain) NSNumber * button2_h;
@property (nonatomic, retain) NSNumber * button2_w;
@property (nonatomic, retain) NSNumber * button2_x;
@property (nonatomic, retain) NSNumber * button2_y;
@property (nonatomic, retain) NSString * button3_bg;
@property (nonatomic, retain) NSString * button3_fg;
@property (nonatomic, retain) NSNumber * button3_h;
@property (nonatomic, retain) NSNumber * button3_w;
@property (nonatomic, retain) NSNumber * button3_x;
@property (nonatomic, retain) NSNumber * button3_y;
@property (nonatomic, retain) NSString * button4_bg;
@property (nonatomic, retain) NSString * button4_fg;
@property (nonatomic, retain) NSNumber * button4_h;
@property (nonatomic, retain) NSNumber * button4_w;
@property (nonatomic, retain) NSNumber * button4_x;
@property (nonatomic, retain) NSNumber * button4_y;
@property (nonatomic, retain) NSNumber * day_of_week_fri;
@property (nonatomic, retain) NSNumber * day_of_week_mon;
@property (nonatomic, retain) NSNumber * day_of_week_sat;
@property (nonatomic, retain) NSNumber * day_of_week_sun;
@property (nonatomic, retain) NSNumber * day_of_week_thu;
@property (nonatomic, retain) NSNumber * day_of_week_tue;
@property (nonatomic, retain) NSNumber * day_of_week_wed;
@property (nonatomic, retain) NSNumber * enabled;
@property (nonatomic, retain) NSString * exit_button_bg;
@property (nonatomic, retain) NSString * exit_button_fg;
@property (nonatomic, retain) NSNumber * exit_button_h;
@property (nonatomic, retain) NSNumber * exit_button_w;
@property (nonatomic, retain) NSNumber * exit_button_x;
@property (nonatomic, retain) NSNumber * exit_button_y;
@property (nonatomic, retain) NSNumber * images_together_presentation_time;
@property (nonatomic, retain) NSNumber * images_together_presentation_time_is_infinite;
@property (nonatomic, retain) NSNumber * loop_animated_images;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * num_staircases_interleaved;
@property (nonatomic, retain) NSNumber * number_of_buttons;
@property (nonatomic, retain) NSNumber * practice_configuration;
@property (nonatomic, retain) NSString * questions_per_folder;
@property (nonatomic, retain) NSNumber * randomisation_specified_seed;
@property (nonatomic, retain) NSNumber * randomisation_use_specified_seed;
@property (nonatomic, retain) NSNumber * require_next;
@property (nonatomic, retain) NSNumber * show_exit_button;
@property (nonatomic, retain) NSString * staircase_deltas;
@property (nonatomic, retain) NSString * staircase_floor_ceiling_hits;
@property (nonatomic, retain) NSString * staircase_max_level;
@property (nonatomic, retain) NSString * staircase_min_level;
@property (nonatomic, retain) NSString * staircase_num_correct_to_get_harder;
@property (nonatomic, retain) NSString * staircase_num_incorrect_to_get_easier;
@property (nonatomic, retain) NSString * staircase_num_reversals;
@property (nonatomic, retain) NSString * staircase_start_level;
@property (nonatomic, retain) NSNumber * time_between_question_mean;
@property (nonatomic, retain) NSNumber * time_between_question_plusminus;
@property (nonatomic, retain) NSNumber * use_staircase_method;
@property (nonatomic, retain) TestSequence *sequence;
@property (nonatomic, retain) User *user;

/*enum testing_method {
    dTestingMethodTogether = 0,
    dTestingMethodSequential = 1
};*/

- (int)countQuestions;

- (void)installSequenceWithURL:(NSString *)url data:(NSDictionary *)data HUD:(MBProgressHUD *)hud sema:(dispatch_semaphore_t)sema;

- (int)questions_in_folder:(NSString *)name;

- (void)copyFromConfiguration:(TestConfiguration *)configuration;

- (void)loadData:(NSDictionary *)data;

- (NSDictionary *)serialise;
@end