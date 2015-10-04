//
//  DLUserAccount.h
//  Boilerplate
//
//  Created by David Lawson on 14/05/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

///  
///  Ensure your user model implements this protocol
///  so it can be used with the DLServerManager
///  
@protocol DLUserAccount

- (BOOL)loggedIn;
- (NSString *)email;
- (NSString *)authToken;

///  
///  Called when the user successfully logs in
///  
- (void)loggedInWithEmail:(NSString *)email authToken:(NSString *)authToken;

///  
///  Called when the user successfully logs out
///  
- (void)loggedOut;

@end