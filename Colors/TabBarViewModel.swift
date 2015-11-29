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
            devicesViewModel.selectedDeviceViewModels.producer
                .map({ (viewModels) -> [ViewModel] in
                    return [SwatchViewModel(deviceViewModels: viewModels)]
                })
        
        self.presentDevicesAction = Action<AnyObject, DevicesViewModel, NoError> { _ in
            return SignalProducer<DevicesViewModel, NoError>(value: devicesViewModel)
        }
        
        self.powerOffAction = Action<AnyObject, Int, NoError> { _ in
            let signals = devicesViewModel.selectedDeviceViewModels.value
                .map({ (deviceViewModel) -> SignalProducer<Int, NoError> in
                    return deviceViewModel.setColorAction.apply(UIColor.blackColor())
                        .flatMapError({ _ -> SignalProducer<Int, NoError> in
                            return SignalProducer.empty
                        })
                })
            return SignalProducer<SignalProducer<Int, NoError>, NoError>(values: signals)
                .flatten(FlattenStrategy.Merge)
        }
    }
}
