//
//  SwatchViewModel.swift
//  Colors
//
//  Created by Evan Coleman on 11/28/15.
//  Copyright © 2015 Evan Coleman. All rights reserved.
//

import UIKit
import ReactiveCocoa

class SwatchViewModel: ViewModel {
    let colors: Array<UIColor>
    let deviceViewModels: [DeviceViewModel]
    
    init(deviceViewModels: [DeviceViewModel]) {
        self.deviceViewModels = deviceViewModels
        
        var colors: Array<UIColor> = []
        for var angle = 0.0; angle < 360; angle += 10 {
            let h = CGFloat((M_PI / 180.0 * angle) / (2 * M_PI))
            colors.append(UIColor(hue: h, saturation: 1.0, brightness: 1.0, alpha: 1.0))
        }
        self.colors = colors
    }
}