//
//  AnalysisTableViewController.h
//  PsyPad
//
//  Created by David Lawson on 15/01/13.
//  Copyright (c) 2013 David Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestLog;

enum analysis_type {
    kReactionAnalysis,
    kCorrectAnalysis,
    kThresholdsAnalysis,
    kPresentationsAnalysis
};

@interface AnalysisTableViewController : UITableViewController

@property (nonatomic, strong) TestLog *log;
@property (nonatomic) enum analysis_type analysis;

@property (nonatomic, strong) NSMutableDictionary *reactionTimeData;

@property (nonatomic, strong) NSMutableDictionary *correctData;

@property (nonatomic, strong) NSMutableArray *thresholdData;

@property (nonatomic, strong) NSMutableDictionary *presentationData;

@end
