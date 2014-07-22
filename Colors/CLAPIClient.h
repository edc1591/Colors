//
//  CLAPIClient.h
//  Colors
//
//  Created by Evan Coleman on 7/20/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import <ObjectiveSpark/OSAPIClient+RACSupport.h>

typedef NS_ENUM(NSUInteger, CLAnimationType) {
    CLAnimationTypeNone,
    CLAnimationTypeRainbow,
    CLAnimationTypeRainbowCycle,
    CLAnimationTypeColorWipe,
    CLAnimationTypeBounce,
};

@interface CLAPIClient : OSAPIClient

- (RACSignal *)animations;
- (RACSignal *)currentState;
- (RACSignal *)setColor:(UIColor *)color;
- (RACSignal *)setAnimation:(CLAnimationType)animation brightness:(CGFloat)brightness speed:(CGFloat)speed;

@end
