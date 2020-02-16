//
//  firstViewController.swift
//  Zagil
//
//  Created by Apple on 05/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//


import UIKit
import CYLTabBarController

class firstViewController: UIViewController {

    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = true
        
        if(UserDefaults.standard.bool(forKey: "isRemembered")){
            print("printing is remeber = true")
            // setting user defualts data to model
            
            let preferences = UserDefaults.standard
            
            UserModel.userInstance.userid = preferences.value(forKey: "userid") as? Int
            UserModel.userInstance.email = preferences.value(forKey: "email") as? String
            UserModel.userInstance.password = preferences.value(forKey: "password") as? String
            UserModel.userInstance.phone = preferences.value(forKey: "phone") as? String
            UserModel.userInstance.image = preferences.value(forKey: "image") as? String
            UserModel.userInstance.name = preferences.value(forKey: "name") as? String
            UserModel.userInstance.uid = preferences.value(forKey: "uid") as? Int
            UserModel.userInstance.username = preferences.value(forKey: "username") as? String
            UserModel.userInstance.birthday = preferences.value(forKey: "birthday") as? String
            UserModel.userInstance.address = preferences.value(forKey: "address") as? String
            UserModel.userInstance.FId = preferences.value(forKey: "f_id") as? String
            UserModel.userInstance.feedback = preferences.value(forKey: "feedback") as? String
            UserModel.userInstance.GId = preferences.value(forKey: "g_id") as? String
            
            self.pushDashBoardControllers()
            
        }else{
            print("printing is remeber = false")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signInButton.layer.borderWidth = 1;
        signInButton.layer.cornerRadius=22;
        signInButton.layer.borderColor = UIColor(red: 70/255, green: 182/255, blue: 173/255, alpha: 1).cgColor
        
        
        
        
    }

    @IBAction func createAccountHandler(_ sender: Any) {
        
        print("create account pressed")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "signUpViewController") as! signUpViewController
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
    @IBAction func signInHandler(_ sender: Any) {
        
        print("status of signOut: \(UserDefaults.standard.bool(forKey: "signOut"))")
        UserDefaults.standard.set(false, forKey: "signOut")
        UserDefaults.standard.synchronize()
        print("status of signOut: \(UserDefaults.standard.bool(forKey: "signOut"))")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "signInViewController") as! signInViewController
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    
}

// extension UIcolor

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

// STARTING DASHBOARD IF USER CHECK (IS REMEMBER)
extension firstViewController {
    
    func pushDashBoardControllers() {
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
