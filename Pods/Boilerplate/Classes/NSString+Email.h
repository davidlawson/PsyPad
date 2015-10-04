//
//  NSString+Email.h
//  Boilerplate
//
//  Created by David Lawson on 22/03/2015.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Email)

///
///  Simple valid email regex test
///
///  @return YES is the email is valid
///
- (BOOL)isValidEmail;

@end
