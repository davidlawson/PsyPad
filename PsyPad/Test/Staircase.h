//
// Created by david on 7/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import <Foundation/Foundation.h>

@interface Staircase : NSObject

@property (nonatomic) int id;
@property (nonatomic) int currentReversal;
@property (nonatomic) int maxReversals;
@property (nonatomic) int lastReversalType; // 0 down, 1 up
@property (nonatomic) int currentLevel;
@property (nonatomic) int numHitsFloor;
@property (nonatomic) int numHitsCeiling;
@property (nonatomic) int numTimesCorrect;
@property (nonatomic) int numTimesCorrectToGetHarder;
@property (nonatomic) int numTimesIncorrect;
@property (nonatomic) int numTimesIncorrectToGetEasier;
@property (nonatomic) int floorCeilingHits;
@property (nonatomic) int minLevel;
@property (nonatomic) int maxLevel;

@property (strong, nonatomic) NSMutableArray *deltaValues;

@end
