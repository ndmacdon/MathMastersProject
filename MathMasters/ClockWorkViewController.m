/****
 *
 * Filename:    ClockWorkViewController.m
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: Nov 07, 2013
 *
 * Description: ViewController: Asks players to correctly interpret the current time
 *                              displayed on an analog clock face.
 *
 ****/
#import "ClockWorkViewController.h"



@implementation ClockWorkViewController {
    int hourGuessed;
    int minuteGuessed;
    int correctHour;
    int correctMinute;
    int hourGuessedz;
    int minuteGuessedz;
    int minTimeUnit;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}


-(void)viewWillAppear:(BOOL)animated {
    BOOL viewed = FALSE; // Has the current user ever viewed this tutorial?
    NSString *myName;
    
    // If difficulty is Normal: add a prefix to our classname.
    if(self.optionsSingle.globalDifficultyLevel == 1) {
        self.prepend = @"";
        minTimeUnit = 15;
    }
    // ELSE: difficulty is Hard.
    else {
        self.prepend = @"Hard";
        minTimeUnit = 5;
    }
    
    myName = [NSString stringWithFormat:@"%@%@", self.prepend, NSStringFromClass([self class])];
    
    // Check if user has viewed this tutorial:
    viewed = [[DBManager getSharedInstance]hasCompletedTutorial:self.optionsSingle.currentUser tutorial:myName];
    
    // IF tutorial NOT viewed yet:
    if (!viewed) {
        // Mark this tutorial as completed for the current user:
        [[DBManager getSharedInstance]completeTutorial:self.optionsSingle.currentUser tutorial:myName];
        
        // Show the tutorial:
        [self tutorial_clicked:self];
    }
    
    [self nextTime]; // Randomize the displayed time...
    
    [self initializeGame]; // Setup the game for play...
}

// Randomize correct hour/minute and set clock hands accordingly:
-(void)nextTime
{
    correctHour = arc4random() % 12 + 1;                    // Set the correct hour
    correctMinute = arc4random() % 60 + 1;                  // Set the correct minute
    
    // Force minute hand to a multiple of minTimeUnit (0,15,30,45 if minTimeUnit is 15):
    correctMinute = correctMinute - (correctMinute % minTimeUnit);
    
    float hourAngle = ((float)correctHour / 12.0f) * 2 * M_PI;      // Hours in radians.
    float minuteAngle = ((float)correctMinute / 60.0f) * 2 * M_PI;  // Minutes in radians.
    
    hourHand.transform = CGAffineTransformMakeRotation(0);
    minuteHand.transform = CGAffineTransformMakeRotation(0);
    
    hourHand.transform = CGAffineTransformMakeRotation(hourAngle);
    minuteHand.transform = CGAffineTransformMakeRotation(minuteAngle);
}

// Set number of rows for each column in the TimePicker:
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSUInteger numRows = 0;
    
    if (component == 0) {
        numRows = 12;
    }

    else if (component == 1) {
        numRows = 1;
    }
    
    else if (component == 2) {
        numRows = 60 / minTimeUnit;
    }
    
    
    return numRows;
}
/*
-(IBAction)play_scroll_sound
{
    NSString * done_effect = [[NSBundle mainBundle]pathForResource:@"scroll" ofType:@"m4a"];
    self.optionsSingle.soundEffectsPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:done_effect] error:NULL];
    self.optionsSingle.soundEffectsPlayer.numberOfLoops = -1;
    [self.optionsSingle.soundEffectsPlayer setVolume:self.optionsSingle.soundeffectVolumeControl];
    if(temp_number == 0)
    {
         [self.optionsSingle.soundEffectsPlayer play];
    }
    if(temp_number == 1)
    {
         [self.optionsSingle.soundEffectsPlayer play];
    }
    if(temp_number ==2)
    {
         [self.optionsSingle.soundEffectsPlayer play];
    }
}
*/

// Read the guessed time from the TimePicker:
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    
    // Set the hour or minute guessed:
    if (component == 0) { hourGuessed = row + 1; }
    else if (component == 2) { minuteGuessed = row * minTimeUnit; }
    
    self.userAnswer = hourGuessed * 100 + minuteGuessed;
}


// Set the number of components for each column of the TimePicker:
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView
             attributedTitleForRow:(NSInteger)row
                      forComponent:(NSInteger)component {
    
    NSString * text;
    NSMutableAttributedString *as;
    
    // Hour Column:
    if (component == 0) {
        text = [NSString stringWithFormat:@"%d", row+1];
        
        as = [[NSMutableAttributedString alloc]initWithString:text];
        
        NSMutableParagraphStyle *mutParaStyle = [[NSMutableParagraphStyle alloc] init];
        
        mutParaStyle.alignment = NSTextAlignmentCenter;
        
        [as addAttribute:NSParagraphStyleAttributeName
                   value:mutParaStyle
                   range:NSMakeRange(0,[text length])];
    }
    
    // ':' Column...
    else if (component == 1) {
        text = [NSString stringWithFormat:@":"];
        
        as = [[NSMutableAttributedString alloc]initWithString:text];
        
        NSMutableParagraphStyle *mutParaStyle=[[NSMutableParagraphStyle alloc] init];
        
        mutParaStyle.alignment = NSTextAlignmentCenter;
        
        [as addAttribute:NSParagraphStyleAttributeName
                   value:mutParaStyle
                   range:NSMakeRange(0,[text length])];
    }
    
    // Minute Column:
    else if (component == 2) {
        
        if(row == 0){ text = [NSString stringWithFormat:@"00"]; }
        else { text = [NSString stringWithFormat:@"%d", row * minTimeUnit]; }
        
        as = [[NSMutableAttributedString alloc]initWithString:text];
        
        NSMutableParagraphStyle *mutParaStyle=[[NSMutableParagraphStyle alloc] init];
        
        mutParaStyle.alignment = NSTextAlignmentCenter;
        
        [as addAttribute:NSParagraphStyleAttributeName
                   value:mutParaStyle
                   range:NSMakeRange(0,[text length])];
    }

    return as;
}

// Set number of TimePicker columns:
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// Set width of columns in TimePicker:
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    int sectionWidth;
    
    switch (component) {
        case 0: {
            sectionWidth = 100;
            break;
        }
        
        case 1: {
            sectionWidth = 45;
            break;
        }
        
        case 2: {
            sectionWidth = 100;
            break;
        }
    }
    
    return sectionWidth;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// Check the user's answer against the correct answer:
- (IBAction)checkAnswer:(id)sender {
    
    if(hourGuessed == correctHour && minuteGuessed == correctMinute) {
        [self play_done_sound];
        
        resultLabel.text = [NSString stringWithFormat:@"Correct !!!"];
        
        [self inc_total_correct]; // add one to total correct and increase the winStreak.
        
        // IF user completes 5 rounds: Record Stats and end the game
        if(self.totalCorrect == sessionRounds)
        {
            [self endSession];
            
            // The sessionStatistics view will return to this line if the user selected retry...
        }
        else {
            [self nextTime];  // move hands and set new answer
        }
    }
    else {
        resultLabel.text = [NSString stringWithFormat:@"Please try Again !!!"];
        [self inc_total_incorrect];
    }
}

// Setup for a play session:
-(void)initializeGame {
    self.startTime = [NSDate date]; // Load the current time into startTime...
    
    // create UIPickerView
    //UIPickerView *myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 650, 768, 216)];
    UIPickerView *myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, pickerFrame.frame.size.width, pickerFrame.frame.size.height)];
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    
    [pickerFrame addSubview:myPickerView];
    [self resetStats];
}

@end




