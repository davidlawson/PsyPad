//
//  CenteringScrollViewController.h
//  Boilerplate
//
//  Created by David Lawson on 16/02/2015.
//
//

#import <UIKit/UIKit.h>

///
///  View controller that centers a UIScrollView (that would normally be top-left).
///  Add a UIScrollView and link up its top, left, bottom and right layout constraints.
/// 
///  Listens to keyboard notifications to offset centering by keyboard height
/// 
@interface DLCenteringScrollViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *scrollViewBottom,
                                                        *scrollViewTop,
                                                        *scrollViewLeft,
                                                        *scrollViewRight;

@end
