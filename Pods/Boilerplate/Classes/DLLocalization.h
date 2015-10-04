//
//  DLLocalization.h
//  Boilerplate
//
//  Created by David Lawson on 16/02/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

///
/// `__(@"string")` can be used as a shortcut for localized strings.
///
#define __(key) [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]