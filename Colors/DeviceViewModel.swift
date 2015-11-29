//
//  DeviceViewModel.swift
//  Colors
//
//  Created by Evan Coleman on 11/28/15.
//  Copyright © 2015 Evan Coleman. All rights reserved.
//

import Spark_SDK
import ReactiveCocoa
import UIKit

class DeviceViewModel: ViewModel {
    private let device: SparkDevice
    
    let setColorAction: Action<UIColor, Int, NSError>
    
    let name: String
    let identifier: String
    
    init(device: SparkDevice) {
        self.device = device
        
        self.name = self.device.name
        self.identifier = self.device.id
        
        self.setColorAction = Action<UIColor, Int, NSError> { color in
            return SignalProducer<Int, NSError> { sink, _ in
                device.callFunction("set_color", withArguments: color.rgbArray(), completion: { (retVal, error) in
                    if let e = error {
                        sendError(sink, e)
                    } else {
                        sendNext(sink, retVal.integerValue)
                        sendCompleted(sink)
                    }
                })
            }
        }
    }
}
