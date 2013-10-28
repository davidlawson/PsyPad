//
//  TestLogItem.h
//  eTASM
//
//  Created by David Lawson on 13/12/12.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TestLog;

@interface TestLogItem : NSManagedObject

@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) TestLog *log;

@end
