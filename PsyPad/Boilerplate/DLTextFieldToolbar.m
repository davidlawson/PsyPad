//
//  DLTextFieldToolbar.m
//  Boilerplate
//
//  Created by David Lawson on 28/06/14.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "DLTextFieldToolbar.h"

@interface DLTextFieldToolbar () <UITextFieldDelegate>

@property (nonatomic, strong) UIBarButtonItem *prevButton, *nextButton, *space, *doneButton;

@end

@implementation DLTextFieldToolbar

- (id)initWithTextFields:(NSArray *)textFields
{
    self = [super init];
    if (self)
    {
        [self sizeToFit];

        self.textFields = [NSPointerArray weakObjectsPointerArray];
        for (id obj in textFields) [self.textFields addPointer:(__bridge void *)(obj)];

        self.space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace)
                                                                   target:nil
                                                                   action:nil];

        self.doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                           style:UIBarButtonItemStylePlain target:self
                                                          action:@selector(doneClicked:)];

        if (self.textFields.count > 1)
        {
            self.prevButton = [[UIBarButtonItem alloc] initWithTitle:@"Previous"
                                                               style:UIBarButtonItemStylePlain target:self
                                                              action:@selector(previousClicked:)];

            self.nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                               style:UIBarButtonItemStylePlain target:self
                                                              action:@selector(nextClicked:)];

            [self setItems:@[self.prevButton, self.nextButton, self.space, self.doneButton]];
        }
        else
        {
            [self setItems:@[self.space, self.doneButton]];
        }

        for (UITextField *textField in self.textFields)
        {
            if ([textField respondsToSelector:@selector(addTarget:action:forControlEvents:)])
                [textField addTarget:self action:@selector(beganEditing:) forControlEvents:UIControlEventEditingDidBegin];
            
            textField.inputAccessoryView = self;
            textField.delegate = self;
        }
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
    {
        if ([textField respondsToSelector:@selector(addTarget:action:forControlEvents:)])
            [textField removeTarget:self action:@selector(beganEditing:) forControlEvents:UIControlEventEditingDidBegin];

        textField.delegate = nil;
        textField.inputAccessoryView = nil;
    }
}

- (void)previousClicked:(id)previousClicked
{
    UITextField *prev = nil;
    for (UITextField *textField in self.textFields)
    {
        if (textField.isFirstResponder) break;
        prev = textField;
    }

    [prev becomeFirstResponder];
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

- (void)doneClicked:(id)doneClicked
{
    for (UITextField *textField in self.textFields)
    {
        if (textField.isFirstResponder)
        {
            [textField resignFirstResponder];
            break;
        }
    }
}

- (void)beganEditing:(UITextField *)field
{
    self.nextButton.enabled = [self.textFields pointerAtIndex:self.textFields.count - 1] != (__bridge void *)field;
    self.prevButton.enabled = [self.textFields pointerAtIndex:0] != (__bridge void *)field;
}

@end