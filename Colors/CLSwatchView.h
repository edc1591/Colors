//
//  CLSwatchView.h
//  Colors
//
//  Created by Evan Coleman on 7/22/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLSwatchView : UIView

- (instancetype)initWithColor:(UIColor *)color selectCommand:(RACCommand *)selectCommand;

@end
