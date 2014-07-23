//
//  CLAnimationViewController.m
//  Colors
//
//  Created by Evan Coleman on 7/20/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "CLAnimationViewController.h"

@interface CLAnimationViewController ()

@end

@implementation CLAnimationViewController

- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self != nil) {
        self.tabBarItem.image = [UIImage imageNamed:@"aperture"];
        self.title = @"Animations";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
