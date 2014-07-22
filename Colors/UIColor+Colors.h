//
//  UIColor+Colors.h
//  Colors
//
//  Created by Evan Coleman on 7/22/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Utility functions

extern UIColor *UIColorFromRGB(NSUInteger r, NSUInteger g, NSUInteger b);
extern UIColor *UIColorFromRGBA(NSUInteger r, NSUInteger g, NSUInteger b, CGFloat a);

@interface UIColor (Colors)

#pragma mark Color constants

#pragma mark Helpers

- (NSString *)rgbString;

@end
