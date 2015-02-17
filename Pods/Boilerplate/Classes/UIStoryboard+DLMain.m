//
//  UIStoryboard+DLMain.m
//  Boilerplate
//
//  Created by David Lawson on 16/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "UIStoryboard+DLMain.h"

@implementation UIStoryboard (DLMain)

+ (UIStoryboard *)mainStoryboard
{
    return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

@end
