//
//  AppDelegate.swift
//  RFPDemoSwift
//
//  Created by FreakOut
//  Copyright (c) 2018 FreakOut inc.,. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //==============================
        // RFP Settings
        //==============================

        // Set ad video cache size (default: 100MB)
        //RFP.rfpSetVideoCacheSize(50);

        // Set http timeout(default: 15sec)
        //RFP.rfpSetHttpRequestTimeoutInterval(10.0);

        // Init media
        RFP.rfpInitMedia("3")

        return true
    }

}

