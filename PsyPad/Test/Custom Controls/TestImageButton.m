//
//  TestImageButton.m
//  PsyPad
//
//  Created by David Lawson on 12/07/12.
//

#import "TestImageButton.h"
#import "TestSequenceImage.h"
#import "UIView+Positioning.h"
#import "UIImage+Picker.h"

@implementation TestImageButton

- (id)init
{
    self = [super init];
    if (self)
    {
        self.adjustsImageWhenHighlighted = NO;
        self.exclusiveTouch = YES;

        self.width = 1024.0;
        self.height = 768.0;
        [self moveToX:0.0 y:0.0];
    }

    return self;
}


- (id)initWithImage:(UIImage *)image
{
    if (self = [self init])
    {
        self.isAnimated = NO;

        [self setBackgroundImage:image forState:UIControlStateNormal];
        [self setWidth:image.size.width height:image.size.height];
    }
    return self;
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    self.adjustsImageWhenHighlighted = YES;
    [super addTarget:target action:action forControlEvents:controlEvents];
}

- (id)initWithAnimatedImage:(NSArray *)images framerate:(int)framerate loop:(BOOL)loop
{
    if (self = [self init])
    {
        self.isAnimated = YES;

        NSMutableArray *animImages = [images mutableCopy];

        UIImage *firstImage = [animImages objectAtIndex:0];
        [self setWidth:firstImage.size.width height:firstImage.size.height];

        if (!loop)
        {
            UIImage *blankImage = [self imageWithColor:[firstImage colorAtPosition:CGPointMake(0,0)]];
            [animImages insertObject:blankImage atIndex:0];

            [animImages addObject:blankImage.copy];
            self.animationImageView = [[UIImageView alloc] initWithImage:blankImage];
        }
        else
        {
            self.animationImageView = [[UIImageView alloc] initWithImage:firstImage];
        }

        [self.animationImageView setWidth:firstImage.size.width height:firstImage.size.height];
        [self.animationImageView moveToX:0 y:0];
        [self addSubview:self.animationImageView];

        float ms_per_frame = framerate / 60.0;
        //float ms_per_frame = 1.0 / framerate;

        self.animationImageView.animationImages = animImages;
            self.animationImageView.animationDuration = animImages.count * ms_per_frame;
        self.animationImageView.animationRepeatCount = loop ? 0 : 1;
    }
    return self;
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (void)removeTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    self.adjustsImageWhenHighlighted = NO;
    [super removeTarget:target action:action forControlEvents:controlEvents];
}


@end
