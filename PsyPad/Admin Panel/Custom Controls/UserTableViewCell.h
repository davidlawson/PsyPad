//
//  UserTableViewCell.h
//  MoViT
//
//  Created by David Lawson on 12/08/13.
//  Copyright (c) 2013 David Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTextLabel;

@property (copy, nonatomic) void (^downloadAction)(void);
@property (copy, nonatomic) void (^uploadAction)(void);

- (IBAction)pressedDownloadButton:(id)sender;
- (IBAction)pressedUploadButton:(id)sender;


@end
