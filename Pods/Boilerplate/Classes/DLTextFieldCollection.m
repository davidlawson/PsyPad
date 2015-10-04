//
//  DLTextFieldCollection.m
//  Boilerplate
//
//  Created by David Lawson on 22/03/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "DLTextFieldCollection.h"

@interface DLTextFieldCollection () <UITextFieldDelegate>

@end

@implementation DLTextFieldCollection

- (id)initWithTextFields:(NSArray *)textFields
{
    self = [super init];
    if (self)
    {
        self.textFields = [NSPointerArray weakObjectsPointerArray];
        for (id obj in textFields) [self.textFields addPointer:(__bridge void *)(obj)];
        
        for (UITextField *textField in self.textFields)
            textField.delegate = self;
    }
    
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self nextClicked:nil];
    
    if ([textField isFirstResponder] && self.finalReturnBlock)
        self.finalReturnBlock();
    
    return NO;
}

- (void)dealloc
{
    for (UITextField *textField in self.textFields)
        textField.delegate = nil;
}

- (void)nextClicked:(id)nextClicked
{
    UITextField *prev = nil;
    for (UITextField *textField in self.textFields)
    {
        if (prev.isFirstResponder)
        {
            [textField becomeFirstResponder];
            break;
        }
        
        prev = textField;
    }
}

@end
