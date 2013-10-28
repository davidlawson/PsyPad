//
//  TestSequenceImage.h
//  eTASM
//
//  Created by David Lawson on 4/12/12.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TestSequenceFolder;

@interface TestSequenceImage : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * animated_images;
@property (nonatomic, retain) TestSequenceFolder *folder;
@property (nonatomic, retain) NSNumber *is_animated;
@property (nonatomic, retain) NSNumber *start;
@property (nonatomic, retain) NSNumber *length;

- (UIImage *)image;

- (NSArray *)images;
@end
