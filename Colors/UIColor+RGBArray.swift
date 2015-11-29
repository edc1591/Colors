//
//  UIColor+RGBArray.swift
//  Colors
//
//  Created by Evan Coleman on 11/29/15.
//  Copyright © 2015 Evan Coleman. All rights reserved.
//

import UIKit

extension UIColor {
    func rgbArray() -> Array<CGFloat> {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return [r * 255, g * 255, b * 255]
    }
}
