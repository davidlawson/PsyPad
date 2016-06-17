//
//  TestButton.m
//  PsyPad
//
//  Created by David Lawson on 12/12/12.
//

#import "TestButton.h"
#import "UIView+Positioning.h"

@implementation TestButton

- (id)initWithText:(NSString *)text
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = BUTTON_BG_COLOR;
        [self setTitle:text forState:UIControlStateNormal];
        [self setTitleColor:BUTTON_TEXT_COLOR forState:UIControlStateNormal];
        self.titleLabel.font = BUTTON_TEXT_FONT;
        self.exclusiveTouch = YES;

        //CGSize textSize = [text sizeWithFont:self.titleLabel.font];
        //[self setWidth:textSize.width+BUTTON_PADDING_LR height:textSize.height+BUTTON_PADDING_TB];
    }

    return self;
}

- (id)initWithNumber:(int)number text:(NSString *)text bg:(UIColor *)bg fg:(UIColor *)fg x:(int)x y:(int)y width:(int)width height:(int)height img:(UIImage *)img
{
    if (self = [self initWithText:text])
    {
        self.number = number;
        self.backgroundColor = bg;
        [self setTitleColor:fg forState:UIControlStateNormal];
        [self setBackgroundImage:img forState:UIControlStateNormal];
        [self setWidth:width height:height];
        [self moveToX:x y:y];
    }

    return self;
}

#warning this might not obey the configuration

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    self.backgroundColor = highlighted ? BUTTON_HIGHLIGHTED_COLOR : BUTTON_BG_COLOR;
}


@end