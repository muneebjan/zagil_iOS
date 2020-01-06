//
//  firstViewController.swift
//  Zagil
//
//  Created by Apple on 05/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//


import UIKit

class firstViewController: UIViewController {

    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = true
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
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "signInViewController") as! signInViewController
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    
}

