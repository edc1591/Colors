//
//  CLSwatchView.m
//  Colors
//
//  Created by Evan Coleman on 7/22/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "CLSwatchView.h"

@interface CLSwatchView ()

@property (nonatomic) RACCommand *selectCommand;
@property (nonatomic) UIColor *color;

@end

@implementation CLSwatchView

- (instancetype)initWithColor:(UIColor *)color selectCommand:(RACCommand *)selectCommand {
    self = [super initWithFrame:CGRectZero];
    if (self != nil) {
        _color = color;
        _selectCommand = selectCommand;
        
        self.backgroundColor = color;
        self.layer.cornerRadius = 8.0;
        
        @weakify(self);
        
        UIGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:nil action:nil];
        [[gestureRecognizer.rac_gestureSignal
            filter:^BOOL(UIGestureRecognizer *gesture) {
                return (gesture.state == UIGestureRecognizerStateRecognized);
            }] subscribeNext:^(id _) {
                @strongify(self);
                [self.selectCommand execute:self.color];
            }];
        [self addGestureRecognizer:gestureRecognizer];
    }
    return self;
}

@end
