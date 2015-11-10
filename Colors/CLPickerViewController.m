//
//  CLPickerViewController.m
//  Colors
//
//  Created by Evan Coleman on 7/20/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "CLPickerViewController.h"

#import "CLColorsViewModel.h"

#import <RSColorPicker/RSColorPickerView.h>

@interface CLPickerViewController () <RSColorPickerViewDelegate>

@property (nonatomic) CLColorsViewModel *viewModel;

@property (nonatomic) RSColorPickerView *colorPicker;
@property (nonatomic) UISlider *brightnessSlider;

@end

@implementation CLPickerViewController

- (instancetype)initWithViewModel:(CLColorsViewModel *)viewModel {
    self = [super initWithNibName:nil bundle:nil];
    if (self != nil) {
        _viewModel = viewModel;
        self.tabBarItem.image = [UIImage imageNamed:@"paintbrush"];
        self.title = @"Picker";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
	
    self.colorPicker = [[RSColorPickerView alloc] initWithFrame:CGRectMake(10, 84, CGRectGetWidth(self.view.bounds) - 20, CGRectGetWidth(self.view.bounds) - 20)];
    self.colorPicker.delegate = self;
    self.colorPicker.cropToCircle = YES;
    [self.view addSubview:self.colorPicker];
    
    @weakify(self);
    [[[self rac_signalForSelector:@selector(colorPicker:touchesEnded:withEvent:) fromProtocol:@protocol(RSColorPickerViewDelegate)]
        skip:0]
        subscribeNext:^(RACTuple *tuple) {
            @strongify(self);
            RACTupleUnpack(RSColorPickerView *colorPickerView, __unused id touches, __unused id event) = tuple;
            [self.viewModel.selectColorCommand execute:colorPickerView.selectionColor];
        }];
    
    self.brightnessSlider = [[UISlider alloc] initForAutoLayout];
    self.brightnessSlider.minimumValue = 0.0;
    self.brightnessSlider.maximumValue = 1.0;
//    self.brightnessSlider.value = 1.0;
    self.brightnessSlider.minimumValueImage = [UIImage imageNamed:@"dark"];
    self.brightnessSlider.maximumValueImage = [UIImage imageNamed:@"bright"];
    [self.view addSubview:self.brightnessSlider];
    
    [[self.brightnessSlider rac_signalForControlEvents:UIControlEventValueChanged]
     subscribeNext:^(UISlider *slider) {
         @strongify(self);
         [self.viewModel.changeBrightnessCommand execute:@(slider.value)];
     }];
    
    RAC(self.brightnessSlider, value) = [RACObserve(self, viewModel.currentBrightness) catchTo:[RACSignal return:nil]];
    
//    [self.brightnessSlider autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:(UIView *)self.bottomLayoutGuide withOffset:-38];
    [self.brightnessSlider autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [self.brightnessSlider autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
}

#pragma mark - RSColorPickerViewDelegate

- (void)colorPicker:(RSColorPickerView *)colorPicker touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

@end
