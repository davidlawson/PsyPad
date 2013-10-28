//
//  SliderTableViewCell.h
//  PsyPad
//
//  Created by David Lawson on 5/12/12.
//
//  Used for prototype slider table view cells (not static cells)
//

#import <UIKit/UIKit.h>

@interface SliderTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *value;
@property (strong, nonatomic) IBOutlet UISlider *slider;

@end
