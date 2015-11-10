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
    return [[self rac_readVariable:@"animations"]
                map:^NSArray *(NSDictionary *value) {
                    return [value[@"result"] componentsSeparatedByString:@","];
                }];
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

- (RACSignal *)setAnimation:(NSNumber *)animation brightness:(CGFloat)brightness speed:(CGFloat)speed {
    NSLog(@"Sending animation: %@, brightness: %f, speed: %f", animation, brightness, speed);
    NSString *params = [NSString stringWithFormat:@"%@,%0.0f,%0.0f", animation, speed, brightness];
    return [self rac_callFunction:@"animate" parameter:params];
}

@end
