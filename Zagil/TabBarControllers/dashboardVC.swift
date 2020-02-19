//
//  dashboardVC.swift
//  Zagil
//
//  Created by Apple on 16/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class dashboardVC: UIViewController {

    // MARK:- IBOUTLETS
    @IBOutlet weak var senderButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    
    // MARK:- VARIABLES
    private var senderCheck = false
    private var travelCheck = false
    
    // MARK:- VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        
        print("dashboard view will appear called")
        
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.hidesBottomBarWhenPushed = false
    }
    
    // MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let firstname = UserModel.userInstance.name!
//        print(firstname)
        
        self.senderButton.setImage(UIImage(named: "senderUnselected"), for: .normal)
        self.senderButton.setImage(UIImage(named: "senderSelected"), for: .selected)
        
        self.travelButton.setImage(UIImage(named: "travelUnselected"), for: .normal)
        self.travelButton.setImage(UIImage(named: "travelSelected"), for: .selected)
        
        // experiment here
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
//        controller.signOutDelegate = self
        
    }
    
    //MARK:- IB-ACTIONS
    @IBAction func senderButtonHandler(_ sender: Any) {
        
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                button.isSelected = false
//                self.travelButton.isSelected = true
            } else {
                // set selected
                button.isSelected = true
                if(self.travelButton.isSelected){
                    self.travelButton.isSelected = false
                }
            }
        }
        
    }
    @IBAction func travelButtonHandler(_ sender: Any) {
        
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                button.isSelected = false
            } else {
                // set selected
                button.isSelected = true
                if(self.senderButton.isSelected){
                    self.senderButton.isSelected = false
                }
            }
        }
        
    }
    @IBAction func goButtonHandler(_ sender: Any) {
        
        if((senderButton.isSelected == false) && (travelButton.isSelected == false)){
            ToastView.shared.short(self.view, txt_msg: "Please Choose One Option")
        }else{
            if(senderButton.isSelected){
                print("sender button is selected")
                
                // calling tripfeed screen
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashboardvc = storyBoard.instantiateViewController(withIdentifier: "tripFeedVC") as! tripFeedVC
                dashboardvc.hidesBottomBarWhenPushed = true
                cyl_push(dashboardvc, animated: true)
                
                
            }else if(travelButton.isSelected){
                print("travel button is selected")
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashboardvc = storyBoard.instantiateViewController(withIdentifier: "shipmentFeedVC") as! shipmentFeedVC
                dashboardvc.hidesBottomBarWhenPushed = true
                cyl_push(dashboardvc, animated: true)
                
            }else{
                print("here i am")
            }
        }
        
    }
    
}


