//
//  CLPickerViewController.m
//  Colors
//
//  Created by Evan Coleman on 7/20/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "CLPickerViewController.h"

@interface CLPickerViewController ()

@end

@implementation CLPickerViewController

- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self != nil) {
        self.tabBarItem.image = [UIImage imageNamed:@"paintbrush"];
        self.title = @"Picker";
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
