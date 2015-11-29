//
//  AppWindowModel.swift
//  Colors
//
//  Created by Evan Coleman on 11/28/15.
//  Copyright © 2015 Evan Coleman. All rights reserved.
//

import ReactiveCocoa

class AppWindowModel: ViewModel {
    let rootViewModel: MutableProperty<ViewModel?>

    init() {
        rootViewModel = MutableProperty<ViewModel?>(nil)
        
        rootViewModel <~
            UserPreferencesClient.observe(UserPreferencesClient.LoggedInUsernameKey)
                .map({ obj -> ViewModel in
                    if let _ = obj as? String {
                        return TabBarViewModel()
                    } else {
                        return LoginViewModel()
                    }
                })
    }
}
