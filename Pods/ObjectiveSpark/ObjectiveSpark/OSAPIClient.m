//
//  OSAPIClient.m
//  ObjectiveSpark
//
//  Created by Evan Coleman on 7/22/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "OSAPIClient.h"

@implementation OSAPIClient

- (instancetype)initWithAccessToken:(NSString *)accessToken deviceID:(NSString *)deviceID {
    NSString *urlString = [NSString stringWithFormat:@"https://api.spark.io/v1/devices/%@", deviceID];
    self = [super initWithBaseURL:[NSURL URLWithString:urlString]];
    if (self != nil) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSString *authString = [NSString stringWithFormat:@"Bearer %@", accessToken];
        [self.requestSerializer setValue:authString forHTTPHeaderField:@"Authorization"];
        
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

- (NSURLSessionDataTask *)callFunction:(NSString *)func parameter:(NSString *)param completion:(void (^)(id, NSError *))completion {
    return [self POST:func parameters:@{@"args": param} success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion != nil) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion != nil) {
            completion(nil, error);
        }
    }];
}

- (NSURLSessionDataTask *)readVariable:(NSString *)var completion:(void (^)(id, NSError *))completion {
    // Spark truncates variable names after the 12th character
    if (var.length > 12) {
        var = [var substringToIndex:12];
    }
    return [self GET:var parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion != nil) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion != nil) {
            completion(nil, error);
        }
    }];
}

@end
