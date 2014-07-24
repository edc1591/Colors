//
//  CLTabBarController.m
//  Colors
//
//  Created by Evan Coleman on 7/20/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "CLTabBarController.h"

#import "CLSwatchViewController.h"
#import "CLPickerViewController.h"
#import "CLAnimationViewController.h"

#import "CLAPIClient.h"
#import "CLColorsViewModel.h"

@interface CLTabBarController ()

@end

@implementation CLTabBarController

- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self != nil) {
        CLAPIClient *apiClient = [[CLAPIClient alloc] initWithAccessToken:@"" deviceID:@""];
        
        CLColorsViewModel *swatchesViewModel = [[CLColorsViewModel alloc] initWithAPIClient:apiClient];
        
        CLSwatchViewController *swatchViewController = [[CLSwatchViewController alloc] initWithViewModel:swatchesViewModel];
        CLPickerViewController *pickerViewController = [[CLPickerViewController alloc] initWithViewModel:swatchesViewModel];
        CLAnimationViewController *animationViewController = [[CLAnimationViewController alloc] init];
        
        [self setViewControllers:@[ [self navigationControllerWithRoot:swatchViewController],
                                    [self navigationControllerWithRoot:pickerViewController],
                                    [self navigationControllerWithRoot:animationViewController] ]];
    }
    return self;
}

- (UINavigationController *)navigationControllerWithRoot:(UIViewController *)viewController {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    return navigationController;
}

@end
