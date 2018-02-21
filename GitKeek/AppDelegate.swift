//
//  AppDelegate.swift
//  GitKeek
//
//  Created by Sergey on 06.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var startup: StartupService!

    class func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.startup = StartupService(with: window)
        self.startup.setup()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        NotificationCenter.default.post(name: .openUrlNotification, object: nil, userInfo: [S.url: url])
        return true
    }
}

