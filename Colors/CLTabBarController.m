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
#import "CLAnimationsViewModel.h"

@interface CLTabBarController ()

@property (nonatomic) CLAPIClient *currentClient;

@property (nonatomic, readonly) CLAPIClient *apiClient1;
@property (nonatomic, readonly) CLAPIClient *apiClient2;

@property (nonatomic, readonly) CLColorsViewModel *colorsViewModel;
@property (nonatomic, readonly) CLAnimationsViewModel *animationsViewModel;

@end

@implementation CLTabBarController

- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self != nil) {
        _apiClient1 = [[CLAPIClient alloc] initWithAccessToken:@"" deviceID:@""];
        //_apiClient2 = [[CLAPIClient alloc] initWithAccessToken:@"" deviceID:@""];
        _currentClient = _apiClient1;
        
        _colorsViewModel = [[CLColorsViewModel alloc] initWithAPIClient:_currentClient];
        _animationsViewModel = [[CLAnimationsViewModel alloc] initWithAPIClient:_currentClient];
        
        CLSwatchViewController *swatchViewController = [[CLSwatchViewController alloc] initWithViewModel:_colorsViewModel];
        CLPickerViewController *pickerViewController = [[CLPickerViewController alloc] initWithViewModel:_colorsViewModel];
        CLAnimationViewController *animationViewController = [[CLAnimationViewController alloc] initWithViewModel:_animationsViewModel];
        
        [self setViewControllers:@[ [self navigationControllerWithRoot:swatchViewController],
                                    [self navigationControllerWithRoot:pickerViewController],
                                    [self navigationControllerWithRoot:animationViewController] ]];
    }
    return self;
}

- (UINavigationController *)navigationControllerWithRoot:(UIViewController *)viewController {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    UIBarButtonItem *offButton = [[UIBarButtonItem alloc] initWithTitle:@"Off" style:UIBarButtonItemStylePlain target:nil action:nil];
    @weakify(self);
    offButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id _) {
        @strongify(self);
        return [self.currentClient setColor:[UIColor blackColor]];
    }];
    viewController.navigationItem.leftBarButtonItem = offButton;
    
//    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleBordered target:nil action:nil];
//    UIBarButtonItem *beachButton = [[UIBarButtonItem alloc] initWithTitle:@"Beach" style:UIBarButtonItemStyleBordered target:nil action:nil];
//    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(UIBarButtonItem *item) {
//        @strongify(self);
//        if (item == homeButton) {
//            self.currentClient = self.apiClient2;
//            return [RACSignal return:beachButton];
//        } else {
//            self.currentClient = self.apiClient1;
//            return [RACSignal return:homeButton];
//        }
//    }];
//    homeButton.rac_command = command;
//    beachButton.rac_command = command;

//    RAC(viewController.navigationItem, rightBarButtonItem) =
//        [[[command executionSignals]
//            switchToLatest]
//            startWith:homeButton];
    
    return navigationController;
}

- (void)setCurrentClient:(CLAPIClient *)currentClient {
    _currentClient = currentClient;
    
    self.colorsViewModel.apiClient = _currentClient;
    self.animationsViewModel.apiClient = _currentClient;
}

@end
