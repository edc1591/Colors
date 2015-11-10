//
//  OSAPIClient+RACSupport.m
//  ObjectiveSpark
//
//  Created by Evan Coleman on 7/22/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "OSAPIClient+RACSupport.h"

@implementation OSAPIClient (RACSupport)

- (RACSignal *)rac_callFunction:(NSString *)func parameter:(NSString *)param {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self callFunction:func parameter:param completion:^(id responseObject, NSError *error) {
            if (error != nil) {
                [subscriber sendError:error];
            } else {
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            }
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (RACSignal *)rac_readVariable:(NSString *)var {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self readVariable:var completion:^(id responseObject, NSError *error) {
            if (error != nil) {
                [subscriber sendError:error];
            } else {
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            }
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

@end
