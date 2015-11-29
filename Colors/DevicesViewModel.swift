//
//  DevicesViewModel.swift
//  Colors
//
//  Created by Evan Coleman on 11/28/15.
//  Copyright © 2015 Evan Coleman. All rights reserved.
//

import ReactiveCocoa
import Spark_SDK

class DevicesViewModel: ViewModel {
    let viewModels: MutableProperty<Array<DeviceViewModel>>
    let loadDevicesAction: Action<Void, Array<DeviceViewModel>, NSError>
    let selectDeviceAction: Action<DeviceViewModel, DeviceViewModel?, NoError>
    let selectedDeviceViewModel: MutableProperty<DeviceViewModel?>
    
    init() {
        self.viewModels = MutableProperty<Array<DeviceViewModel>>([])
        self.selectedDeviceViewModel = MutableProperty<DeviceViewModel?>(nil)
        
        self.loadDevicesAction = Action<Void, Array<DeviceViewModel>, NSError> { _ in
            return APIClient.devices()
                .map({ devices -> Array<DeviceViewModel> in
                    return devices.map({ device -> DeviceViewModel in
                        return DeviceViewModel(device: device)
                    })
                })
        }
        
        self.selectDeviceAction = Action<DeviceViewModel, DeviceViewModel?, NoError> { viewModel in
            return UserPreferencesClient.set(viewModel.identifier, key: UserPreferencesClient.SelectedDeviceIdentifierKey)
                .map({ _ -> DeviceViewModel? in
                    return viewModel
                })
        }
        self.selectedDeviceViewModel <~ self.selectDeviceAction.values
        
        self.viewModels <~ self.loadDevicesAction.values
        
        self.loadDevicesAction.apply()
            .combineLatestWith(UserPreferencesClient.get(UserPreferencesClient.SelectedDeviceIdentifierKey).promoteErrors(ActionError<NSError>))
            .startWithNext { [unowned self] (deviceViewModels, selectedIdentifier) in
                if let ID = selectedIdentifier as? String {
                    self.selectedDeviceViewModel.value =
                        deviceViewModels.filter({ viewModel -> Bool in
                            return viewModel.identifier == ID
                        }).first
                } else if let deviceViewModel = deviceViewModels.first {
                    self.selectDeviceAction.apply(deviceViewModel).start()
                }
            }
    }
}
