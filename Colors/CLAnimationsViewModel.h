//
//  CLAnimationsViewModel.h
//  Colors
//
//  Created by Evan Coleman on 7/24/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLAPIClient;

@interface CLAnimationsViewModel : NSObject

@property (nonatomic, readonly) NSArray *animations;

@property (nonatomic, readonly) RACCommand *sendAnimationCommand;

@property (nonatomic) CLAPIClient *apiClient;

- (instancetype)initWithAPIClient:(CLAPIClient *)apiClient;

@end
