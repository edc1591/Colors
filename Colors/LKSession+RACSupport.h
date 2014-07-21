//
//  LKSession+RACSupport.h
//  Colors
//
//  Created by Evan Coleman on 7/20/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "LKSession.h"

@interface LKSession (RACSupport)

- (RACSignal *)rac_state;
- (RACSignal *)rac_animations;

@end
