//
//  DistanceDetectorViewController.m
//  eTASM2
//
//  Created by David Lawson on 25/01/13.
//  Copyright (c) 2013 David Lawson. All rights reserved.
//

#import "DistanceDetectorViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface DistanceDetectorViewController ()

@end

@implementation DistanceDetectorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.session = [[AVCaptureSession alloc] init];
    self.session.sessionPreset = AVCaptureSessionPresetPhoto;

    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    captureVideoPreviewLayer.frame = self.faceImageView.bounds;

    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];

    AVCaptureVideoOrientation orientation = AVCaptureVideoOrientationLandscapeLeft;
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        orientation = AVCaptureVideoOrientationLandscapeLeft;
    else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight)
        orientation = AVCaptureVideoOrientationLandscapeRight;

    captureVideoPreviewLayer.orientation = orientation;

    [self.faceImageView.layer addSublayer:captureVideoPreviewLayer];

    self.captureVideoPreviewLayer = captureVideoPreviewLayer;

    // Get all cameras in the application and find the frontal camera.
    AVCaptureDevice *frontalCamera;
    NSArray *allCameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];

    // Find the frontal camera.
    for ( int i = 0; i < allCameras.count; i++ )
    {
        AVCaptureDevice *camera = [allCameras objectAtIndex:(NSUInteger)i];

        if ( camera.position == AVCaptureDevicePositionFront )
        {
            frontalCamera = camera;
        }
    }

    [frontalCamera lockForConfiguration:nil];

    if ([frontalCamera isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
        [frontalCamera setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
    }

    if ([frontalCamera isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
        [frontalCamera setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
    }

    [frontalCamera unlockForConfiguration];

    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:frontalCamera error:&error];

    [self.session addInput:input];
    [self.session startRunning];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIDeviceOrientationIsLandscape(toInterfaceOrientation);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];

    AVCaptureVideoOrientation orientation = AVCaptureVideoOrientationLandscapeLeft;
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        orientation = AVCaptureVideoOrientationLandscapeLeft;
    else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight)
        orientation = AVCaptureVideoOrientationLandscapeRight;

    self.captureVideoPreviewLayer.orientation = orientation;

    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (IBAction)dismissController:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)performDistanceDetection:(id)sender
{
    AVCaptureStillImageOutput *stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    [self.session addOutput:stillImageOutput];

    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in stillImageOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] )
            {
                videoConnection = connection;
                break;
            }
        }

        if (videoConnection) { break; }
    }

    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];

    AVCaptureVideoOrientation orientation = AVCaptureVideoOrientationLandscapeLeft;
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        orientation = AVCaptureVideoOrientationLandscapeLeft;
    else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight)
        orientation = AVCaptureVideoOrientationLandscapeRight;

    [videoConnection setVideoOrientation:orientation];
    [videoConnection setVideoMirrored:YES];

    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error)
    {
        [self.captureVideoPreviewLayer removeFromSuperlayer];
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        self.photo = image;
        [self drawImage];

        [self.session removeOutput:stillImageOutput];
    }];
}

- (void)drawImage
{
    //self.faceImageView.image = self.photo;

    UIGraphicsBeginImageContextWithOptions(self.photo.size, YES, 0);

    CGContextRef context = UIGraphicsGetCurrentContext();

    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];

    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        CGContextTranslateCTM(context, self.photo.size.width, self.photo.size.height);
        CGContextScaleCTM(context, -1.0, -1.0);
    }

    CGContextDrawImage(context,
                       CGRectMake(0, 0, self.photo.size.width, self.photo.size.height),
                       self.photo.CGImage);

    NSDictionary *options = [NSDictionary dictionaryWithObject:CIDetectorAccuracyLow forKey:CIDetectorAccuracy];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:options];

    CIImage *image = [CIImage imageWithCGImage:self.photo.CGImage];

    int exifOrientation;

    enum {
        PHOTOS_EXIF_0ROW_TOP_0COL_LEFT          = 1, //   1  =  0th row is at the top, and 0th column is on the left (THE DEFAULT).
        PHOTOS_EXIF_0ROW_TOP_0COL_RIGHT         = 2, //   2  =  0th row is at the top, and 0th column is on the right.
        PHOTOS_EXIF_0ROW_BOTTOM_0COL_RIGHT      = 3, //   3  =  0th row is at the bottom, and 0th column is on the right.
        PHOTOS_EXIF_0ROW_BOTTOM_0COL_LEFT       = 4, //   4  =  0th row is at the bottom, and 0th column is on the left.
        PHOTOS_EXIF_0ROW_LEFT_0COL_TOP          = 5, //   5  =  0th row is on the left, and 0th column is the top.
        PHOTOS_EXIF_0ROW_RIGHT_0COL_TOP         = 6, //   6  =  0th row is on the right, and 0th column is the top.
        PHOTOS_EXIF_0ROW_RIGHT_0COL_BOTTOM      = 7, //   7  =  0th row is on the right, and 0th column is the bottom.
        PHOTOS_EXIF_0ROW_LEFT_0COL_BOTTOM       = 8  //   8  =  0th row is on the left, and 0th column is the bottom.
    };

    switch (interfaceOrientation) {
        case UIInterfaceOrientationLandscapeRight:       // Device oriented horizontally, home button on the right
            exifOrientation = PHOTOS_EXIF_0ROW_BOTTOM_0COL_RIGHT;
            break;
        case UIInterfaceOrientationLandscapeLeft:      // Device oriented horizontally, home button on the left
        default:
            exifOrientation = PHOTOS_EXIF_0ROW_TOP_0COL_LEFT;
            break;
    }

    NSDictionary *imageOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:exifOrientation] forKey:CIDetectorImageOrientation];

    NSArray *features = [detector featuresInImage:image options:imageOptions];

    for (CIFaceFeature *feature in features)
    {
        CGContextSetRGBFillColor(context, 0.0f, 0.0f, 0.0f, 0.5f);
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetLineWidth(context, 2.0f);

        CGContextAddRect(context, feature.bounds);
        CGContextDrawPath(context, kCGPathFillStroke);

        CGContextSetRGBFillColor(context, 1.0f, 0.0f, 0.0f, 0.4f);

        CGPoint leftEyePosition, rightEyePosition;

        if (feature.hasLeftEyePosition)
        {
            leftEyePosition = feature.leftEyePosition;
            [self drawFeatureInContext:context atPoint:feature.leftEyePosition];
        }

        if (feature.hasRightEyePosition)
        {
            rightEyePosition = feature.rightEyePosition;
            [self drawFeatureInContext:context atPoint:feature.rightEyePosition];
        }

        CGFloat xDist = (rightEyePosition.x - leftEyePosition.x);
        CGFloat yDist = (rightEyePosition.y - leftEyePosition.y);
        CGFloat distance = (CGFloat)sqrt((xDist * xDist) + (yDist * yDist));

        CGFloat calibration_pixel = 142;
        CGFloat calibration_distance = 30;

        self.resultsLabel.text = [NSString stringWithFormat:@"Detected distance from camera: %.5fpixels = %.5fcm", distance, (calibration_pixel*calibration_distance)/distance];

        if (feature.hasMouthPosition)
        {
            [self drawFeatureInContext:context atPoint:feature.mouthPosition];
        }
    }

    self.faceImageView.image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
}

- (void)drawFeatureInContext:(CGContextRef)context atPoint:(CGPoint)featurePoint
{
    CGFloat radius = 20.0f;
    CGContextAddArc(context, featurePoint.x, featurePoint.y, radius, 0, (CGFloat)(M_PI * 2), 1);
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)viewDidUnload
{
    [self setFaceImageView:nil];
    [self setResultsLabel:nil];
    [super viewDidUnload];
}

@end
