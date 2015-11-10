//
//  CLAPIClient.h
//  Colors
//
//  Created by Evan Coleman on 7/20/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import <ObjectiveSpark/OSAPIClient+RACSupport.h>

@interface CLAPIClient : OSAPIClient

- (RACSignal *)animations;
- (RACSignal *)currentState;
- (RACSignal *)setColor:(UIColor *)color;
- (RACSignal *)setAnimation:(NSNumber *)animation brightness:(CGFloat)brightness speed:(CGFloat)speed;

@end
