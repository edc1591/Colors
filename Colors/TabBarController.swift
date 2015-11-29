//
//  TabBarController.swift
//  Colors
//
//  Created by Evan Coleman on 11/28/15.
//  Copyright © 2015 Evan Coleman. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    let viewModel: TabBarViewModel
    
    var navigationBar: UINavigationBar!
    
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel;
        
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.delegate = self
        
        self.navigationBar = UINavigationBar()
        self.view.addSubview(self.navigationBar)
        
        self.viewModel.viewModels.producer
            .map({ viewModels -> Array<UIViewController> in
                return viewModels.map({ (viewModel) -> UIViewController in
                    if let swatchViewModel = viewModel as? SwatchViewModel {
                        return SwatchViewController(viewModel: swatchViewModel)
                    }
                    
                    // I don't really know how to handle this
                    return UIViewController()
                })
            })
            .startWithNext { [unowned self] viewControllers in
                self.viewControllers = viewControllers
            }
        
        self.viewModel.presentDevicesAction.values
            .observeNext { [unowned self] devicesViewModel in
                let viewController = DevicesViewController(viewModel: devicesViewModel)
                let navigationController = UINavigationController(rootViewController: viewController)
                self.presentViewController(navigationController, animated: true, completion: nil)
            }
        
        let devicesAction = self.viewModel.presentDevicesAction.unsafeCocoaAction
        let devicesButton = UIBarButtonItem(image: UIImage(named: "navigation_settings_normal"), style: UIBarButtonItemStyle.Plain, target: devicesAction, action: CocoaAction.selector)
        
        let offAction = self.viewModel.powerOffAction.unsafeCocoaAction
        let offButton = UIBarButtonItem(title: "Off", style: UIBarButtonItemStyle.Plain, target: offAction, action: CocoaAction.selector)
        
        self.viewModel.viewModels.producer
            .filter { (viewModels) -> Bool in
                return viewModels.count > 0
            }
            .take(1)
            .delay(0.01, onScheduler: QueueScheduler())
            .observeOn(UIScheduler())
            .startWithNext { [unowned self] _ in
                self.navigationBar.items = [(self.selectedViewController?.navigationItem)!]
                self.navigationBar.topItem?.rightBarButtonItem = devicesButton
                self.navigationBar.topItem?.leftBarButtonItem = offButton
            }
        
        self.navigationBar.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(UIApplication.sharedApplication().statusBarFrame.height)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UITabBarControllerDelegate
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        self.navigationBar.items = [viewController.navigationItem]
    }
}
