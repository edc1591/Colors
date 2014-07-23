//
//  CLSwatchViewController.m
//  Colors
//
//  Created by Evan Coleman on 7/20/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "CLSwatchViewController.h"

#import "CLSwatchView.h"

#import "CLSwatchesViewModel.h"

@interface CLSwatchViewController ()

@property (nonatomic) CLSwatchesViewModel *viewModel;

@property (nonatomic) UISlider *brightnessSlider;

@end

@implementation CLSwatchViewController

- (instancetype)initWithViewModel:(CLSwatchesViewModel *)viewModel {
    self = [super initWithNibName:nil bundle:nil];
    if (self != nil) {
        self.tabBarItem.image = [UIImage imageNamed:@"layers"];
        self.title = @"Swatches";
        
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    CGFloat const totalWidth = self.view.bounds.size.width - 40.0;
    CGFloat const swatchCellWidth = totalWidth / 6.0;
    
    NSInteger sx = 20;
    NSInteger sy = 130;
	
    for (UIColor *color in self.viewModel.colors) {
        CLSwatchView *swatchView = [[CLSwatchView alloc] initWithColor:color selectCommand:self.viewModel.selectSwatchCommand];
        
        swatchView.frame = CGRectMake(sx + swatchCellWidth * 0.5 - 18.0, sy, 36.0, 36.0);
        sx += swatchCellWidth;
        if (sx >= totalWidth) {
            sx = 20;
            sy += 46;
        }
        
        [self.view addSubview:swatchView];
    }
    
    self.brightnessSlider = [[UISlider alloc] initForAutoLayout];
    self.brightnessSlider.minimumValue = 0.0;
    self.brightnessSlider.maximumValue = 1.0;
    self.brightnessSlider.minimumValueImage = [UIImage imageNamed:@"dark"];
    self.brightnessSlider.maximumValueImage = [UIImage imageNamed:@"bright"];
    [self.view addSubview:self.brightnessSlider];
    
    @weakify(self);
    [[self.brightnessSlider rac_signalForControlEvents:UIControlEventValueChanged]
        subscribeNext:^(UISlider *slider) {
            @strongify(self);
            [self.viewModel.changeBrightnessCommand execute:@(slider.value)];
        }];
    
    [self.brightnessSlider autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:(UIView *)self.bottomLayoutGuide withOffset:-38];
    [self.brightnessSlider autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [self.brightnessSlider autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
}

@end
