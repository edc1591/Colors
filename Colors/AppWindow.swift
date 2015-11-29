//
//  AppWindow.swift
//  Colors
//
//  Created by Evan Coleman on 11/28/15.
//  Copyright © 2015 Evan Coleman. All rights reserved.
//

import UIKit

class AppWindow: UIWindow {
    let windowModel: AppWindowModel

    init (windowModel: AppWindowModel) {
        self.windowModel = windowModel
        
        super.init(frame: UIScreen.mainScreen().bounds)
        
        self.rootViewController = LaunchViewController()
        
        self.windowModel.rootViewModel.producer
            .map({ viewModel -> UIViewController? in
                if let loginViewModel = viewModel as? LoginViewModel {
                    return LoginViewController(viewModel: loginViewModel)
                } else if let tabBarViewModel = viewModel as? TabBarViewModel {
                    return TabBarController(viewModel: tabBarViewModel)
                }
                
                return nil
            })
            .ignoreNil()
            .startWithNext({ [unowned self] viewController in
                self.rootViewController = viewController
            })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
