/****
 *
 * Filename:    StatisticsViewController.m
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: November 05, 2013
 *
 * Description: Controller: Manages View and Model for displaying statistics.
 *              Based on examples from: http://www.raywenderlich.com/13271/
 *
 ****/

#import "StatisticsViewController.h"

@interface StatisticsViewController ()

@end

@implementation StatisticsViewController {
    NSMutableArray *sessionDates; // Array containing dates of sessions.
    NSMutableArray *sessionLengths; // Array containing lengths of sessions.
    NSString *currentGame;
    NSArray *gameList;
    NSString *gameSelected;
    IBOutlet UIView *graphView;
}
@synthesize hostView = hostView_;


NSArray *tempDays = nil;

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Load stats for CountingStars by default:
    [self clearPlot]; // Ensure the plot is clear...
    [self getDataFor:@"CountingStarsViewController"];
    gameSelected = @"CountingStarsViewController"; // Appears as the graph title
    [self initPlot];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    optionsSingle = [GlobalVariables singleObj];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Controls which game to load stats for:
- (IBAction)statisticsControl:(id)sender {
    [self clearPlot];
    
    // Switch depending on which Statistics the user selects:
    switch (statisticsControl.selectedSegmentIndex) {
        case 0:
            gameSelected = @"CountingStarsViewController";
            break;
        case 1:
            gameSelected = @"MakingCentsViewController";
            break;
        case 2:
            gameSelected = @"SuperShopperViewController";
            break;
        case 3:
            gameSelected = @"ClockworkViewController";
            break;
        case 4:
            gameSelected = @"ApplesToOrangesViewController";
            break;
            
        default:
            gameSelected = @"CountingStarsViewController";
            break;
    }
    
    // IF user turns on HardMode statistics: Prepend Hard Mode to gameSelect...
    if (hardModeSwitch.on) {
        gameSelected = [NSString stringWithFormat:@"Hard%@", gameSelected];
    }
    
    [self getDataFor:gameSelected];
    [self initPlot];
    NSLog(@"Loaded statistics for %@", gameSelected);
}

// Perform plot initialization:
-(void)initPlot {
    [self configureHost];
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
}

-(void)clearPlot {
    [self.hostView removeFromSuperview];
}

// Grab a copy of the user Statistics for our graph:
-(void)getDataFor:(NSString *)gameName {
    NSArray* tempData =
    [[DBManager getSharedInstance] getStatsForGame:gameName
                                         aboutUser:optionsSingle.currentUser];
    
    NSString* tempString = nil;                     // A string to help us with manipulations...
    NSRange dayRange = NSMakeRange(8, 2);           // Range of characters we want to extract from the date...
    sessionDates = [[NSMutableArray alloc] init];
    sessionLengths = [[NSMutableArray alloc] init];

    // FOR each returned record:
    for (NSInteger i = [tempData count]-1; i >= 0; i--) {
        
        // IF i is even:
        if ( (i % 2) == 0) {
            // The following 3 lines CAN be done with one line and without temp variables but
            // it is a mess to read and would be poor style...
            
            tempString = [tempData objectAtIndex:i]; // Get the next date.
            tempString = [tempString substringWithRange:dayRange]; // Carve out the day...
            [sessionDates addObject:tempString]; // Add the day to the array...
        }
        // ELSE i is odd:
        else {
            // Convert the value to an integer, NSNumber and add it to an NSArray...
            [sessionLengths addObject: [NSNumber numberWithInt:[[tempData objectAtIndex:i] integerValue]]];
        }
    }

}

// Initialize the hostView our graph will inhabit:
-(void)configureHost {
    
    CGRect graphRect = graphView.bounds; // Bounds for our graph.
	graphRect = CGRectMake(graphView.frame.origin.x,
							graphView.frame.origin.y,
							graphRect.size.width,
							graphRect.size.height);
    
    
    self.hostView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:graphRect];
    self.hostView.allowPinchScaling = FALSE;
    [self.view addSubview:self.hostView];
}

// Graph is the entire area encompassing the grid, titles and plots
-(void)configureGraph {
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];  // Encompassing graph for our plot
    NSString *title = gameSelected;                                             // Title for our graph
    CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];          // Styles for denoted elements...
    CPTMutableLineStyle *borderLineStyle = [CPTMutableLineStyle lineStyle];     // ...
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;      // Plot area of our graph
    
    // Trim the 'ViewController' text off of the title:
    title = [title stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    
    
    self.hostView.hostedGraph = graph;
    [graph applyTheme:[CPTTheme themeNamed:kCPTPlainWhiteTheme]];
    
    // Set Graph Title:
    graph.title = title;
    
    // Create and set text style:
    titleStyle.color = [CPTColor blackColor];
    titleStyle.fontName = @"Helvetica-Bold";
    titleStyle.fontSize = 30.0f;
    graph.titleTextStyle = titleStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, 0.0f);
    
    // Set plot area padding (between plot and graph-view edge):
    [graph.plotAreaFrame setPaddingLeft:80.0f];
    [graph.plotAreaFrame setPaddingBottom:60.0f];

    // Set the border to nearly 0
    borderLineStyle.lineColor = [CPTColor blackColor];
    borderLineStyle.lineWidth = 4.0;
    
    // 
    graph.plotAreaFrame.borderLineStyle = borderLineStyle;
    graph.fill = [CPTFill fillWithColor:[CPTColor clearColor]];
    graph.plotAreaFrame.fill = [CPTFill fillWithColor:[CPTColor clearColor]];
    
    // Enable User interaction:
    plotSpace.allowsUserInteraction = FALSE;
}

// A plot is the sequence of ticks and lines describing the data in the graph:
-(void)configurePlots {
    CPTGraph *graph = self.hostView.hostedGraph;                            // Holds the plot, X/Y axis, and titles...
    CPTScatterPlot *statsPlot = [[CPTScatterPlot alloc] init];              // Data points and lines visualizing data
    CPTColor *statsPlotColor = [CPTColor blueColor];                        // Color for plot
    CPTMutablePlotRange *xRange;                                            // Range of the x-axis
    CPTPlotRange *yRange;                                                   // ...
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;  // Object in our graph which will hold our plot
    int dataMaxY = 0;                                                       // Max value displayed on Y-Axis
    int dataMaxX = 0;
    CPTMutableLineStyle *statsLineStyle;                                    // Visual styles for denoted elements...
    CPTMutableLineStyle *statsSymbolLineStyle;                              // ...
    CPTPlotSymbol *statsSymbol;                                             // Symbol placed at datapoints
    
    
    
    // Create a plot
    statsPlot.dataSource = self;
    statsPlot.identifier = @"STATS";
    [graph addPlot:statsPlot toPlotSpace:plotSpace]; // Add plot to our graph.

    // Set up plot space
    [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:statsPlot, nil]];
    
    // X axis range:
    xRange = [plotSpace.xRange mutableCopy];
    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.2f)];
    
    // Y axis range:
    dataMaxY = [[sessionLengths valueForKeyPath:@"@max.self"] intValue];
    dataMaxX = [sessionDates count];
    
    // Prevent the graph from being overly compressed:
    if (dataMaxY < 60) { dataMaxY = 60; }
    if (dataMaxX < 5) { dataMaxX = 5; }
    
    yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.0f) length:CPTDecimalFromInt(dataMaxY*1.25f)];
    xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.0f) length:CPTDecimalFromInt(dataMaxX*1.25f)];
    
    // Apply ranges to the plot:
    plotSpace.xRange = xRange;
    plotSpace.yRange = yRange;
    
    
    // Create plot line styles and symbols:
    statsLineStyle = [statsPlot.dataLineStyle mutableCopy];
    statsLineStyle.lineWidth = 4;
    statsLineStyle.lineColor = statsPlotColor;

    statsSymbolLineStyle = [CPTMutableLineStyle lineStyle];
    statsSymbolLineStyle.lineColor = statsPlotColor;
    
    statsSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    statsSymbol.fill = [CPTFill fillWithColor:statsPlotColor];
    statsSymbol.lineStyle = statsSymbolLineStyle;
    statsSymbol.size = CGSizeMake(15.0f, 15.0f);
    
    // Apply the styles to our plot:
    statsPlot.dataLineStyle = statsLineStyle;
    statsPlot.plotSymbol = statsSymbol;
}

// Configure the labels and intervals on our axes:
-(void)configureAxes {
    CPTMutableTextStyle *axisTitleStyle  = [CPTMutableTextStyle textStyle];     // Styles for denoted elements...
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];       // ...
    CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];    // ...
    CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];       // ...
    CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];       // ...
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet; // Set of axes for plot.
    CPTAxis *x = axisSet.xAxis;                                                // x Axis for our plot...
    
    CGFloat entryCount = [sessionDates count];                               // Number of entries on x axis
    NSMutableSet *xLabels = [NSMutableSet setWithCapacity:entryCount];      // Labels for x axis
    NSMutableSet *xLocations = [NSMutableSet setWithCapacity:entryCount];   // Locations of labels for x axis
    NSInteger i = 0;                                                        // Iterator...
    
    int dataMaxY = [[sessionLengths valueForKeyPath:@"@max.self"] intValue];// Highest y axis value
    CPTAxis *y = axisSet.yAxis;                 // y Axis for our plot
    NSInteger majorIncrement = 5;               // major y increment
    NSInteger minorIncrement = 1;               // minor y increment
    CGFloat yMax = dataMaxY * 1.5f;             // Max y value on y axis
    NSMutableSet *yLabels = [NSMutableSet set]; // Labels for y axis major increments
    NSMutableSet *yMajorLocations = [NSMutableSet set]; // Locations for y axis major increments
    NSMutableSet *yMinorLocations = [NSMutableSet set]; // ... minor increments
    CPTAxisLabel *label;                        // next label read from data
    CGFloat location;                         // next location computed
    
    
    // Axis Title Style:
    axisTitleStyle.color = [CPTColor blackColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 30.0f;
    
    // Axis Line Style:
    axisLineStyle.lineWidth = 4.0f;
    axisLineStyle.lineColor = [CPTColor blackColor];
    
    // Axis Text Style:
    axisTextStyle.color = [CPTColor blackColor];
    axisTextStyle.fontName = @"Helvetica-Bold";
    axisTextStyle.fontSize = 20.0f;
    
    // Axis Tick Style
    tickLineStyle.lineColor = [CPTColor blackColor];
    tickLineStyle.lineWidth = 2.0f;
    
    // Axis Grid Style
    gridLineStyle.lineColor = [CPTColor grayColor];
    gridLineStyle.lineWidth = 1.0f;
    
    
    // Configure x-axis
    axisSet.xAxis.axisConstraints = [CPTConstraints constraintWithLowerOffset:0.0];
    x.title = @"Session";
    x.titleTextStyle = axisTitleStyle;
    x.titleOffset = 15.0f;
    x.axisLineStyle = axisLineStyle;
    x.majorGridLineStyle = gridLineStyle;
    x.majorTickLineStyle = axisLineStyle;
    x.majorTickLength = 1.0f;
    x.tickDirection = CPTSignNegative;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    x.labelTextStyle = axisTextStyle;
    
    // Ensure graph is not too compressed...
    if (entryCount < 5) { entryCount = 5; }
    
    // FOREACH X-axis element:
    for (i = 0; i <= entryCount; i++) {//NSString *date in sessionDates) {
        label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%d", i+1]
                                         textStyle:x.labelTextStyle];
        location = (i+1);//CPTDecimalFromInteger(i+1);
        label.tickLocation = CPTDecimalFromCGFloat(location);
        label.offset = x.majorTickLength;
        
        if (label) {
            [xLabels addObject:label];
            [xLocations addObject:[NSNumber numberWithFloat:location]];  
        }
    }
    
    // Assign the labels and locations we computed:
    x.axisLabels = xLabels;
    x.majorTickLocations = xLocations;
    
    // Configure y-axis
    axisSet.yAxis.axisConstraints = [CPTConstraints constraintWithLowerOffset:0.0];
    y.title = @"Completion Time";
    y.titleTextStyle = axisTitleStyle;
    y.titleOffset = -80.0f;
    y.axisLineStyle = axisLineStyle;
    y.majorGridLineStyle = gridLineStyle;
    y.labelingPolicy = CPTAxisLabelingPolicyNone;
    y.labelTextStyle = axisTextStyle;
    y.labelOffset = 20.0f;
    y.majorTickLineStyle = axisLineStyle;
    y.majorTickLength = 5.0f;
    y.minorTickLength = 1.0f;
    y.tickDirection = CPTSignPositive;
    
    // Ensure graph is not too compressed...
    if (yMax < 60) { yMax = 80; }
    
    for (NSInteger j = 0; j <= yMax; j += minorIncrement) {
        
        // IF this is a major increment:
        if ( (j % majorIncrement) == 0) {
            // Set label to j:
            label =
            [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%i", j]
                                     textStyle:y.labelTextStyle];
            
            location = j;//CPTDecimalFromInteger(j);
            label.tickLocation = CPTDecimalFromCGFloat(location);
            label.offset = -y.majorTickLength - y.labelOffset;
            
            if (label) { [yLabels addObject:label]; }
            
            [yMajorLocations addObject:[NSNumber numberWithFloat:location]];
        }
        else {
            [yMinorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:CPTDecimalFromInteger(j)]];
        }
    }
    
    // Assign the labels and locations we computed:
    y.axisLabels = yLabels;    
    y.majorTickLocations = yMajorLocations;
    y.minorTickLocations = yMinorLocations;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Number of records for each plot on the graph:
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return [sessionLengths count];
}

// Used by CorePlot library functions while populating the a plot:
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
    NSInteger valueCount = [sessionLengths count];
    
    
    switch (fieldEnum) {
        case CPTScatterPlotFieldX:
            if (index < valueCount) {
                return [NSNumber numberWithUnsignedInteger:index+1];
            }
            break;
        
        //
        case CPTScatterPlotFieldY:
            if ([plot.identifier isEqual:@"STATS"] == TRUE) {
                return [sessionLengths objectAtIndex:index];
            }
            break;
    }
    
    // Return 0 if nothing matched the passed fieldEnum...
    return [NSDecimalNumber zero];
}


@end









