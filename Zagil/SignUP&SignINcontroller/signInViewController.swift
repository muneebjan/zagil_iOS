//
//  signInViewController.swift
//  Zagil
//
//  Created by Apple on 05/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
import MBProgressHUD

class signInViewController: UIViewController, GIDSignInDelegate {
    
    
    // MARK:- IB OUTLETS
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    
    // MARK:- VARIABLES
    private var tickCheck = false
    
    // MARK:- VIEW FUNCTIONS
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        self.emailTextfield.text = "ahtashamhassan0@gmail.com"
        self.passwordTextfield.isSecureTextEntry = true
        self.passwordTextfield.text = "1234567"
        
        // Do any additional setup after loading the view.
    }
    
    // MARK:- IB ACTIONS
    
    @IBAction func checkbox(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            print("tick unchecked")
            self.tickCheck = false
        }
        else{
            sender.isSelected = true
            print("tick checked")
            self.tickCheck = true
        }
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        if(self.tickCheck){
            UserDefaults.standard.set(true, forKey: "isRemembered")
            UserDefaults.standard.synchronize()
        }
        
         if(emailTextfield.text == ""){
             ToastView.shared.short(self.view, txt_msg: "Email Textfield is empty")
         }else if(passwordTextfield.text == ""){
            ToastView.shared.short(self.view, txt_msg: "Password Textfield is empty")
         }else{
             if(self.isValidEmail(self.emailTextfield.text!)){
                 
                self.signInFunction(password: self.passwordTextfield.text!, email: self.emailTextfield.text!)
                
//                 if(passwordTextfield.text == "123456"){
//
//                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let controller = storyBoard.instantiateViewController(withIdentifier: "TermConditionsVC") as! TermConditionsVC
//                    controller.modalPresentationStyle = .fullScreen
//                    self.navigationController?.pushViewController(controller, animated: true)
//                 }
        
             }else{
                ToastView.shared.short(self.view, txt_msg: "Email is Invalid")
            }
         }
         
    }
 
    @IBAction func loginWithFacebook(_ sender: Any) {
        
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
          if let error = error {
            print("Failed to login: \(error.localizedDescription)")
            return
          }
            guard let accessToken = AccessToken.current else {
            print("Failed to get access token")
            return
          }
            

        }
        
    }
    
    @IBAction func loginWithGoogle(_ sender: UIButton) {
        
        print("login with google")
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.signIn()
        
        
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
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error != nil {
            print(error.debugDescription)
        }else{
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "TermConditionsVC") as! TermConditionsVC
            controller.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        
    }
    
}

// MARK:- Extension
extension signInViewController {
    
    // MARK:- SIGN-IN API CALLING FUNCTION
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
        
        let parameter = ["email" : email,
                         "password" : password] as [String : Any]
        
        APIManager.getAPIRequest(baseUrl, parameter: parameter , dataResponse: { (dataResponse) in
            if dataResponse.response?.statusCode == 200
            {
                let mainResponse =  dataResponse.result.value
                if (mainResponse is [Any])
                {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let array = mainResponse as! NSArray
                    let mainDict = array[0] as! NSDictionary
                    
                    UserModel.userInstance.userid = mainDict.value(forKey: "id") as? Int
                    UserModel.userInstance.email = mainDict.value(forKey: "email") as? String
                    UserModel.userInstance.password = mainDict.value(forKey: "password") as? String
                    UserModel.userInstance.phone = mainDict.value(forKey: "phone") as? String
                    UserModel.userInstance.image = mainDict.value(forKey: "image") as? String
                    UserModel.userInstance.name = mainDict.value(forKey: "name") as? String
                    UserModel.userInstance.uid = mainDict.value(forKey: "uid") as? Int
                    UserModel.userInstance.username = mainDict.value(forKey: "username") as? String
                    UserModel.userInstance.birthday = mainDict.value(forKey: "birthday") as? String
                    UserModel.userInstance.address = mainDict.value(forKey: "address") as? String
                    UserModel.userInstance.anotherId = mainDict.value(forKey: "another_id") as? String
                    UserModel.userInstance.feedback = mainDict.value(forKey: "feedback") as? String
                    
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyBoard.instantiateViewController(withIdentifier: "TermConditionsVC") as! TermConditionsVC
                    controller.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(controller, animated: true)
                    
                    
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

extension signInViewController: LoginButtonDelegate{
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        print("User Logged In")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logout success")
    }
    
    
}
