//
//  AppDelegate.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 13.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //MARK: - Dark Mode enabled each VC.
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .dark
        }

        return true
    }
}

