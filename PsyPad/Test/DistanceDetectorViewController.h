//
//  DistanceDetectorViewController.h
//  eTASM2
//
//  Created by David Lawson on 25/01/13.
//  Copyright (c) 2013 David Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVCaptureSession;
@class AVCaptureVideoPreviewLayer;

@interface DistanceDetectorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (strong, nonatomic) UIImage *photo;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

- (IBAction)dismissController:(id)sender;
- (IBAction)performDistanceDetection:(id)sender;

@end
