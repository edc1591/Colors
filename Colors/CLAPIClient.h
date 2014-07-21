//
//  CLAPIClient.h
//  Colors
//
//  Created by Evan Coleman on 7/20/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface CLAPIClient : AFHTTPSessionManager

- (RACSignal *)animations;

@end
