//
//  AFHTTPSessionManager+RACSupport.h
//  Colors
//
//  Created by Evan Coleman on 7/20/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFHTTPSessionManager (RACSupport)

- (RACSignal *)rac_get:(NSString *)path parameters:(NSDictionary *)params;
- (RACSignal *)rac_put:(NSString *)path parameters:(NSDictionary *)params;

@end
