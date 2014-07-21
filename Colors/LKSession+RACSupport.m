//
//  LKSession+RACSupport.m
//  Colors
//
//  Created by Evan Coleman on 7/20/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "LKSession+RACSupport.h"

@implementation LKSession (RACSupport)

- (RACSignal *)rac_openSessionWithUsername:(NSString *)username password:(NSString *)password {
    return [RACSignal defer:^RACSignal *{
        RACSubject *subject = [RACSubject subject];
        
        [self openSessionWithUsername:username password:password completion:^(NSDictionary *userDict) {
            [subject sendNext:userDict];
            [subject sendCompleted];
        }];
        
        return subject;
    }];
}

- (RACSignal *)rac_resumeSession {
    return [RACSignal defer:^RACSignal *{
        RACSubject *subject = [RACSubject subject];
        
        [self resumeSessionWithCompletion:^{
            [subject sendCompleted];
        }];
        
        return subject;
    }];
}

- (RACSignal *)rac_state {
    return [RACSignal defer:^RACSignal *{
        RACSubject *subject = [RACSubject subject];
        
        [self queryStateWithBlock:^(LKEvent *state) {
            [subject sendNext:state];
            [subject sendCompleted];
        }];
        
        return subject;
    }];
}

- (RACSignal *)rac_animations {
    return [RACSignal defer:^RACSignal *{
        RACSubject *subject = [RACSubject subject];
        
        [self queryAnimationsWithBlock:^(NSArray *animations) {
            [subject sendNext:animations];
            [subject sendCompleted];
        }];
        
        return subject;
    }];
}

@end
