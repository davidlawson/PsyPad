//
//  ConfigurationTableViewCell.h
//  PsyPad
//
//  Created by David Lawson on 16/04/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigurationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;


@end
