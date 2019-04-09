//
//  AppDelegate.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/8/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let examplesVC = Bundle.main.loadNibNamed("ExamplesTableViewController", owner: self, options: nil)?.first as? ExamplesTableViewController {
            window?.rootViewController = UINavigationController(rootViewController: examplesVC)
            window?.makeKeyAndVisible()
        }
        return true
    }

}

