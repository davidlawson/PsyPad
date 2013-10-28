//
//  TestConfigSubTableViewController.h
//  PsyPad
//
//  Created by David Lawson on 12/02/12.
//

@class TestSequence;
@class TestSequenceFolder;
@class TestSequenceImage;
@class TestConfiguration;

@interface TestConfigSubTableViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *image_name;
@property (weak, nonatomic) IBOutlet UIImageView *image_view;

@property (strong, nonatomic) id parentController;

@property (strong, nonatomic) TestSequence *sequence;
@property (strong, nonatomic) TestSequenceFolder *selectedFolder;
@property (strong, nonatomic) TestSequenceImage *selectedImage;

@end
