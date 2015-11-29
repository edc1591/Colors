//
//  APIClient.swift
//  Colors
//
//  Created by Evan Coleman on 11/28/15.
//  Copyright © 2015 Evan Coleman. All rights reserved.
//

import ReactiveCocoa
import Spark_SDK

struct APIClient {
    static func login(username: String, password: String) -> SignalProducer<String, NSError> {
        return SignalProducer<String, NSError> { s, _ in
            SparkCloud.sharedInstance().loginWithUser(username, password: password, completion: { error in
                if let e = error {
                    sendError(s, e)
                } else {
                    sendNext(s, username)
                    sendCompleted(s)
                }
            })
        }
    }
    
    static func devices() -> SignalProducer<Array<SparkDevice>, NSError> {
        return SignalProducer<Array<SparkDevice>, NSError> { s, _ in
            SparkCloud.sharedInstance().getDevices({ devices, error in
                if let e = error {
                    sendError(s, e)
                } else if let d = devices as? [SparkDevice] {
                    sendNext(s, d)
                    sendCompleted(s)
                }
            })
        }
    }
}