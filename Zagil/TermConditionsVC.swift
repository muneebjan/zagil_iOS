//
//  TermConditionsVC.swift
//  Zagil
//
//  Created by Apple on 27/12/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import CYLTabBarController

class TermConditionsVC: UIViewController {

    
    // MARK:- VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if(UserDefaults.standard.bool(forKey: "isRemembered")){
            print("isRemember = true")
//            if(UserDefaults.standard.bool(forKey: "signOut")){
//                UserDefaults.standard.set(false, forKey: "signOut")
//                UserDefaults.standard.synchronize()
//                self.navigationController?.popToRootViewController(animated: true)
//            }
        }else{
            if(UserDefaults.standard.bool(forKey: "signOut")){
                UserDefaults.standard.set(false, forKey: "signOut")
                UserDefaults.standard.synchronize()
                self.navigationController?.popToRootViewController(animated: true)
            }
            else{
                print("signOut is False")
            }
        }
        

        
        
    }
    
    // MARK:- VIEW DIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        
    }
    
    @IBAction func agreeButton(_ sender: Any) {
        print("button pressed")
        let mainTabBarVc = MainTabBarController(viewControllers: self.viewControllers(), tabBarItemsAttributes: self.tabBarItemsAttributesForController())
        mainTabBarVc.selectedIndex = 2
        mainTabBarVc.modalPresentationStyle = .fullScreen
        self.present(mainTabBarVc, animated: true, completion: nil)
        
    }
    
    

    
    func viewControllers() -> [UINavigationController]{
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileController = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        
        let shipmentVC = storyBoard.instantiateViewController(withIdentifier: "shipmentViewController") as! shipmentViewController

        
        
        let home = UINavigationController(rootViewController: HomeViewController())
        let shipment = UINavigationController(rootViewController: shipmentVC)
        let message = UINavigationController(rootViewController: MessageViewController())
        let profile =   UINavigationController(rootViewController: profileController)
        let viewControllers = [home, shipment, message, profile]
        
        return viewControllers
        
    }
    

    func tabBarItemsAttributesForController() ->  [[String : String]] {
        
        let tabBarItemOne = [CYLTabBarItemTitle:"",
                             CYLTabBarItemImage:"TBaeroplaneU",
                             CYLTabBarItemSelectedImage:"TBaeroplaneS"]
        
        let tabBarItemTwo = [CYLTabBarItemTitle:"",
                             CYLTabBarItemImage:"TBshipmentU",
                             CYLTabBarItemSelectedImage:"TBshipmentS"]
        
        let tabBarItemThree = [CYLTabBarItemTitle:"",
                               CYLTabBarItemImage:"TBbellU",
                               CYLTabBarItemSelectedImage:"TBbellS"]
        
        let tabBarItemFour = [CYLTabBarItemTitle:"",
                              CYLTabBarItemImage:"TBprofile1",
                              CYLTabBarItemSelectedImage:"TBprofile"]
        let tabBarItemsAttributes = [tabBarItemOne,tabBarItemTwo,tabBarItemThree,tabBarItemFour]
        return tabBarItemsAttributes
    }
}
