//
//  OSAPIClient+RACSupport.h
//  ObjectiveSpark
//
//  Created by Evan Coleman on 7/22/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "OSAPIClient.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface OSAPIClient (RACSupport)

/// Returns a RACSignal that calls a function, sends the return value and then completes. Can also send an error.
- (RACSignal *)rac_callFunction:(NSString *)func parameter:(NSString *)param;

/// Returns a RACSignal that reads a variable, sends the value and then completes. Can also send an error.
- (RACSignal *)rac_readVariable:(NSString *)var;

@end
