//
//  CenteringScrollViewController.m
//  Boilerplate
//
//  Created by David Lawson on 16/02/2015.
//
//

#import "DLCenteringScrollViewController.h"
#import "DLKeyboardObserver.h"

@interface DLCenteringScrollViewController ()

@property (nonatomic, strong) DLKeyboardObserver *keyboardObserver;

@property (nonatomic) BOOL keyboardVisible;
@property (nonatomic) CGFloat keyboardHeight;

@end

@implementation DLCenteringScrollViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        __weak typeof(self) weakSelf = self;

        self.keyboardObserver = [[DLKeyboardObserver alloc] init];
        self.keyboardObserver.keyboardChanged = ^(BOOL visible, CGFloat height)
        {
            weakSelf.keyboardVisible = visible;
            weakSelf.keyboardHeight = height;
            [weakSelf updateInsets:YES];
        };
    }
    
    return self;
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
        self.scrollViewLeft.constant = (containerSize.width - centerViewSize.width) / 2.0f;
        self.scrollViewRight.constant = self.scrollViewLeft.constant;
    }
    
    if (containerSize.height > centerViewSize.height)
    {
        self.scrollViewTop.constant = (containerSize.height - centerViewSize.height) / 2.0f;
        self.scrollViewBottom.constant = self.scrollViewTop.constant;
    }
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animated ? 0.3 : 0 animations:^{
        [weakSelf.view layoutIfNeeded];
    }];
}

@end
