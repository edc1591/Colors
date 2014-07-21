//
//  CLAppDelegate.m
//  Colors
//
//  Created by Evan Coleman on 7/20/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "CLAppDelegate.h"

#import "CLTabBarController.h"

@implementation CLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    CLTabBarController *tabBarController = [[CLTabBarController alloc] init];
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
