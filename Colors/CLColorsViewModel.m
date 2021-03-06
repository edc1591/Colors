//
//  CLSwatchesViewModel.m
//  Colors
//
//  Created by Evan Coleman on 7/22/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "CLColorsViewModel.h"

#import "CLAPIClient.h"

@interface CLColorsViewModel ()

@property (nonatomic) RACCommand *selectColorCommand;
@property (nonatomic) RACCommand *changeBrightnessCommand;
@property (nonatomic) NSArray *colors;

@property (nonatomic) UIColor *selectedColor;
@property (nonatomic) CGFloat currentBrightness;

@end

@implementation CLColorsViewModel

- (instancetype)initWithAPIClient:(CLAPIClient *)apiClient {
    self = [super init];
    if (self != nil) {
        _apiClient = apiClient;
        
        NSMutableArray *colors = [NSMutableArray array];
        for(float angle = 0; angle < 360; angle += 10) {
            CGFloat h = 0;
            h = (M_PI / 180.0 * angle) / (2 * M_PI);
            [colors addObject:[UIColor colorWithHue:h  saturation:1.0 brightness:1.0 alpha:1.0]];
        }
        _colors = [colors copy];
        
        @weakify(self);
        
        _selectColorCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(UIColor *color) {
            @strongify(self);
            if (self.selectedColor == nil || [self.selectedColor isEqualToColor:[UIColor blackColor]]) {
                self.currentBrightness = 1.0;
            }
            self.currentBrightness = 1.0;
            self.selectedColor = color;
            NSLog(@"Swatch Tapped");
            
            return [self.apiClient setColor:color];
        }];
        
        _changeBrightnessCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *brightness) {
            @strongify(self);
            self.currentBrightness = [brightness doubleValue];
            self.selectedColor = [self.selectedColor colorWithBrightness:[brightness doubleValue]];
            return [self.apiClient setColor:self.selectedColor];
        }];
        
//        RAC(self, selectedColor) = [[[_selectSwatchCommand executionSignals]
//                                        switchToLatest] logAll];
    }
    return self;
}

@end
