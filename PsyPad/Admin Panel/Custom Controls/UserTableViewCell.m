//
//  UserTableViewCell.m
//  MoViT
//
//  Created by David Lawson on 12/08/13.
//  Copyright (c) 2013 David Lawson. All rights reserved.
//

#import "UserTableViewCell.h"

@implementation UserTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)pressedDownloadButton:(id)sender
{
    if (self.downloadAction)
        self.downloadAction();
}

- (IBAction)pressedUploadButton:(id)sender
{
    if (self.uploadAction)
        self.uploadAction();
}

@end
