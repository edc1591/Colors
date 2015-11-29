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
    private(set) lazy var selectDeviceAction: Action<DeviceViewModel, Array<DeviceViewModel>, NoError> = {
        return Action<DeviceViewModel, Array<DeviceViewModel>, NoError> { [unowned self] viewModel in
            let isSelect = !self.selectedDeviceViewModels.value.contains({ (d) -> Bool in
                return d === viewModel
            })
            var selectedViewModels =
                self.selectedDeviceViewModels.value
                    .filter({ (deviceViewModel) -> Bool in
                        return deviceViewModel.identifier != viewModel.identifier
                    })
            if isSelect {
                selectedViewModels.append(viewModel)
            }
            
            return UserPreferencesClient.set(selectedViewModels.map({ d in d.identifier }), key: UserPreferencesClient.SelectedDeviceIdentifiersKey)
                .map({ _ -> Array<DeviceViewModel> in
                    return selectedViewModels
                })
        }
    }()
    let selectedDeviceViewModels: MutableProperty<Array<DeviceViewModel>>
    
    init() {
        self.viewModels = MutableProperty<Array<DeviceViewModel>>([])
        self.selectedDeviceViewModels = MutableProperty<Array<DeviceViewModel>>([])
        
        self.loadDevicesAction = Action<Void, Array<DeviceViewModel>, NSError> { _ in
            return APIClient.devices()
                .map({ devices -> Array<DeviceViewModel> in
                    return devices.map({ device -> DeviceViewModel in
                        return DeviceViewModel(device: device)
                    })
                })
        }
        
        self.selectedDeviceViewModels <~ self.selectDeviceAction.values
        
        self.viewModels <~ self.loadDevicesAction.values
        
        self.loadDevicesAction.apply()
            .combineLatestWith(UserPreferencesClient.get(UserPreferencesClient.SelectedDeviceIdentifiersKey).promoteErrors(ActionError<NSError>))
            .startWithNext { [unowned self] (deviceViewModels, selectedIdentifiers) in
                if let IDs = selectedIdentifiers as? [String] {
                    self.selectedDeviceViewModels.value =
                        deviceViewModels.filter({ viewModel -> Bool in
                            return IDs.contains(viewModel.identifier)
                        })
                } else if let deviceViewModel = deviceViewModels.first {
                    self.selectDeviceAction.apply(deviceViewModel).start()
                }
            }
    }
}
