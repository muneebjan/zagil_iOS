//
//  signUpViewController.swift
//  Zagil
//
//  Created by Apple on 05/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//



import UIKit
import MBProgressHUD

class signUpViewController: UIViewController {

    // MARK:- IBOUTLETS
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var continueWithFBview: UIView!
    @IBOutlet weak var continueWithGMview: UIView!
    @IBOutlet weak var fullnameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    // MARK:- VIEW FUNCTIONS
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container.layer.cornerRadius = 20
        continueWithFBview.layer.borderWidth = 2
        continueWithGMview.layer.borderWidth = 2
        continueWithFBview.layer.borderColor = UIColor(red: 70/255, green: 182/255, blue: 173/255, alpha: 1).cgColor
        continueWithGMview.layer.borderColor = UIColor(red: 70/255, green: 182/255, blue: 173/255, alpha: 1).cgColor
    }
    
    
    // MARK:- IB ACTION HANDLERS
    @IBAction func ContinueFacebookHandler(_ sender: Any) {
        print("Continue with fb")
    }
    @IBAction func ContinueGoogleHandler(_ sender: Any) {
        print("Continue with fb")
    }
    @IBAction func createAccountHandler(_ sender: Any) {
        print("Create account pressed")
        self.implementAndCheck()
    }

}

extension signUpViewController {
    
    // MARK:- IMPLEMENTING API WITH CHECKS
    
    func implementAndCheck() {
        
        guard let name = self.fullnameTextfield.text else {
            ToastView.shared.short(self.view, txt_msg: "Please Enter You Name")
            return
        }
        guard let email = self.emailTextfield.text else {
            ToastView.shared.short(self.view, txt_msg: "Please Enter Your Email Address")
            return
        }
        guard let password = self.fullnameTextfield.text else {
            ToastView.shared.short(self.view, txt_msg: "Please Enter Your Password")
            return
        }
        
        if(AppUtil.isValidEmail(email)){
            if(password.count < 6){
                ToastView.shared.short(self.view, txt_msg: "Password must be greater than 6 digits")
            }else{
                // first check email exist or not
                self.signUpFunction(name: name, password: password, email: email)
            }
        }else{
            ToastView.shared.short(self.view, txt_msg: "Please Enter Valid Email Address")
        }
        
    }
    
    // MARK:- CHECK EMAIL EXISTS OR NOT
    
    private func checkingEmailExistsOrNot(name: String, password: String, email: String)
    {
        
        MBProgressHUD.showAdded(to: self.view, animated: true);
        guard AppUtil.isInternetConnected() == true else {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showAlertView(titleStr: "No internet Connection", messageStr: "")
            return
        }
        
        var baseUrl =  AppUtil.getBaseUrl()
        baseUrl = baseUrl.appending("/api/v1/user/emailCheck")
        
        let parameter = ["email" : email] as [String : Any]
        
        APIManager.getAPIRequest(baseUrl, parameter: parameter , dataResponse: { (dataResponse) in
            if dataResponse.response?.statusCode == 200
            {
                let mainResponse =  dataResponse.result.value
                if (mainResponse is [Any])
                {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let array = mainResponse as! NSArray
                    let mainDict = array[0] as! NSDictionary
                    let count = mainDict.value(forKey: "number") as! Int
                    
                    if(count == 0){
                        print("email not exists you may sign up")
                        // calling sign up api
                        self.signUpFunction(name: name, password: password, email: email)
                    }else{
                        print("entered email already exists")
                    }
                    
                    
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
    
    
    // MARK:- SIGNUP API CALLING FUNCTION
    
    private func signUpFunction(name: String, password: String, email: String)
    {
        
        MBProgressHUD.showAdded(to: self.view, animated: true);
        guard AppUtil.isInternetConnected() == true else {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showAlertView(titleStr: "No internet Connection", messageStr: "")
            return
        }
        
        var baseUrl =  AppUtil.getBaseUrl()
        baseUrl = baseUrl.appending("/api/v1/user/signup")
        
        let parameter = ["name" : name,
                         "password" : password,
                         "email" : email] as [String : Any]
        
        APIManager.postAPIRequest(baseUrl, parameter: parameter , dataResponse: { (dataResponse) in
            if dataResponse.response?.statusCode == 200
            {
                let mainResponse =  dataResponse.result.value
                if (mainResponse is [Any])
                {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let array = mainResponse as! NSArray
                    let mainDict = array[0] as! NSDictionary
//                    let userid = mainDict.value(forKey: "id") as! Int
            
                    
                    ToastView.shared.short(self.view, txt_msg: "Sign Up Successfull")
                    self.navigationController?.popToRootViewController(animated: true)
                    
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

extension UIViewController
{
    func showAlertView(titleStr : String, messageStr : String) {
        
        let alertController = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
