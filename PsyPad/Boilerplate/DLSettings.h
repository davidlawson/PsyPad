//
//  DLSettings.h
//  Boilerplate
//
//  Created by David Lawson on 5/03/15.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>

///  
///  Contains application settings to customise the way
///  the Boilerplate works with your app
///  
@interface DLSettings : NSObject

@property (nonatomic) Class databaseManagerClass;

+ (DLSettings *)sharedSettings;

@end