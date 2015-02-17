//
//  CenteringScrollViewController.m
//  Boilerplate
//
//  Created by David Lawson on 16/02/2015.
//
//

#import "DLCenteringScrollViewController.h"

@interface DLCenteringScrollViewController ()

@property (nonatomic, strong) NSObject *keyboardShowObserver,
                                       *keyboardChangeObserver,
                                       *keyboardHideObserver;

@property (nonatomic) BOOL keyboardVisible;
@property (nonatomic) CGFloat keyboardHeight;

@end

@implementation DLCenteringScrollViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        __weak typeof(self) weakSelf = self;
        
        void (^showBlock)(NSNotification *) = ^(NSNotification *n)
        {
            weakSelf.keyboardVisible = true;
            CGRect keyboardFrame = [n.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
            keyboardFrame = [weakSelf.view convertRect:keyboardFrame fromView:weakSelf.view.window];
            weakSelf.keyboardHeight = keyboardFrame.size.height;
            [weakSelf updateInsets:YES];
        };
        
        void (^changeBlock)(NSNotification *) = ^(NSNotification *n)
        {
            CGRect keyboardFrame = [n.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
            keyboardFrame = [weakSelf.view convertRect:keyboardFrame fromView:weakSelf.view.window];
            weakSelf.keyboardHeight = keyboardFrame.size.height;
            [weakSelf updateInsets:YES];
        };
        
        void (^hideBlock)(NSNotification *) = ^(NSNotification *n)
        {
            weakSelf.keyboardVisible = false;
            [weakSelf updateInsets:YES];
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
        [[NSNotificationCenter defaultCenter] removeObserver:self.keyboardShowObserver];
    
    if (self.keyboardHideObserver)
        [[NSNotificationCenter defaultCenter] removeObserver:self.keyboardShowObserver];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.view layoutIfNeeded];
    [self updateInsets:NO];
}

- (void)updateInsets:(BOOL)animated
{
    CGSize containerSize = self.view.frame.size;
    CGSize centerViewSize = self.scrollView.contentSize;
    
    self.scrollViewBottom.constant = 0;
    self.scrollViewTop.constant = 0;
    self.scrollViewLeft.constant = 0;
    self.scrollViewRight.constant = 0;
    
    if (self.keyboardVisible)
    {
        self.scrollViewBottom.constant = self.keyboardHeight;
        containerSize.height -= self.keyboardHeight;
    }
    
    if (containerSize.width > centerViewSize.width)
    {
        self.scrollViewLeft.constant = (containerSize.width - centerViewSize.width) / 2.0;
        self.scrollViewRight.constant = self.scrollViewLeft.constant;
    }
    
    if (containerSize.height > centerViewSize.height)
    {
        self.scrollViewTop.constant = (containerSize.height - centerViewSize.height) / 2.0;
        self.scrollViewBottom.constant = self.scrollViewTop.constant;
    }
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animated ? 0.3 : 0 animations:^{
        [weakSelf.view layoutIfNeeded];
    }];
}

@end
