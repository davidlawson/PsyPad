//
//  NSURL+CommonURLs.m
//  PsyPad
//
//  Created by David Lawson on 17/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "NSURL+CommonURLs.h"

@implementation NSURL (CommonURLs)

+ (NSURL *)documentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
