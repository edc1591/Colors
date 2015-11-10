//
//  OSAPIClient.h
//  ObjectiveSpark
//
//  Created by Evan Coleman on 7/22/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface OSAPIClient : AFHTTPSessionManager

/// Creates a new OSAPIClient with a given access token and device ID.
- (instancetype)initWithAccessToken:(NSString *)accessToken deviceID:(NSString *)deviceID;

/// Calls a given function on the Spark Core.
- (NSURLSessionDataTask *)callFunction:(NSString *)func parameter:(NSString *)param completion:(void (^)(id responseObject, NSError *error))completion;
/// Reads a given variable on the Spark Core.
- (NSURLSessionDataTask *)readVariable:(NSString *)var completion:(void (^)(id responseObject, NSError *error))completion;

@end
