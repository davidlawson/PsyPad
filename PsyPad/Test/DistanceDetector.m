//
// Created by david on 27/02/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import "DistanceDetector.h"
#import "TestViewController.h"
#import "AppDelegate.h"

@implementation DistanceDetector

- (id)init
{
    if (self = [super init])
    {
        self.session = [[AVCaptureSession alloc] init];
        self.session.sessionPreset = AVCaptureSessionPresetHigh;

        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];

        AVCaptureVideoOrientation orientation = AVCaptureVideoOrientationLandscapeLeft;
        if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
            orientation = AVCaptureVideoOrientationLandscapeLeft;
        else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight)
            orientation = AVCaptureVideoOrientationLandscapeRight;

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

        if ([frontalCamera isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus])
        {
            [frontalCamera setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        }

        if ([frontalCamera isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure])
        {
            [frontalCamera setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
        }

        if ([frontalCamera isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance])
        {
            [frontalCamera setWhiteBalanceMode:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance];
        }

        [frontalCamera unlockForConfiguration];

        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:frontalCamera error:&error];

        if (input)
        {
            [self.session addInput:input];
            [self.session startRunning];

            // output

            self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
            [self.session addOutput:self.stillImageOutput];

            self.videoConnection = nil;
            for (AVCaptureConnection *connection in self.stillImageOutput.connections)
            {
                for (AVCaptureInputPort *port in [connection inputPorts])
                {
                    if ([[port mediaType] isEqual:AVMediaTypeVideo] )
                    {
                        self.videoConnection = connection;
                        break;
                    }
                }

                if (self.videoConnection) { break; }
            }

            [self.videoConnection setVideoOrientation:orientation];
            [self.videoConnection setVideoMirrored:YES];
        }
    }

    return self;
}

- (void)takePhoto:(TestViewController *)delegate question:(int)question
{
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:self.videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error)
    {
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];

        //[imageData writeToURL:[self createNewFile] atomically:YES];

        UIImage *image = [[UIImage alloc] initWithData:imageData];
        self.photo = image;
        NSString *result = [self performDistanceDetection];

        //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);

        if (result)
        {
            [delegate distanceDetectionPerformed:[NSString stringWithFormat:@"Question %d: %@", question, result]];
        }

        //[self.session removeOutput:stillImageOutput];
    }];
}

/*- (NSURL *)createNewFile
{
    NSURL *documentsDirectory = [[APP_DELEGATE applicationDocumentsDirectory] URLByAppendingPathComponent:@"Images"];
    NSString *templateString = [NSString stringWithFormat:@"%@/XXXXXX", [documentsDirectory path]];

    char template[templateString.length + 1];
    strcpy(template, [templateString cStringUsingEncoding:NSASCIIStringEncoding]);
    char *filename = mktemp(template);

    NSString *path = [NSString stringWithCString:filename encoding:NSASCIIStringEncoding];

    NSURL *newURL = [NSURL fileURLWithPath:[path stringByAppendingString:@".jpg"]];

    [[NSFileManager defaultManager] createFileAtPath:newURL.path contents:nil attributes:nil];

    return newURL;
}*/

- (void)done
{
    [self.session removeOutput:self.stillImageOutput];
}

- (NSString *)performDistanceDetection
{
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];

    #warning accuracy low
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
        CGPoint leftEyePosition, rightEyePosition, mouthPosition;

        if (feature.hasLeftEyePosition && feature.hasRightEyePosition && feature.hasMouthPosition)
        {
            leftEyePosition = feature.leftEyePosition;
            rightEyePosition = feature.rightEyePosition;
            mouthPosition = feature.mouthPosition;

            //CGFloat xDist = (rightEyePosition.x - leftEyePosition.x);
            //CGFloat yDist = (rightEyePosition.y - leftEyePosition.y);
            //CGFloat distance = (CGFloat)sqrt((xDist * xDist) + (yDist * yDist));

            //CGFloat calibration_pixel = 142;
            //CGFloat calibration_distance = 30;

            //return [NSString stringWithFormat:@"Detected distance from camera: %.5fpixels = %.5fcm", distance, (calibration_pixel*calibration_distance)/distance];

            return [NSString stringWithFormat:@"Detected facial features: left eye %.5f/%.5f, right eye: %.5f/%.5f, mouth: %.5f/%.5f", leftEyePosition.x, leftEyePosition.y, rightEyePosition.x, rightEyePosition.y, mouthPosition.x, mouthPosition.y];
        }
    }

    return nil;
}

@end