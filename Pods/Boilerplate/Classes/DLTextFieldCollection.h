//
//  DLTextFieldCollection.h
//  Boilerplate
//
//  Created by David Lawson on 22/03/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>

///
///  Handles the keyboard 'return' button, moving 
///  through text fields, calling the provided block 
///  when pressing 'return' on the last field. 
///  Works with both `UITextField` and `UITextView`.
/// 
///  Example usage:
///
///    // @property (nonatomic, retain) DLTextFieldCollection *collection;
///    self.collection = [[DLTextFieldCollection alloc] initWithTextFields:@[...]];
///    self.collection.finalReturnBlock = ^{ /* called when return pressed on last text field */ };
///
@interface DLTextFieldCollection : NSObject

// Does not retain the text fields
@property (nonatomic, strong) NSPointerArray *textFields;

///  
///  This block is called when the user presses 'Next'
///  on the keyboard in the final UITextView
///  
@property (nonatomic, copy) void (^finalReturnBlock)(void);

- (id)initWithTextFields:(NSArray *)textFields;

@end
