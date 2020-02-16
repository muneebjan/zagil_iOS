//
//  AppDelegate.swift
//  Zagil
//
//  Created by Apple on 26/12/2019.
//  Copyright © 2019 Apple. All rights reserved.



import UIKit
import GoogleSignIn
import FBSDKCoreKit
import CYLTabBarController
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UITabBarControllerDelegate, GIDSignInDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        // keyboard
        IQKeyboardManager.shared.enable = true
        
        // google maps api key
        GMSServices.provideAPIKey("AIzaSyDY3haY0ul6LaNBKSkBKqKbqABECmXJE5w")
        
        
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = "291118539154-vtlq9h1rpa96hj2b938v89sras9me3nh.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        // facebook
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
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

    
    // [START openurl]
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    // [END openurl]
    // [START openurl_new]
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      return ApplicationDelegate.shared.application(app, open: url, options: options)
    }
    
//    @available(iOS 9.0, *)
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//      return GIDSignIn.sharedInstance().handle(url)
//    }
    
    
    // [END openurl_new]
    // [START signin_handler]
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
      if let error = error {
        if(error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        // [START_EXCLUDE silent]
        NotificationCenter.default.post(
          name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
        // [END_EXCLUDE]
        return
      }
      // Perform any operations on signed in user here.
      let userId = user.userID                  // For client-side use only!
      let idToken = user.authentication.idToken // Safe to send to the server
      let fullName = user.profile.name
      let givenName = user.profile.givenName
      let familyName = user.profile.familyName
      let email = user.profile.email
      // [START_EXCLUDE]
      NotificationCenter.default.post(
        name: Notification.Name(rawValue: "ToggleAuthUINotification"),
        object: nil,
        userInfo: ["statusText": "Signed in user:\n\(fullName!)"])
      // [END_EXCLUDE]
    }
    // [END signin_handler]
    // [START disconnect_handler]
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // [START_EXCLUDE]
      NotificationCenter.default.post(
        name: Notification.Name(rawValue: "ToggleAuthUINotification"),
        object: nil,
        userInfo: ["statusText": "User has disconnected."])
      // [END_EXCLUDE]
    }
    
}
