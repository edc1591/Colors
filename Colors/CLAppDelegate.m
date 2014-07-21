//
//  CLAppDelegate.m
//  Colors
//
//  Created by Evan Coleman on 7/20/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "CLAppDelegate.h"

#import "LTTabBarController.h"

@implementation CLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    LTTabBarController *tabBarController = [[LTTabBarController alloc] init];
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
