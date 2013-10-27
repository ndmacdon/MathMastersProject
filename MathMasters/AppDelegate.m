//
//  AppDelegate.m
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//


#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate
@synthesize window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // Load the MainViewController:
    //self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    //UINavigationController *navigationViewController = [[UINavigationController alloc] initWithRootViewController:self.viewController];  // self.viewController is the main screen
    //self.window.rootViewController = navigationViewController; // set root to navigationViewController
     
    //[self.window makeKeyAndVisible];
    
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
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
