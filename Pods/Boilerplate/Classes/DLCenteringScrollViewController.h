//
//  CenteringScrollViewController.h
//  Boilerplate
//
//  Created by David Lawson on 16/02/2015.
//
//

#import <UIKit/UIKit.h>

@interface DLCenteringScrollViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *scrollViewBottom,
                                                        *scrollViewTop,
                                                        *scrollViewLeft,
                                                        *scrollViewRight;

@end
