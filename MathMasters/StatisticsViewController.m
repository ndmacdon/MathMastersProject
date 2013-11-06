//
//  StatisticsViewController.m
//  MathMasters
//
//  Created by Kristina Mishina on 13-11-03.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import "StatisticsViewController.h"

@interface StatisticsViewController ()

@end

@implementation StatisticsViewController {
    NSArray *userStats; // Array containing the users statistics...
    NSString *currentGame;
    NSArray *gameList;
}
@synthesize hostView = hostView_;


NSArray *tempDays = nil;




-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initPlot];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    optionsSingle = [GlobalVariables singleObj];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    
    NSDate *curDate = [NSDate date];
    
    NSString *curDateString = [dateFormatter stringFromDate:curDate];
    
    // Grab a copy of the user Statistics for our graph:
    userStats = [[DBManager getSharedInstance] getStatsBefore:curDateString
                                                      forGame:@"CountingStarsViewController"
                                                    aboutUser:optionsSingle.currentUser];
    
    // TEMP DEBUG DATA...
    tempDays = [NSArray arrayWithObjects:
                @"1",
                @"2",
                @"3",
                @"4",
                @"5",
                nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)initPlot {
    [self configureHost];
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
}

-(void)configureHost {
    // Initialize the hostView our graph will inhabit:
    self.hostView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:self.view.bounds];
    self.hostView.allowPinchScaling = YES;
    [self.view addSubview:self.hostView];
}

-(void)configureGraph {
    // Create the graph:
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
    [graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];
    self.hostView.hostedGraph = graph;
    
    // Set Graph Title:
    NSString *title = @"Daily Scores";
    graph.title = title;
    
    // Create and set text style:
    CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
    titleStyle.color = [CPTColor whiteColor];
    titleStyle.fontName = @"Helvetica-Bold";
    titleStyle.fontSize = 50.0f;
    graph.titleTextStyle = titleStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, -20.0f);
    
    // Set plot area padding (between plot and graph-view edge):
    [graph.plotAreaFrame setPaddingLeft:45.0f];
    [graph.plotAreaFrame setPaddingBottom:45.0f];
    
    // Enable User interaction:
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = TRUE;
}

-(void)configurePlots {
    // Get graph and plot space
    CPTGraph *graph = self.hostView.hostedGraph;
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    
    // Create a plot
    CPTScatterPlot *aaplPlot = [[CPTScatterPlot alloc] init];
    aaplPlot.dataSource = self;
    aaplPlot.identifier = @"AAPL";
    CPTColor *aaplColor = [CPTColor yellowColor];
    [graph addPlot:aaplPlot toPlotSpace:plotSpace]; // Add plot to our graph.

    // Set up plot space
    [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:aaplPlot, nil]];
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
    plotSpace.xRange = xRange;
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    [yRange expandRangeByFactor:CPTDecimalFromCGFloat(1.2f)];
    plotSpace.yRange = yRange;
    
    // Create styles and symbols
    CPTMutableLineStyle *aaplLineStyle = [aaplPlot.dataLineStyle mutableCopy];
    aaplLineStyle.lineWidth = 4;
    aaplLineStyle.lineColor = aaplColor;
    aaplPlot.dataLineStyle = aaplLineStyle;
    CPTMutableLineStyle *aaplSymbolLineStyle = [CPTMutableLineStyle lineStyle];
    aaplSymbolLineStyle.lineColor = aaplColor;
    CPTPlotSymbol *aaplSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    aaplSymbol.fill = [CPTFill fillWithColor:aaplColor];
    aaplSymbol.lineStyle = aaplSymbolLineStyle;
    aaplSymbol.size = CGSizeMake(15.0f, 15.0f);
    aaplPlot.plotSymbol = aaplSymbol;
}

-(void)configureAxes {
    // Create axis styles
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    
    // Axis Title Style:
    axisTitleStyle.color = [CPTColor whiteColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 30.0f;
    
    // Axis Line Style:
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 4.0f;
    axisLineStyle.lineColor = [CPTColor whiteColor];
    
    // Axis Text Style:
    CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
    axisTextStyle.color = [CPTColor whiteColor];
    axisTextStyle.fontName = @"Helvetica-Bold";
    axisTextStyle.fontSize = 20.0f;
    
    // Axis Tick Style
    CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor whiteColor];
    tickLineStyle.lineWidth = 2.0f;
    
    // Axis Grid Style
    CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
    gridLineStyle.lineColor = [CPTColor grayColor];
    gridLineStyle.lineWidth = 1.0f;
    
    // Get axis set
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
    
    // Configure x-axis
    CPTAxis *x = axisSet.xAxis;
    axisSet.xAxis.axisConstraints = [CPTConstraints constraintWithLowerOffset:15.0];
    x.title = @"Day";
    x.titleTextStyle = axisTitleStyle;
    x.titleOffset = 15.0f;
    x.axisLineStyle = axisLineStyle;
    x.majorGridLineStyle = gridLineStyle;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    x.labelTextStyle = axisTextStyle;
    x.majorTickLineStyle = axisLineStyle;
    x.majorTickLength = 1.0f;
    x.tickDirection = CPTSignNegative;
    
    
    CGFloat entryCount = 5; // *********DUMMY DATA ATM...
    NSMutableSet *xLabels = [NSMutableSet setWithCapacity:entryCount];
    NSMutableSet *xLocations = [NSMutableSet setWithCapacity:entryCount];
    NSInteger i = 0;
    
    // FOREACH X-axis element:
    for (NSString *date in tempDays) {
        CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:date  textStyle:x.labelTextStyle];
        CGFloat location = i++;
        label.tickLocation = CPTDecimalFromCGFloat(location);
        label.offset = x.majorTickLength;
        
        if (label) {
            [xLabels addObject:label];
            [xLocations addObject:[NSNumber numberWithFloat:location]];
        }
    }
    
    x.axisLabels = xLabels;
    x.majorTickLocations = xLocations;
    
    
    // Configure y-axis
    CPTAxis *y = axisSet.yAxis;
    axisSet.yAxis.axisConstraints = [CPTConstraints constraintWithLowerOffset:40.0];
    y.title = @"Completion Time";
    y.titleTextStyle = axisTitleStyle;
    y.titleOffset = -80.0f;
    y.axisLineStyle = axisLineStyle;
    y.majorGridLineStyle = gridLineStyle;
    y.labelingPolicy = CPTAxisLabelingPolicyNone;
    y.labelTextStyle = axisTextStyle;
    y.labelOffset = 20.0f;
    y.majorTickLineStyle = axisLineStyle;
    y.majorTickLength = 18.0f;
    y.minorTickLength = 10.0f;
    y.tickDirection = CPTSignPositive;
    
    NSInteger majorIncrement = 10;
    NSInteger minorIncrement = 2;
    CGFloat yMax = 300.0f;  // should determine dynamically based on max time
    NSMutableSet *yLabels = [NSMutableSet set];
    NSMutableSet *yMajorLocations = [NSMutableSet set];
    NSMutableSet *yMinorLocations = [NSMutableSet set];
    
    
    for (NSInteger j = minorIncrement; j <= yMax; j += minorIncrement) {
        
        NSUInteger mod = j % majorIncrement;
        
        if (mod == 0) {
            CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%i", j] textStyle:y.labelTextStyle];
            
            NSDecimal location = CPTDecimalFromInteger(j);
            label.tickLocation = location;
            label.offset = -y.majorTickLength - y.labelOffset;
            
            if (label) { [yLabels addObject:label]; }
            
            [yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
        }
        else {
            [yMinorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:CPTDecimalFromInteger(j)]];
        }
    }
    
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
// TODO: Set this up as a count(*) query...
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return 5;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
    NSInteger valueCount = 5;
    
    // Dummy data for debug...
    NSArray *tempScores = nil;
    tempScores = [NSArray arrayWithObjects:
                  [NSDecimalNumber numberWithFloat:180],
                  [NSDecimalNumber numberWithFloat:154],
                  [NSDecimalNumber numberWithFloat:122],
                  [NSDecimalNumber numberWithFloat:100],
                  [NSDecimalNumber numberWithFloat:47.5],
                  nil];
    
    switch (fieldEnum) {
        case CPTScatterPlotFieldX:
            if (index < valueCount) {
                return [NSNumber numberWithUnsignedInteger:index];
            }
            break;
        
        //
        case CPTScatterPlotFieldY:
            if ([plot.identifier isEqual:@"AAPL"] == TRUE) {
                return [tempScores objectAtIndex:index];
            }
            break;
    }
    
    // Return 0 if nothing matched the passed fieldEnum...
    return [NSDecimalNumber zero];
}

@end









