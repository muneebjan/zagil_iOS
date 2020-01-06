//
//  SettingsViewController.swift
//  Zagil
//
//  Created by Apple on 28/12/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import CYLTabBarController

class SettingsViewController: UIViewController {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:- UI ACTIVITY CONTROLLER FUNCTION
    
    func inviteActiviyController() {
        let items = ["www.google.com"]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    //MARK:- UI ALERT FUNCTION
    func signOutAlertFunc() {
        
        let alertController = UIAlertController(title: "Signing Out?", message: "Are you sure to Sign Out", preferredStyle: .alert)
                
        let action1 = UIAlertAction(title: "Sign Out", style: .default) { (action:UIAlertAction) in
            print("signing out process");
        }

        let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }

        alertController.addAction(action1)
        alertController.addAction(action2)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- IBACTION
    
    @IBAction func manageNotificationButton(_ sender: Any) {
        print("manage pressed")
    }
    @IBAction func inviteFriendButton(_ sender: Any) {
        print("invite Friend pressed")
        self.inviteActiviyController()
    }
    @IBAction func feedbackButton(_ sender: Any) {
        print("feedback pressed")
    }
    @IBAction func privacyButton(_ sender: Any) {
        print("privacy pressed")
    }
    @IBAction func termsButton(_ sender: Any) {
        print("terms pressed")
    }
    @IBAction func signOutButton(_ sender: Any) {
        print("signout pressed")
        self.signOutAlertFunc()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
