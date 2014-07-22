//
//  AFHTTPSessionManager+RACSupport.m
//  Colors
//
//  Created by Evan Coleman on 7/20/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "AFHTTPSessionManager+RACSupport.h"

@implementation AFHTTPSessionManager (RACSupport)

- (RACSignal *)rac_get:(NSString *)path parameters:(NSDictionary *)params {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:RACTuplePack(task, responseObject)];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
}

- (RACSignal *)rac_post:(NSString *)path parameters:(NSDictionary *)params {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self POST:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:RACTuplePack(task, responseObject)];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
}

@end
