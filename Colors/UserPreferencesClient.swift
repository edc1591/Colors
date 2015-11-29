//
//  UserPreferencesClient.swift
//  Colors
//
//  Created by Evan Coleman on 11/28/15.
//  Copyright © 2015 Evan Coleman. All rights reserved.
//

import ReactiveCocoa

struct UserPreferencesClient {
    static let LoggedInUsernameKey = "LoggedInUsernameKey"
    static let SelectedDeviceIdentifierKey = "SelectedDeviceIdentifierKey"
    
    static func set(obj: AnyObject?, key: String) -> SignalProducer<AnyObject?, NoError> {
        return SignalProducer<AnyObject?, NoError> { s, _ in
            NSUserDefaults.standardUserDefaults().setObject(obj, forKey: key)
            sendNext(s, obj)
            sendCompleted(s)
        }
    }
    
    static func get(key: String) -> SignalProducer<AnyObject?, NoError> {
        return SignalProducer<AnyObject?, NoError> { s, _ in
            let obj = NSUserDefaults.standardUserDefaults().objectForKey(key)
            sendNext(s, obj)
            sendCompleted(s)
        }
    }
    
    static func observe(key: String) -> SignalProducer<AnyObject?, NoError> {
        return NSNotificationCenter.defaultCenter()
            .rac_addObserverForName(NSUserDefaultsDidChangeNotification, object: nil)
            .startWith(NSNotification(name: NSUserDefaultsDidChangeNotification, object: NSUserDefaults.standardUserDefaults()))
            .toSignalProducer()
            .flatMapError({ _ -> SignalProducer<AnyObject?, NoError> in
                return SignalProducer<AnyObject?, NoError>(value: nil)
            })
            .map({ notification -> AnyObject? in
                let defaults = notification!.object as! NSUserDefaults
                return defaults.dictionaryRepresentation()[key]
            })
            .skipRepeats({ (obj1, obj2) -> Bool in
                return obj1 === obj2
            })
    }
}