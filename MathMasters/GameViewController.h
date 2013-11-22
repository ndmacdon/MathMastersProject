/****
 *
 * Filename:    GameViewController.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: Nov 03, 2013
 *
 * Description: ViewController: Provides common functionality (statistics tracking, tutorial launching)
 *              to each game.
 *
 ****/

#import <UIKit/UIKit.h>
#import "SessionStatisticsViewController.h"
#import "DBManager.h"
#import "TutorialViewController.h"
#import "GlobalVariables.h"
#import <AVFoundation/AVFoundation.h>


static const int sessionRounds = 5;

@interface GameViewController : UIViewController
{
    
}

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
@property(nonatomic,strong) TutorialViewController * tutorialViewController;

-(IBAction)tutorial_clicked:(id)sender;
-(void)incWinStreak;
-(void)resetStats;
-(void)logStats;
-(void)inc_total_correct;
-(void)inc_total_incorrect;
-(void)endSession;
@end
