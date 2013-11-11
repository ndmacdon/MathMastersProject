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
    NSString *correctTime;
    NSString *hourGuessed;
    NSString *minuteGuessed;
    NSString *hourCorrectAnswer;
    NSString *minuteCorrectAnswer;
}
@synthesize correctTime,timeGuessed,hourGuessed,minuteGuessed, hourCorrectAnswer,minuteCorrectAnswer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    BOOL viewed = FALSE; // Has the current user ever viewed this tutorial?
    NSString *myName;
    
    // If difficulty is Normal: add a prefix to our classname.
    if(self.optionsSingle.globalDifficultyLevel == 1) {
        self.prepend = @"";
    }
    // ELSE: difficulty is Hard.
    else {
        self.prepend = @"Hard";
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
    
    [self initializeGame]; // Setup the game for play...
}

// function used to randomly move hands of clock and set answers
-(void)normal_move_hands
{
    int hourHandLocation = arc4random() % 12;   // 12 unique locations for hour hand
    int miniuteHandLocation = arc4random() % 4;   // 4 unique locations for minute hand
    if(hourHandLocation ==0)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI / 6); // 1
        hourCorrectAnswer = [NSString stringWithFormat:@"1"];
    }
    if(hourHandLocation ==1)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI / 3); // 2
        hourCorrectAnswer = [NSString stringWithFormat:@"2"];
    }
    if(hourHandLocation ==2)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI / 2); // 3
        hourCorrectAnswer = [NSString stringWithFormat:@"3"];
    }
    if(hourHandLocation ==3)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI *2 /3); // 4
        hourCorrectAnswer = [NSString stringWithFormat:@"4"];
    }
    if(hourHandLocation ==4)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI * 5 / 6 ); // 5
        hourCorrectAnswer = [NSString stringWithFormat:@"5"];
    }
    if(hourHandLocation ==5)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI); // 6
        hourCorrectAnswer = [NSString stringWithFormat:@"6"];
    }
    if(hourHandLocation ==6)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI * 7 / 6); // 7
        hourCorrectAnswer = [NSString stringWithFormat:@"7"];
    }
    if(hourHandLocation ==7)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI * 4 /3); // 8
        hourCorrectAnswer = [NSString stringWithFormat:@"8"];
    }
    if(hourHandLocation ==8)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI * 3 / 2); // 9
        hourCorrectAnswer = [NSString stringWithFormat:@"9"];
    }
    if(hourHandLocation ==9)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI * 10 /6); // 10
        hourCorrectAnswer = [NSString stringWithFormat:@"10"];
    }
    if(hourHandLocation ==10)
    {
        hourHand.transform =CGAffineTransformMakeRotation(M_PI * 11 /6); // 11
        hourCorrectAnswer = [NSString stringWithFormat:@"11"];
    }
    if(hourHandLocation ==11)  // 12
    {
         hourCorrectAnswer = [NSString stringWithFormat:@"12"];
    }
    
    
   if(miniuteHandLocation == 0)  // 0 miniute 
   {
       minuteCorrectAnswer = [NSString stringWithFormat:@"0"];
    
   }
   if(miniuteHandLocation == 1)  // 15 miniute
   {
       minuteHand.transform = CGAffineTransformMakeRotation(M_PI /2);
       minuteCorrectAnswer = [NSString stringWithFormat:@"1"];
   }
   if(miniuteHandLocation == 2)  // 30 miniute
   {
        minuteHand.transform = CGAffineTransformMakeRotation(M_PI);
        minuteCorrectAnswer = [NSString stringWithFormat:@"2"];
   }
   if(miniuteHandLocation == 3)  // 45 miniute
   {
       minuteHand.transform = CGAffineTransformMakeRotation(M_PI * 3 /2);
       minuteCorrectAnswer = [NSString stringWithFormat:@"3"];
   }

        
}

// Reset hands of the block after user guesses correct
-(void)reset_hands
{
    if(![hourCorrectAnswer isEqual:@"3"]) // if not equal to 12 (don't need to reset if 12)
    {
        hourHand.transform = CGAffineTransformMakeRotation(0);
    }
    if(![minuteCorrectAnswer isEqual:@"0"])  // if not equal to 00 ( dont neeed to reset if minutes are 00)
    {
        minuteHand.transform = CGAffineTransformMakeRotation(0);
    }
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows;
    if(component == 0) {
        numRows = 12;
    }
    if(component == 1) {
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
    if(component == 0) {
        sectionWidth = 100;
    }
    else if(component == 1) {
        sectionWidth = 45;
    }
    else {
        sectionWidth = 100;
    }
    
    return sectionWidth;
}


-(void)TestDisplay {
    correcthour.text = [NSString stringWithFormat:@"%@",hourCorrectAnswer];
    correctminute.text = [NSString stringWithFormat:@"%@",minuteCorrectAnswer];
    guesshour.text = [NSString stringWithFormat:@"%@",hourGuessed];
    guessminute.text = [NSString stringWithFormat:@"%@", minuteGuessed];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self normal_move_hands];
    minuteGuessed = [NSString stringWithFormat:@"0"];   // initialize values
    hourGuessed = [NSString stringWithFormat:@"1"];
    [self TestDisplay];
    
    // create UIPickerView 
    UIPickerView *myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 650, 768, 216)];
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    [self.view addSubview:myPickerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)checkAnswer:(id)sender {
    //[self TestDisplay]; // DEBUG ONLY
    
    if([hourGuessed isEqual:hourCorrectAnswer] && [minuteGuessed isEqual: minuteCorrectAnswer])
    {
        resultLabel.text = [NSString stringWithFormat:@"Correct !!!"];
        [self inc_total_correct]; // add one to total correct and increase the winStreak.
        
        // IF user completes 5 rounds: Record Stats and end the game
        if(self.totalCorrect == sessionRounds)
        {
            [self endSession];
            
            // The sessionStatistics view will return to this line if the user selected retry...
        }
        else {
            [self reset_hands];  // reset hands back to normal position
            [self normal_move_hands];  // move hands and set new answer
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
    [self resetStats];
}

// Launch this game's tutorial:
-(IBAction)normal_tutorial_clicked:(id)sender
{
    //self.tutorialCountingStarsViewController = [[TutorialCountingStarsViewController alloc]init];
    //[self.navigationController pushViewController:self.tutorialCountingStarsViewController animated:YES];
}

@end




