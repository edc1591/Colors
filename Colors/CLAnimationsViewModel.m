//
//  CLAnimationsViewModel.m
//  Colors
//
//  Created by Evan Coleman on 7/24/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "CLAnimationsViewModel.h"

#import "CLAPIClient.h"

@interface CLAnimationsViewModel ()

@property (nonatomic) RACCommand *sendAnimationCommand;

@property (nonatomic) NSArray *animations;

@end

@implementation CLAnimationsViewModel

- (instancetype)initWithAPIClient:(CLAPIClient *)apiClient {
    self = [super init];
    if (self != nil) {
        _apiClient = apiClient;
        
        @weakify(self);
        _sendAnimationCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(RACTuple *tuple) {
            @strongify(self);
            RACTupleUnpack(NSNumber *name, NSNumber *interval, NSNumber *brightness) = tuple;
            return [self.apiClient setAnimation:name brightness:[brightness doubleValue] speed:[interval doubleValue]];
        }];
        
        RAC(self, animations) = [[_apiClient animations] catchTo:[RACSignal return:nil]];
    }
    return self;
}

@end
