//
//  TestImageButton.h
//  PsyPad
//
//  Created by David Lawson on 12/07/12.
//

@class TestSequenceImage;

@interface TestImageButton : UIButton

@property (strong, nonatomic) TestSequenceImage *dbImage;
@property (nonatomic) BOOL isAnimated;
@property (strong, nonatomic) UIImageView *animationImageView;

-(id)initWithImage:(UIImage *)image;

- (id)initWithAnimatedImage:(NSArray *)images framerate:(int)framerate loop:(BOOL)loop;
@end
