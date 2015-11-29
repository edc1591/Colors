//
//  TabBarViewModel.swift
//  Colors
//
//  Created by Evan Coleman on 11/28/15.
//  Copyright © 2015 Evan Coleman. All rights reserved.
//

import ReactiveCocoa
import UIKit

class TabBarViewModel: ViewModel {
    let viewModels: MutableProperty<Array<ViewModel>>
    let presentDevicesAction: Action<AnyObject, DevicesViewModel, NoError>
    let powerOffAction: Action<AnyObject, Int, NoError>
    
    init() {
        let devicesViewModel = DevicesViewModel()
        self.viewModels = MutableProperty<Array<ViewModel>>([])
        
        self.viewModels <~
            devicesViewModel.selectedDeviceViewModel.producer
                .map({ (viewModel) -> Array<ViewModel> in
                    if let selectedViewModel = viewModel {
                        return [SwatchViewModel(deviceViewModel: selectedViewModel)]
                    } else {
                        return []
                    }
                })
        
        self.presentDevicesAction = Action<AnyObject, DevicesViewModel, NoError> { _ in
            return SignalProducer<DevicesViewModel, NoError>(value: devicesViewModel)
        }
        
        self.powerOffAction = Action<AnyObject, Int, NoError> { _ in
            if let deviceViewModel = devicesViewModel.selectedDeviceViewModel.value {
                return deviceViewModel.setColorAction.apply(UIColor.blackColor())
                    .flatMapError({ _ -> SignalProducer<Int, NoError> in
                        return SignalProducer.empty
                    })
            } else {
                return SignalProducer.empty
            }
        }
    }
}
