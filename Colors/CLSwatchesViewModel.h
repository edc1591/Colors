//
//  CLSwatchesViewModel.h
//  Colors
//
//  Created by Evan Coleman on 7/22/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLAPIClient;

@interface CLSwatchesViewModel : NSObject

// Input: UIColor
@property (nonatomic, readonly) RACCommand *selectSwatchCommand;

// Input: NSNumber
@property (nonatomic, readonly) RACCommand *changeBrightnessCommand;

@property (nonatomic, readonly) NSArray *colors;

- (instancetype)initWithAPIClient:(CLAPIClient *)apiClient;

@end
