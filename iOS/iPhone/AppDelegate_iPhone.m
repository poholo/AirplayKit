//
//  AppDelegate_iPhone.m
//  AirplayKit
//
//  Created by Andy Roth on 1/22/11.
//  Copyright 2011 Roozy. All rights reserved.
//

#import "AppDelegate_iPhone.h"

@implementation AppDelegate_iPhone

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    // Just Testing
	manager = [[AKAirplayManager alloc] init];
	manager.delegate = self;
	[manager findDevices];
    
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [UIViewController new];
    
    return YES;
}

- (void) manager:(AKAirplayManager *)manager didFindDevice:(AKDevice *)device
{
	NSLog(@"Found device. Connecting...");
}

- (void) manager:(AKAirplayManager *)manager didConnectToDevice:(AKDevice *)device
{
	NSLog(@"Connected to device : %@", device.hostname);
	[self sendRemoteVideo];
}

- (void) sendRemoteVideo
{
	if(manager.connectedDevice) [manager.connectedDevice sendContentURL:@"http://vssauth.waqu.com/1hb69wcs2ln1144e/normal.mp4?auth_key=1478346314-0-0-361265601a6f5581687ea8a4eadc502f"];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [manager.connectedDevice sendStop];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [manager.connectedDevice sendStop];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
