//
//  CLAPIClient.m
//  Colors
//
//  Created by Evan Coleman on 7/20/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "CLAPIClient.h"

@implementation CLAPIClient

- (instancetype)init {
    self = [super initWithBaseURL:[NSURL URLWithString:@"https://api.spark.io/v1/devices/core"]];
    if (self != nil) {
        
    }
    return self;
}

- (RACSignal *)animations {
    return [self get]
}

@end
