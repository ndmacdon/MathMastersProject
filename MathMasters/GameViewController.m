/****
 *
 * Filename:    GameViewController.m
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

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController {

}

@synthesize totalCorrect,
    totalIncorrect,
    highestNumber,
    userAnswer,
    consecutiveWins,
    winStreak,
    optionsSingle,
    prepend,
    startTime,
    endTime,
    runningTime,
    tutorialViewController,
    arrayMusic;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Launch this game's tutorial according to its class name:
-(IBAction)tutorial_clicked:(id)sender {
    NSString *myName = [NSString stringWithFormat:@"%@%@", prepend, NSStringFromClass([self class])];
    self.tutorialViewController = [[TutorialViewController alloc]init];
    self.tutorialViewController.currentTutorial = myName;
    [self.navigationController pushViewController:self.tutorialViewController animated:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [optionsSingle.audioPlayer stop];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.optionsSingle = [GlobalVariables singleObj]; // Grab the global options handle...

}
-(void)viewDidAppear:(BOOL)animated
{
    [self set_music_array];
    [self play_sound];
}

// initializes array with music
-(void)set_music_array
{
    arrayMusic = [[NSMutableArray alloc]init];
    [arrayMusic addObject:[[NSBundle mainBundle]pathForResource:@"classicalmusic" ofType:@"m4a"]];
    [arrayMusic addObject:[[NSBundle mainBundle]pathForResource:@"classicalmusic1" ofType:@"m4a"]];
    [arrayMusic addObject:[[NSBundle mainBundle]pathForResource:@"classicalmusic2" ofType:@"mp3"]];
    
}

// used to play background music
-(void)play_sound
{
    // background music added!
    int randomNumber = arc4random() % 3;
    
    optionsSingle.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[arrayMusic objectAtIndex:randomNumber]] error:NULL];
    optionsSingle.audioPlayer.numberOfLoops = -1;  // played infinite amount of times
    [optionsSingle.audioPlayer setVolume:optionsSingle.musicVolumeControl];
    [optionsSingle.audioPlayer play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// End the current session and load the Session Statistics Screen:
-(void)endSession {
    
    [self logStats]; // Log the stats for this session...
    
    // Initialize the sessionStatisticsViewController and pop it onto the Navigation Stack:
    self.sessionStatisticsViewController = [[SessionStatisticsViewController alloc] init];
    self.sessionStatisticsViewController.completionTime = self.runningTime;
    [self.navigationController pushViewController:self.sessionStatisticsViewController animated:TRUE];
}

// Increase the current streak:
-(void)incWinStreak {
    self.winStreak++;
    
    // IF winStreak is the longest set of consecutiveWins:
    if (self.winStreak > self.consecutiveWins) {
        self.consecutiveWins = self.winStreak;
    }
    
    // IF guessed is the highest encountered number:
    if (self.userAnswer > self.highestNumber) {
        self.highestNumber = self.userAnswer;
    }
}

// Break the current winStreak:
-(void)breakWinStreak {

    self.winStreak = 0; // Reset the current winStreak...
}



// Reset the stored statistics for a new session:
-(void)resetStats {
    totalCorrect = 0;
    totalIncorrect = 0;
    highestNumber = 0;
    winStreak = 0;
    consecutiveWins = 0;
}

// Log the statistics for current session:
-(void)logStats {
    self.endTime = [NSDate date]; // Load current time into endTime...
    runningTime = [endTime timeIntervalSinceDate:startTime]; // Calculate the difference in seconds...
    
    // Log the session results:
    [[DBManager getSharedInstance] logStatsFor:
     [NSString stringWithFormat:@"%@%@", prepend, NSStringFromClass([self class])]
                                      withDate:startTime
                                      withUser:optionsSingle.currentUser
                                 sessionLength:runningTime
                               consecutiveWins:consecutiveWins
                                          wins:totalCorrect
                                        losses:totalIncorrect
                                       highest:highestNumber];
}

// Increment totalCorrect:
-(void)inc_total_correct {
    totalCorrect++;
    [self incWinStreak];
}

-(void)inc_total_incorrect {
    totalIncorrect++;
    [self breakWinStreak];
}
// play ta da sound, ( SOUND EFFECT )
-(void)play_done_sound
{
    NSString * done_effect = [[NSBundle mainBundle]pathForResource:@"taDa" ofType:@"mp3"];
    self.optionsSingle.soundEffectsPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:done_effect] error:NULL];
    self.optionsSingle.soundEffectsPlayer.numberOfLoops = 0;
    [self.optionsSingle.soundEffectsPlayer setVolume:self.optionsSingle.soundeffectVolumeControl];
    [self.optionsSingle.soundEffectsPlayer play];
}

@end
