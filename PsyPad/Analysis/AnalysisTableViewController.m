//
//  AnalysisTableViewController.m
//  PsyPad
//
//  Created by David Lawson on 15/01/13.
//  Copyright (c) 2013 David Lawson. All rights reserved.
//

#import "AnalysisTableViewController.h"
#import "TestLog.h"
#import "BarChartCell.h"
#import "TestLogItem.h"
#import "Fraction.h"
#import "Mean.h"
#import "TestConfiguration.h"

@interface AnalysisTableViewController ()

@end

@implementation AnalysisTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.analysis == kReactionAnalysis)
    {
        self.reactionTimeData = [NSMutableDictionary dictionary];

        int i = 0; long count = self.log.logitems.count;
        TestLogItem *item;

        while (i < count)
        {
            while (i < count)
            {
                item = [self.log.logitems objectAtIndex:(NSUInteger)i++];

                if ([item.type isEqualToString:@"presented_image"])
                    break;
            }

            if ( ! [item.type isEqualToString:@"presented_image"])
            {
                break;
            }

            NSString *image = [item.info stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

            while (i < count)
            {
                item = [self.log.logitems objectAtIndex:(NSUInteger)i++];

                if ([item.type isEqualToString:@"reaction_time"])
                    break;
            }

            if ( ! [item.type isEqualToString:@"reaction_time"])
            {
                break;
            }

            float reaction_time = [item.info substringToIndex:item.info.length-2].floatValue;

            NSString *identifier = [[image componentsSeparatedByString:@"/"] objectAtIndex:0];

            Mean *reactionMean;
            if ([self.reactionTimeData objectForKey:identifier] != nil)
            {
                reactionMean = [self.reactionTimeData objectForKey:identifier];
            }
            else
            {
                reactionMean = [[Mean alloc] init];
                [self.reactionTimeData setObject:reactionMean forKey:identifier];
            }

            [reactionMean addValue:reaction_time];
        }
    }
    else if (self.analysis == kCorrectAnalysis)
    {
        self.correctData = [NSMutableDictionary dictionary];
        int i = 0; long count = self.log.logitems.count;
        TestLogItem *item;

        while (i < count)
        {
            while (i < count)
            {
                item = [self.log.logitems objectAtIndex:(NSUInteger)i++];

                if ([item.type isEqualToString:@"presented_image"])
                    break;
            }

            if ( ! [item.type isEqualToString:@"presented_image"])
            {
                break;
            }

            NSString *image = [item.info stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

            while (i < count)
            {
                item = [self.log.logitems objectAtIndex:(NSUInteger)i++];

                if ([item.type isEqualToString:@"button_press"])
                    break;
            }

            if ( ! [item.type isEqualToString:@"button_press"])
            {
                break;
            }

            int buttonPressed = ((NSString *)[[item.info componentsSeparatedByString:@" "] objectAtIndex:0]).intValue;

            NSString *identifier = [[image componentsSeparatedByString:@"/"] objectAtIndex:0];

            Fraction *fraction;
            if ([self.correctData objectForKey:identifier] != nil)
            {
                fraction = [self.correctData objectForKey:identifier];
            }
            else
            {
                fraction = [[Fraction alloc] init];
            }

            fraction.denominator = [NSNumber numberWithInt:fraction.denominator.intValue+1];

            if ([[[[[image componentsSeparatedByString:@"/"] objectAtIndex:1] componentsSeparatedByString:@"_"] objectAtIndex:0] intValue] == buttonPressed)
            {
                fraction.numerator = [NSNumber numberWithInt:fraction.numerator.intValue+1];
            }

            [self.correctData setObject:fraction forKey:identifier];
        }
    }
    else if (self.analysis == kPresentationsAnalysis)
    {
        self.presentationData = [NSMutableDictionary dictionary];
        int i = 0; long count = self.log.logitems.count;
        TestLogItem *item;

        while (i < count)
        {
            while (i < count)
            {
                item = [self.log.logitems objectAtIndex:(NSUInteger)i++];

                if ([item.type isEqualToString:@"presented_image"])
                    break;
            }

            if ( ! [item.type isEqualToString:@"presented_image"])
            {
                break;
            }

            NSString *image = [item.info stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

            NSString *identifier = [[image componentsSeparatedByString:@"/"] objectAtIndex:0];

            NSNumber *count;
            if ([self.presentationData objectForKey:identifier] != nil)
            {
                count = [self.presentationData objectForKey:identifier];
                [self.presentationData setObject:@(count.intValue+1) forKey:identifier];
            }
            else
            {
                count = @(1);
                [self.presentationData setObject:count forKey:identifier];
            }
        }
    }
    else if (self.analysis == kThresholdsAnalysis)
    {
        self.thresholdData = [NSMutableArray array];
        int i = 0; long count = self.log.logitems.count;
        TestLogItem *item;

        item = [self.log.logitems objectAtIndex:(NSUInteger)i++];
        NSDictionary *config = [NSJSONSerialization JSONObjectWithData:[item.info dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        int num_staircases = [(NSNumber *)[config objectForKey:@"number_of_staircases"] intValue];

        for (int j = 0; j < num_staircases; j++)
        {
            [self.thresholdData addObject:[NSMutableArray array]];
        }

        int level = 0, current_staircase = 0;
        while (i < count)
        {
            while (i < count)
            {
                item = [self.log.logitems objectAtIndex:(NSUInteger)i++];

                if ([item.type isEqualToString:@"reversal"])
                {
                    NSMutableArray *arr = [self.thresholdData objectAtIndex:(NSUInteger)current_staircase];
                    [arr addObject:@(level)];
                    continue;
                }

                if ([item.type isEqualToString:@"currentStaircase"])
                    break;
            }

            if ( ! [item.type isEqualToString:@"currentStaircase"])
            {
                break;
            }

            current_staircase = item.info.intValue;

            while (i < count)
            {
                item = [self.log.logitems objectAtIndex:(NSUInteger)i++];

                if ([item.type isEqualToString:@"presented_image"])
                    break;
            }

            if ( ! [item.type isEqualToString:@"presented_image"])
            {
                break;
            }

            NSString *image = [item.info stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

            NSString *identifier = [[image componentsSeparatedByString:@"/"] objectAtIndex:0];

            level = identifier.intValue;
        }
    }

    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.analysis == kThresholdsAnalysis) return self.thresholdData.count;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.correctData) return self.correctData.count;
    else if (self.presentationData) return self.presentationData.count;
    else if (self.reactionTimeData) return self.reactionTimeData.count;
    else if (self.thresholdData)
    {
        NSMutableArray *arr = [self.thresholdData objectAtIndex:(NSUInteger)section];
        return arr.count;
    }
    else return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.analysis == kThresholdsAnalysis) return [NSString stringWithFormat:@"Staircase %d", (int)section+1];
    return [super tableView:tableView titleForHeaderInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BarChartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BarChartCell"];
    if (self.analysis == kReactionAnalysis)
    {
        NSArray *keys = [[self.reactionTimeData allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2)
        {
            return obj1.intValue - obj2.intValue;
        }];

        float max_mean = 1;
        for (NSString *key in self.reactionTimeData)
        {
            Mean *mean = [self.reactionTimeData objectForKey:key];
            if (mean.mean > max_mean) max_mean = mean.mean;
        }

        Mean *mean = [self.reactionTimeData objectForKey:[keys objectAtIndex:(NSUInteger)indexPath.row]];
        [cell displayMean:mean.mean withMax:max_mean stdev:mean.stdev];

        cell.cellLabel.text = [keys objectAtIndex:(NSUInteger)indexPath.row];
    }
    else if (self.analysis == kCorrectAnalysis)
    {
        NSArray *keys = [[self.correctData allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2)
        {
            return obj1.intValue - obj2.intValue;
        }];

        Fraction *fraction = [self.correctData objectForKey:[keys objectAtIndex:(NSUInteger)indexPath.row]];
        [cell displayPercentage:fraction.floatValue];

        cell.cellLabel.text = [keys objectAtIndex:(NSUInteger)indexPath.row];
    }
    else if (self.analysis == kPresentationsAnalysis)
    {
        NSArray *keys = [[self.presentationData allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2)
        {
            return obj1.intValue - obj2.intValue;
        }];

        int max_count = 1;
        for (NSString *key in self.presentationData)
        {
            NSNumber *count = [self.presentationData objectForKey:key];
            if (count.intValue > max_count) max_count = count.intValue;
        }

        NSNumber *count = [self.presentationData objectForKey:[keys objectAtIndex:(NSUInteger)indexPath.row]];

        [cell displayInt:count.intValue withMax:max_count];

        cell.cellLabel.text = [keys objectAtIndex:(NSUInteger)indexPath.row];
    }
    else if (self.analysis == kThresholdsAnalysis)
    {
        NSMutableArray *arr = [self.thresholdData objectAtIndex:(NSUInteger)indexPath.section];

        int max_mean = -1;
        for (int i = 0; i < arr.count; i++)
        {
            NSNumber *num = [arr objectAtIndex:(NSUInteger)i];
            if (num.floatValue > max_mean) max_mean = num.intValue;
        }

        [cell displayInt:[[arr objectAtIndex:(NSUInteger)indexPath.row] intValue] withMax:max_mean];

        cell.cellLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row+1];
    }
    /*if (self.analysis == kGlassAnalysis || self.analysis == kRFSAnalysis || self.analysis == kGDMAnalysis)
    {
        NSArray *keys = [[self.correctnessData allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2)
        {
            return [obj1 compare:obj2];
        }];

        Fraction *fraction = [self.correctnessData objectForKey:[keys objectAtIndex:(NSUInteger)indexPath.row]];
        [cell displayPercentage:fraction.floatValue];

        cell.cellLabel.text = [keys objectAtIndex:(NSUInteger)indexPath.row];
    }*/

    return cell;
}

@end
