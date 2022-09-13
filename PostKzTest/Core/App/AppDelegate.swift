//
//  AppDelegate.swift
//  PostKzTest
//
//  Created by Amir on 08.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AuthorizationViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

