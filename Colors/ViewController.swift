//
//  ViewController.swift
//  Colors
//
//  Created by Evan Coleman on 11/28/15.
//  Copyright © 2015 Evan Coleman. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {
    let viewModel: ViewModel!
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        let appear = self.rac_signalForSelector(Selector("viewDidAppear:")).toSignalProducer().map { _ in true }.flatMapError { _ in SignalProducer<Bool, NoError>.empty }
        let disappear = self.rac_signalForSelector(Selector("viewWillDisappear:")).toSignalProducer().map { _ in false }.flatMapError { _ in SignalProducer<Bool, NoError>.empty }
        let presented = SignalProducer<SignalProducer<Bool, NoError>, NoError>(values: [appear, disappear]).flatten(FlattenStrategy.Merge)
        
        let currentState = SignalProducer<Bool, NoError>(value: (UIApplication.sharedApplication().applicationState == .Active))
        let didBecomeActive = NSNotificationCenter.defaultCenter().rac_notifications(UIApplicationDidBecomeActiveNotification, object: nil).map { _ in true }
        let willResignActive = NSNotificationCenter.defaultCenter().rac_notifications(UIApplicationWillResignActiveNotification, object: nil).map { _ in false }
        let appActive = SignalProducer<SignalProducer<Bool, NoError>, NoError>(values: [currentState, didBecomeActive, willResignActive]).flatten(FlattenStrategy.Merge)
        
        combineLatest(presented, appActive)
            .map { presented, active in presented && active }
            .startWithNext({ [weak self] active in
                if let viewModel = self?.viewModel {
                    viewModel.active.value = active
                }
                })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
