//
//  ClockWorkViewController.m
//  MathMasters
//
//  Created by Kristina Mishina on 13-11-08.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import "ClockWorkViewController.h"



@implementation ClockWorkViewController
@synthesize correctTime,timeGuessed,hourGuessed,minuteGuessed, hourCorrectAnswer,minuteCorrectAnswer,rotationBackMinute,rotationBackHour;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    BOOL viewed = FALSE; // Has the current user ever viewed this tutorial?
    
    // Check if user has viewed this tutorial:
    viewed = [[DBManager getSharedInstance]hasCompletedTutorial:self.optionsSingle.currentUser tutorial:NSStringFromClass([self class])];
    
    // IF tutorial NOT viewed yet:
    if (!viewed) {
        // Mark this tutorial as completed for the current user:
        [[DBManager getSharedInstance]completeTutorial:self.optionsSingle.currentUser tutorial:NSStringFromClass([self class])];
        
        // Show the tutorial:
        //self.tutorialCountingStarsViewController = [[TutorialCountingStarsViewController alloc] init];
        //[self.navigationController pushViewController:self.tutorialCountingStarsViewController animated:YES];
        
    }
    // If difficulty is EASY:
    if(self.optionsSingle.globalDifficultyLevel ==1) {
        self.prepend = @"";
    }
    else {
        self.prepend = @"Hard";
    }

    
    //[self initializeGame]; // Setup the game for play...
}



// function used to randomly move hands of clock and set answers
-(void)normal_move_hands
{
    int hourHandLocation = arc4random() % 12;   // 12 unique locations for hour hand
    int miniuteHandLocation = arc4random() % 4;   // 4 unique locations for minute hand
    if(hourHandLocation ==0)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI / 6); // 1
        rotationBackHour = (M_PI * 11 /6);
        hourCorrectAnswer = [NSString stringWithFormat:@"1"];
    }
    if(hourHandLocation ==1)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI / 3); // 2
        rotationBackHour = (M_PI * 10/6);
        hourCorrectAnswer = [NSString stringWithFormat:@"2"];
    }
    if(hourHandLocation ==2)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI / 2); // 3
        rotationBackHour = (M_PI * 3/2);
        hourCorrectAnswer = [NSString stringWithFormat:@"3"];
    }
    if(hourHandLocation ==3)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI *2 /3); // 4
        rotationBackHour = (M_PI * 4/3);
        hourCorrectAnswer = [NSString stringWithFormat:@"4"];
    }
    if(hourHandLocation ==4)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI * 5 / 6 ); // 5
        rotationBackHour = (M_PI * 7/6);
        hourCorrectAnswer = [NSString stringWithFormat:@"5"];
    }
    if(hourHandLocation ==5)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI); // 6
        rotationBackHour = (M_PI);
        hourCorrectAnswer = [NSString stringWithFormat:@"6"];
    }
    if(hourHandLocation ==6)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI * 7 / 6); // 7
        rotationBackHour = (M_PI * 5/6);
        hourCorrectAnswer = [NSString stringWithFormat:@"7"];
    }
    if(hourHandLocation ==7)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI * 4 /3); // 8
        rotationBackHour = (M_PI * 2/3);
        hourCorrectAnswer = [NSString stringWithFormat:@"8"];
    }
    if(hourHandLocation ==8)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI * 3 / 2); // 9
        rotationBackHour = (M_PI /2);
        hourCorrectAnswer = [NSString stringWithFormat:@"9"];
    }
    if(hourHandLocation ==9)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI * 10 /6); // 10
       rotationBackHour = (M_PI /3);
        hourCorrectAnswer = [NSString stringWithFormat:@"10"];
    }
    if(hourHandLocation ==10)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI * 11 /6); // 11
        rotationBackHour = (M_PI /6);
        hourCorrectAnswer = [NSString stringWithFormat:@"11"];
    }
    if(hourHandLocation ==11)  // 12
    {
        rotationBackHour = 0;
         hourCorrectAnswer = [NSString stringWithFormat:@"12"];
    }
    
    
   if(miniuteHandLocation == 0)  // 0 miniute 
   {
       rotationBackMinute = 0;
       minuteCorrectAnswer = [NSString stringWithFormat:@"0"];
    
   }
   if(miniuteHandLocation == 1)  // 15 miniute
   {
       minuteHand.transform = CGAffineTransformMakeRotation(M_PI /2);
       minuteCorrectAnswer = [NSString stringWithFormat:@"1"];
       rotationBackMinute = (M_PI * 3/2);
   }
   if(miniuteHandLocation == 2)  // 30 miniute
   {
        minuteHand.transform = CGAffineTransformMakeRotation(M_PI);
        minuteCorrectAnswer = [NSString stringWithFormat:@"2"];
       rotationBackMinute = (M_PI);
   }
   if(miniuteHandLocation == 3)  // 45 miniute
   {
       minuteHand.transform = CGAffineTransformMakeRotation(M_PI * 3 /2);
       minuteCorrectAnswer = [NSString stringWithFormat:@"3"];
       rotationBackMinute = (M_PI /2);
   }

        
}

// Reset hands of the block after user guesses correct
-(void)reset_hands
{
    hourHand.transform = CGAffineTransformMakeRotation(rotationBackHour);
    minuteHand.transform = CGAffineTransformMakeRotation(rotationBackMinute);
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows;
    if(component == 0)
    {
        numRows = 12;
    }
    if(component == 1)
    {
        numRows = 1;
    }
    if(component ==2)
    {
        numRows = 4;
    }
    return numRows;
}

// Methods for time picker

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    
    if(component == 0) // hour column
    {
        hourGuessed = [NSString stringWithFormat:@"%d",row + 1];
    }
    if(component == 2)  // minute column
    {
        minuteGuessed = [NSString stringWithFormat:@"%d", row];
    }
    
}


// tell the picker how many components it will have
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString * text;
    NSMutableAttributedString *as;
    if(component == 0)   // fist column
    {
        text = [NSString stringWithFormat:@"%d", row+1];
        as = [[NSMutableAttributedString alloc]initWithString:text];
        NSMutableParagraphStyle *mutParaStyle=[[NSMutableParagraphStyle alloc] init];
        mutParaStyle.alignment = NSTextAlignmentCenter;
        [as addAttribute:NSParagraphStyleAttributeName value:mutParaStyle range:NSMakeRange(0,[text length])];
    }
    if(component == 2)  // third column
    {
        if(row == 0)
        {
            text = [NSString stringWithFormat:@"00"];
        }
        else
        {
            text = [NSString stringWithFormat:@"%d", row *15];
        }
        as = [[NSMutableAttributedString alloc]initWithString:text];
        NSMutableParagraphStyle *mutParaStyle=[[NSMutableParagraphStyle alloc] init];
        mutParaStyle.alignment = NSTextAlignmentCenter;
        [as addAttribute:NSParagraphStyleAttributeName value:mutParaStyle range:NSMakeRange(0,[text length])];
        
    }
    if(component == 1)  // first column
    {
        text = [NSString stringWithFormat:@":"];
        as = [[NSMutableAttributedString alloc]initWithString:text];
        NSMutableParagraphStyle *mutParaStyle=[[NSMutableParagraphStyle alloc] init];
        mutParaStyle.alignment = NSTextAlignmentCenter;
        [as addAttribute:NSParagraphStyleAttributeName value:mutParaStyle range:NSMakeRange(0,[text length])];
    }
    return as;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    int sectionWidth;
    if(component == 0)
    {
        sectionWidth = 100;
    }
    else if(component == 1)
    {
        sectionWidth = 45;
    }
    else 
    {
        sectionWidth = 100;
    }
        
    
    return sectionWidth;
}

-(void)TestDisplay
{
    correcthour.text = [NSString stringWithFormat:@"%@",hourCorrectAnswer];
    correctminute.text = [NSString stringWithFormat:@"%@",minuteCorrectAnswer];
    guesshour.text = [NSString stringWithFormat:@"%@",hourGuessed];
    guessminute.text = [NSString stringWithFormat:@"%@", minuteGuessed];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self normal_move_hands];
    minuteGuessed = [NSString stringWithFormat:@"0"];   // initialize values
    hourGuessed = [NSString stringWithFormat:@"1"];
    [self TestDisplay];
    
    /*
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    hourHand.alpha = 0;
    minuteHand.alpha = 0;
    [UIView commitAnimations];
     */
    
    // create UIPickerView 
    UIPickerView *myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 650, 768, 216)];
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    [self.view addSubview:myPickerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkAnswer:(id)sender
{
    [self TestDisplay];
    if([hourGuessed isEqual:hourCorrectAnswer] && [minuteGuessed isEqual: minuteCorrectAnswer])
    {
        resultLabel.text = [NSString stringWithFormat:@"Correct !!!"];
        [self reset_hands];  // reset hands back to normal position
        [self normal_move_hands];  // move hands and set new answer
        // total correct ++
    }
    else
    {
        resultLabel.text = [NSString stringWithFormat:@"Please try Again !!!"];
    }
    
    /*
    // IF the user has completed enough rounds:
    if(self.userAnswer == 100000000)
    {
        resultLabel.text = [NSString stringWithFormat:@"Correct!"];
        [self incWinStreak]; // Increment the winStreak
        [self add_total_correct]; // add one to total correct
        
        
        self.userAnswer = 0;
        
        // IF user completes 5 rounds: Record Stats and end the game
        if(self.totalCorrect == 5)
        {
            [self endSession];
            
            // The sessionStatistics view will return to this line if the user selected retry...
            
            //[self initializeGame]; // Reset the game for another session...
        }
    }
    else  // user Incorrect
    {
        
        NSDateFormatter * outputFormatter = [[ NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"HH:mm"];
        NSString *dateString = [outputFormatter stringFromDate:timePicker.date];
        resultLabel.text = dateString;
         
        resultLabel.text = [NSString stringWithFormat:@"%@:%@",hourGuessed,minuteGuessed];
        
    }
    */
}
    
    // Setup for a play session:
    -(void)initializeGame {
        self.startTime = [NSDate date]; // Load the current time into startTime...
        [self resetStats];
    }
    
    // Launch this game's tutorial:
    -(IBAction)normal_tutorial_clicked:(id)sender
    {
        //self.tutorialCountingStarsViewController = [[TutorialCountingStarsViewController alloc]init];
        //[self.navigationController pushViewController:self.tutorialCountingStarsViewController animated:YES];
    }

@end




