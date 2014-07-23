//
//  CLAPIClient.m
//  Colors
//
//  Created by Evan Coleman on 7/20/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "CLAPIClient.h"

@implementation CLAPIClient

- (instancetype)initWithAccessToken:(NSString *)accessToken deviceID:(NSString *)deviceID {
    self = [super initWithAccessToken:accessToken deviceID:deviceID];
    if (self != nil) {
        
    }
    return self;
}

- (RACSignal *)animations {
    return [self rac_readVariable:@"animationNames"];
}

- (RACSignal *)currentState {
    return [self rac_readVariable:@"currentState"];
}

- (RACSignal *)setColor:(UIColor *)color {
    if (color == nil) {
        return [RACSignal error:nil];
    }
    NSLog(@"Setting Color: %@", [color rgbString]);
    return [self rac_callFunction:@"setColor" parameter:[color rgbString]];
}

- (RACSignal *)setAnimation:(CLAnimationType)animation brightness:(CGFloat)brightness speed:(CGFloat)speed {
    @weakify(self);
    return [[[[[RACSignal return:@(animation)]
                map:^NSString *(NSNumber *animation) {
                    CLAnimationType anim = [animation integerValue];
                    if (anim == CLAnimationTypeRainbow) {
                        return @"rainbow";
                    } else if (anim == CLAnimationTypeRainbowCycle) {
                        return @"rainbow_cycle";
                    } else if (anim == CLAnimationTypeColorWipe) {
                        return @"color_wipe";
                    } else if (anim == CLAnimationTypeBounce) {
                        return @"bounce";
                    }
                    return nil;
                }] ignore:nil]
                map:^NSString *(NSString *animation) {
                    return [NSString stringWithFormat:@"%@,%f,%f", animation, brightness, speed];
                }] flattenMap:^RACStream *(NSString *params) {
                    @strongify(self);
                    return [self rac_callFunction:@"animate" parameter:params];
                }];
}

@end
