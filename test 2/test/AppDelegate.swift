//
//  AppDelegate.swift
//  test
//
//  Created by adam on 2023/8/15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = RegisterTableViewController.init()
        vc.view.backgroundColor = UIColor.yellow
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }

 

}

