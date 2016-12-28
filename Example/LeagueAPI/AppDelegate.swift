//
//  AppDelegate.swift
//  LeagueAPI
//
//  Created by Mason Phillips on 12/26/2016.
//  Copyright (c) 2016 Mason Phillips. All rights reserved.
//

import UIKit
import LeagueAPI
import MMDrawerController

// Application-wide Declarations
let LeagueAPIWrapper: MSCoreLeagueApi = MSCoreLeagueApi(withKey: "84361dd6-8ee9-4f8f-902b-6a3cc52672cf", usingRegion: .northAmerica)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var drawerController: MMDrawerController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let controller = ViewController()
        let navController = UINavigationController(rootViewController: controller)
        
        let menu = menuTableViewController()
        
        drawerController = MMDrawerController(center: navController, leftDrawerViewController: menu)
        drawerController?.openDrawerGestureModeMask = .all
        drawerController?.closeDrawerGestureModeMask = .all
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = drawerController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

