//
//  LoginViewModel.swift
//  Colors
//
//  Created by Evan Coleman on 11/28/15.
//  Copyright © 2015 Evan Coleman. All rights reserved.
//

import ReactiveCocoa

class LoginViewModel: ViewModel {
    let loginAction: Action<(String, String), String, NSError>
    
    init() {
        self.loginAction = Action<(String, String), String, NSError> { (username, password) in
            return APIClient.login(username, password: password)
                .flatMap(FlattenStrategy.Latest, transform: { u -> SignalProducer<String, NSError> in
                    return UserPreferencesClient.set(u, key: UserPreferencesClient.LoggedInUsernameKey)
                        .promoteErrors(NSError)
                        .map({ username in username as! String })
                })
        }
    }
}