//
//  TestButton.h
//  PsyPad
//
//  Created by David Lawson on 12/12/12.
//

@interface TestButton : UIButton

@property (nonatomic) int number;

-(id)initWithText:(NSString *)text;

- (id)initWithNumber:(int)number text:(NSString *)text bg:(UIColor *)bg fg:(UIColor *)fg x:(int)x y:(int)y width:(int)width height:(int)height img:(UIImage *)img;

@end
