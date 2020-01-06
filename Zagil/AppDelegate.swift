////
////  AppDelegate.swift
////  Zagil
////
////  Created by Apple on 26/12/2019.
////  Copyright © 2019 Apple. All rights reserved.
////
//
//import UIKit
//import CYLTabBarController
//
//@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        CYLPlusButtonSubclass.register()
//        return true
//    }
//
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
//
//
//}

//
//  AppDelegate.swift


import UIKit
import CYLTabBarController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UITabBarControllerDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        CYLPlusButtonSubclass.register()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rootController = storyBoard.instantiateViewController(withIdentifier: "firstViewController") as! firstViewController
//        let rootController = storyBoard.instantiateViewController(withIdentifier: "TermConditionsVC") as! TermConditionsVC
        self.window = UIWindow()
        self.window?.frame  = UIScreen.main.bounds
        self.window?.rootViewController = UINavigationController(rootViewController: rootController) //rootController // changes here

        self.window?.makeKeyAndVisible()
        
        UITabBar.appearance().backgroundColor = UIColor.white
        
        return true
    }

}
