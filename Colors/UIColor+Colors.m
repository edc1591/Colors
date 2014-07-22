//
//  UIColor+Colors.m
//  Colors
//
//  Created by Evan Coleman on 7/22/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "UIColor+Colors.h"

#pragma mark - Utility functions

UIColor *UIColorFromRGB(NSUInteger r, NSUInteger g, NSUInteger b) {
    return UIColorFromRGBA(r, g, b, 1.0);
}

UIColor *UIColorFromRGBA(NSUInteger r, NSUInteger g, NSUInteger b, CGFloat a) {
    return [UIColor colorWithRed:(r == 0 ? 0 : (r / 255.0))
                           green:(g == 0 ? 0 : (g / 255.0))
                            blue:(b == 0 ? 0 : (b / 255.0))
                           alpha:a];
}

@implementation UIColor (Colors)

#pragma mark Color constants

#pragma mark Helpers

- (NSString *)rgbString {
    CGFloat r, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    
    return [NSString stringWithFormat:@"%f,%f,%f", r, g, b];
}

@end
