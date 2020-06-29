//
//  DLTextFieldToolbar.h
//  Boilerplate
//
//  Created by David Lawson on 28/06/14.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>

///  
///  Toolbar with [next], [previous] and [done] buttons. Works
///  with UITextFields and UITextViews. Automatically assigns
///  delegate & inputAccessoryView.
///
///  Example usage:
///
///    DLTextFieldToolbar *toolbar = [[DLTextFieldToolbar alloc] initWithTextFields:@[...]];
///    toolbar.finalReturnBlock = ^{ /* called when return pressed on last text field */ };
///  
@interface DLTextFieldToolbar : UIToolbar

// Does not retain the text fields
@property (nonatomic, strong) NSPointerArray *textFields;

///  
///  This block is called when the user presses 'Next'
///  on the keyboard in the final UITextView
///  
@property (nonatomic, copy) void (^finalReturnBlock)(void);

- (id)initWithTextFields:(NSArray *)textFields;

@end