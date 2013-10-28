//
//  TextFieldTableViewCell.h
//  PsyPad
//
//  Created by David Lawson on 4/12/12.
//
//  Used for prototype table view cells (not static cells)
//

#import <UIKit/UIKit.h>

@interface TextFieldTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *rowLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
