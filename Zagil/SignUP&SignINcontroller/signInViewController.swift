//
//  signInViewController.swift
//  Zagil
//
//  Created by Apple on 05/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import MBProgressHUD

class signInViewController: UIViewController {
    
    // MARK:- IB OUTLETS
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    
    // MARK:- VARIABLES
    
    // MARK:- VIEW FUNCTIONS
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextfield.text = "shami@gmail.com"
        self.passwordTextfield.isSecureTextEntry = true
        self.passwordTextfield.text = "123456"

        // Do any additional setup after loading the view.
    }
    
    // MARK:- IB ACTIONS
    
    @IBAction func checkbox(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
        }
        else{
            sender.isSelected = true
        }
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
         if(emailTextfield.text == ""){
             ToastView.shared.short(self.view, txt_msg: "Email Textfield is empty")
         }else if(passwordTextfield.text == ""){
            ToastView.shared.short(self.view, txt_msg: "Password Textfield is empty")
         }else{
             if(self.isValidEmail(self.emailTextfield.text!)){
                 
                 if(passwordTextfield.text == "123456"){
                     
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyBoard.instantiateViewController(withIdentifier: "TermConditionsVC") as! TermConditionsVC
                    controller.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(controller, animated: true)
                 }
        
             }else{
                ToastView.shared.short(self.view, txt_msg: "Email is Invalid")
            }
         }
         
    }
 
    @IBAction func loginWithFB(_ sender: UIButton) {
        print("login with facebook")
    }
    @IBAction func loginWithGoogle(_ sender: UIButton) {
        print("login with google")
    }
 
    @IBAction func signUpHandler(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "signUpViewController") as! signUpViewController
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK:- CUSTOM FUNCTIONS
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}

extension signInViewController {
    
    // MARK:- SIGN-IN API CALLING FUNCTIOn
    private func signInFunction(password: String, email: String)
    {
        
        MBProgressHUD.showAdded(to: self.view, animated: true);
        guard AppUtil.isInternetConnected() == true else {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showAlertView(titleStr: "No internet Connection", messageStr: "")
            return
        }
        
        var baseUrl =  AppUtil.getBaseUrl()
        baseUrl = baseUrl.appending("/api/v1/user/login")
        
        let parameter = ["password" : password,
                         "email" : email] as [String : Any]
        
        APIManager.getAPIRequest(baseUrl, parameter: parameter , dataResponse: { (dataResponse) in
            if dataResponse.response?.statusCode == 200
            {
                let mainResponse =  dataResponse.result.value
                if (mainResponse is [Any])
                {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let array = mainResponse as! NSArray
                    let mainDict = array[0] as! NSDictionary
                    //                    let id = mainDict.value(forKey: "id") as! Int
                    
                }
                else if (mainResponse is [AnyHashable : Any])
                {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                
            } // if
            else
            {
            }
            
        }) { (error) -> Void in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showAlertView(titleStr: "No Response Received", messageStr: "")
        }
    } // end method
    
}

