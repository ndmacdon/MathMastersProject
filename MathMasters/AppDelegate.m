//
//  AppDelegate.m
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//


#import "AppDelegate.h"
#import "ViewController.h"
#import "LogInViewController.h"

@implementation AppDelegate
@synthesize window;
@synthesize logInViewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; 
    self.logInViewController = [[LogInViewController alloc] initWithNibName:@"LogInViewController" bundle:nil]; // initialize logInViewController
    self.window.rootViewController = self.logInViewController;
    [self.window makeKeyAndVisible];
     
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end
