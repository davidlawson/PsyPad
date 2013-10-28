//
//  TickTableViewCell.h
//  PsyPad
//
//  Created by David Lawson on 6/12/12.
//
//  Used for prototype table view cells (not static cells)
//

#import <UIKit/UIKit.h>

@interface TickTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *altTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *altDetailTextLabel;
@property (strong, nonatomic) IBOutlet UIImageView *altImageView;

-(void)styleCellSelected;

-(void)styleCellNormal;
@end
