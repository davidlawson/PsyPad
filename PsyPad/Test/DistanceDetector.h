//
// Created by david on 27/02/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import <Foundation/Foundation.h>

@class AVCaptureSession;
@class AVCaptureVideoPreviewLayer;
@class AVCaptureStillImageOutput;
@class AVCaptureConnection;
@class TestViewController;

@interface DistanceDetector : NSObject

@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (strong, nonatomic) AVCaptureConnection *videoConnection;
@property (strong, nonatomic) UIImage *photo;

- (void)takePhoto:(TestViewController *)delegate question:(int)question;

- (void)done;
@end
