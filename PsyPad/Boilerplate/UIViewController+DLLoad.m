//
//  UIViewController+DLLoad.m
//  Pods
//
//  Created by David Lawson on 23/02/2015.
//
//

#import "UIViewController+DLLoad.h"
#import "UIStoryboard+DLMain.h"

@implementation UIViewController (DLLoad)

+ (instancetype)loadFromMainStoryboard
{
    return [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

@end
