//
//  AppDelegate.swift
//  ElementaryMath
//
//  Created by Maxim Spiridonov on 22/03/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let welcomeController = storyboard.instantiateViewController(withIdentifier: "HomeVC")
        let navigationController = UINavigationController(rootViewController: welcomeController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        
        return true
    }


}

