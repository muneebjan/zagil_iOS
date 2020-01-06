//
//  ViewController.swift
//  Zagil
//
//  Created by Apple on 26/12/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import CYLTabBarController

class TermConditionVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func agreeButton(_ sender: Any) {
        print("hello")
        
        CYLPlusButtonSubclass.register()
        

        let mainTabBarVc = MainTabBarController(viewControllers: self.viewControllers(), tabBarItemsAttributes: self.tabBarItemsAttributesForController())
        
        mainTabBarVc.hideTabBadgeBackgroundSeparator()
        self.present(mainTabBarVc, animated: true, completion: nil)
        UITabBar.appearance().backgroundColor = UIColor.white
    
        
    }
    
    
    func viewControllers() -> [UINavigationController]{
        let home = UINavigationController(rootViewController: HomeViewController())
        let connection = UINavigationController(rootViewController: ConnectionViewController())
        let message = UINavigationController(rootViewController: MessageViewController())
        let personal =   UINavigationController(rootViewController: PersonalViewController())
        let viewControllers = [home, connection, message, personal]
        
        return viewControllers
        
    }
    

    func tabBarItemsAttributesForController() ->  [[String : String]] {
        
        let tabBarItemOne = [CYLTabBarItemTitle:"首页",
                             CYLTabBarItemImage:"home_normal",
                             CYLTabBarItemSelectedImage:"home_highlight"]
        
        let tabBarItemTwo = [CYLTabBarItemTitle:"同城",
                             CYLTabBarItemImage:"mycity_normal",
                             CYLTabBarItemSelectedImage:"mycity_highlight"]
        
        let tabBarItemThree = [CYLTabBarItemTitle:"消息",
                               CYLTabBarItemImage:"message_normal",
                               CYLTabBarItemSelectedImage:"message_highlight"]
        
        let tabBarItemFour = [CYLTabBarItemTitle:"我的",
                              CYLTabBarItemImage:"account_normal",
                              CYLTabBarItemSelectedImage:"account_highlight"]
        let tabBarItemsAttributes = [tabBarItemOne,tabBarItemTwo,tabBarItemThree,tabBarItemFour]
        return tabBarItemsAttributes
    }
}

