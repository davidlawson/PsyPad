//
//  PortraitNavigationController.m
//  Boilerplate
//
//  Created by David Lawson on 16/02/2015.
//
//

#import "DLPortraitNavigationController.h"

@interface DLPortraitNavigationController ()

@end

@implementation DLPortraitNavigationController

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
