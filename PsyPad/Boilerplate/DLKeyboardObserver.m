//
//  DLKeyboardObserver.m
//  Boilerplate
//
//  Created by David Lawson on 23/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "DLKeyboardObserver.h"

@interface DLKeyboardObserver ()

@property (nonatomic, strong) NSObject *keyboardShowObserver;
@property (nonatomic, strong) NSObject *keyboardChangeObserver;
@property (nonatomic, strong) NSObject *keyboardHideObserver;

@property (nonatomic) BOOL keyboardVisible;
@property (nonatomic) CGFloat keyboardHeight;

@end

@implementation DLKeyboardObserver

- (instancetype)init
{
    if (self = [super init])
    {
        __weak typeof(self) weakSelf = self;
        
        void (^showBlock)(NSNotification *) = ^(NSNotification *n)
        {
            weakSelf.keyboardVisible = true;
            CGRect keyboardFrame = [n.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
            weakSelf.keyboardHeight = keyboardFrame.size.height;
            weakSelf.keyboardChanged(weakSelf.keyboardVisible, weakSelf.keyboardHeight);
        };
        
        void (^changeBlock)(NSNotification *) = ^(NSNotification *n)
        {
            CGRect keyboardFrame = [n.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
            if (weakSelf.keyboardHeight != keyboardFrame.size.height)
            {
                weakSelf.keyboardHeight = keyboardFrame.size.height;
                weakSelf.keyboardChanged(weakSelf.keyboardVisible, weakSelf.keyboardHeight);
            }
        };
        
        void (^hideBlock)(NSNotification *) = ^(NSNotification *n)
        {
            weakSelf.keyboardVisible = false;
            weakSelf.keyboardChanged(weakSelf.keyboardVisible, weakSelf.keyboardHeight);
        };
        
        self.keyboardShowObserver =
        [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:showBlock];
        
        self.keyboardChangeObserver =
        [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:changeBlock];
        
        self.keyboardHideObserver =
        [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:hideBlock];
    }
    
    return self;
}

- (void)dealloc
{
    if (self.keyboardShowObserver)
        [[NSNotificationCenter defaultCenter] removeObserver:self.keyboardShowObserver];
    
    if (self.keyboardChangeObserver)
        [[NSNotificationCenter defaultCenter] removeObserver:self.keyboardChangeObserver];
    
    if (self.keyboardHideObserver)
        [[NSNotificationCenter defaultCenter] removeObserver:self.keyboardHideObserver];
}

@end
