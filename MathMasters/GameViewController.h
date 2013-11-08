//
//  GameViewController.h
//  MathMasters
//
//  Created by Kristina Mishina on 13-11-07.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionStatisticsViewController.h"
#import "DBManager.h"
#import "GlobalVariables.h"

@interface GameViewController : UIViewController

@property (nonatomic,strong) NSDate *endTime;
@property (nonatomic,strong) NSDate *startTime;
@property (nonatomic) NSInteger runningTime;
@property (nonatomic) NSInteger totalIncorrect;
@property (nonatomic) NSInteger highestNumber;
@property (nonatomic) NSInteger consecutiveWins;
@property (nonatomic) NSInteger userAnswer;
@property (nonatomic) NSInteger winStreak;
@property (nonatomic) NSInteger totalCorrect;
@property (nonatomic) NSString* prepend;
@property(nonatomic, strong) SessionStatisticsViewController * sessionStatisticsViewController;
@property (nonatomic, strong) GlobalVariables *optionsSingle;  // used to access globalDifficultyLevel

-(void)incWinStreak;
-(void)resetStats;
-(void)logStats;
-(void)add_total_correct;
-(void)endSession;
@end
