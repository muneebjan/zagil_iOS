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
            
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    let fbDetails = result as! NSDictionary
                    let fbEmail = fbDetails.value(forKey: "email") as! String
                    let fbName = fbDetails.value(forKey: "name") as! String
                    let fbUserID = fbDetails.value(forKey: "id") as! String
                    
                    print(fbEmail, fbName, fbUserID)
                    self.checkingEmailExistsOrNot(name: fbName, email: "muneeb_ahsan07@gmail.com", id: fbUserID, from: "facebook")

                }else{
                    print(error?.localizedDescription ?? "Not found")
                }
            })
            
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
            
            googleUser.userInstance.userid = user.userID
            googleUser.userInstance.fullname = user.profile.name
            googleUser.userInstance.email = user.profile.email
            if user.profile.hasImage {
                if let pic = user.profile.imageURL(withDimension: 100){
                    googleUser.userInstance.image = pic
                }
            }else{
                print("image not found")
            }
            
            
            
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
                    UserModel.userInstance.FId = mainDict.value(forKey: "f_id") as? String
                    UserModel.userInstance.feedback = mainDict.value(forKey: "feedback") as? String
                    UserModel.userInstance.GId = mainDict.value(forKey: "g_id") as? String
                    
                    // tick is checked
                    if(self.tickCheck){
                        let preferences = UserDefaults.standard
                        preferences.set(true, forKey: "isRemembered")
                        
                        preferences.set(UserModel.userInstance.userid, forKey: "userid")
                        preferences.set(UserModel.userInstance.email, forKey: "email")
                        preferences.set(UserModel.userInstance.password, forKey: "password")
                        preferences.set(UserModel.userInstance.phone, forKey: "phone")
                        preferences.set(UserModel.userInstance.image, forKey: "image")
                        preferences.set(UserModel.userInstance.name, forKey: "name")
                        preferences.set(UserModel.userInstance.uid, forKey: "uid")
                        preferences.set(UserModel.userInstance.username, forKey: "username")
                        preferences.set(UserModel.userInstance.birthday, forKey: "birthday")
                        preferences.set(UserModel.userInstance.address, forKey: "address")
                        preferences.set(UserModel.userInstance.FId, forKey: "f_id")
                        preferences.set(UserModel.userInstance.feedback, forKey: "feedback")
                        preferences.set(UserModel.userInstance.GId, forKey: "g_id")
                        
                        preferences.synchronize()
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyBoard.instantiateViewController(withIdentifier: "TermConditionsVC") as! TermConditionsVC
                        controller.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(controller, animated: true)
                        
                    }else{
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyBoard.instantiateViewController(withIdentifier: "TermConditionsVC") as! TermConditionsVC
                        controller.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(controller, animated: true)
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
    
}

extension signInViewController: LoginButtonDelegate{
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        print("User Logged In")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logout success")
    }
    
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

    // ===========================================================================================
    // ======================================= EXTENSIONS ========================================
    // ===========================================================================================


extension signInViewController{
    
    // MARK:- CHECK EMAIL EXISTS OR NOT
    
    private func checkingEmailExistsOrNot(name: String, email: String, id: String, from: String) {
        
        MBProgressHUD.showAdded(to: self.view, animated: true);
        guard AppUtil.isInternetConnected() == true else {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showAlertView(titleStr: "No internet Connection", messageStr: "")
            return
        }
        
        var baseUrl =  AppUtil.getBaseUrl()
        baseUrl = baseUrl.appending("/api/v1/user/emailCheck")
        
        
        let parameter = ["email" : email] as [String : Any]
        
        APIManager.getAPIRequest123(baseUrl, parameter: parameter , dataResponse: { (dataResponse) in
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
                        print("email not exists you may update social media data")
                        
                        self.updateGoogleOrFacebookData(name: name, email: email, userId: id, requestFrom: from)
        
                        
                    }else{
                        print("entered email already exists")
                        
                        if(from == "facebook"){
                            self.updateFacebookID(id: id, email: email)
                        }else{
                            self.updateGoogleID(id: id, email: email)
                        }
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
    
    
    // MARK:- UPDATE SOCIAL MEDIA DATA
    
    private func updateGoogleOrFacebookData(name: String, email: String, userId: String, requestFrom: String) {
        
        MBProgressHUD.showAdded(to: self.view, animated: true);
        guard AppUtil.isInternetConnected() == true else {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showAlertView(titleStr: "No internet Connection", messageStr: "")
            return
        }
        
        var baseUrl =  AppUtil.getBaseUrl()
        baseUrl = baseUrl.appending("/api/v1/user/loginWithGoogle")
        
        let parameter = ["name" : name,
                         "email" : email,
                         "id" : userId,
                         "requestFrom" : requestFrom] as [String : Any]
        
        APIManager.postAPIRequest(baseUrl, parameter: parameter , dataResponse: { (dataResponse) in
            if dataResponse.response?.statusCode == 200
            {
                let mainResponse =  dataResponse.result.value
                if (mainResponse is [Any])
                {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let array = mainResponse as! NSArray
                    let mainDict = array[0] as! NSDictionary
                    print("response from updateSocial media api: \(mainDict)")
                    
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
    
    // MARK:- UPDATE FACEBOOK ID
    
    private func updateFacebookID(id: String, email: String) {
        
        MBProgressHUD.showAdded(to: self.view, animated: true);
        guard AppUtil.isInternetConnected() == true else {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showAlertView(titleStr: "No internet Connection", messageStr: "")
            return
        }
        
        var baseUrl =  AppUtil.getBaseUrl()
        baseUrl = baseUrl.appending("/api/v1/user/updateIDFacebook")
        
        let parameter = ["email" : email,
                         "id" : id] as [String : Any]
        
        APIManager.postAPIRequest(baseUrl, parameter: parameter , dataResponse: { (dataResponse) in
            if dataResponse.response?.statusCode == 200
            {
                let mainResponse =  dataResponse.result.value
                if (mainResponse is [Any])
                {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let array = mainResponse as! NSArray
                    let mainDict = array[0] as! NSDictionary
                    print("response from update facebook id api: \(mainDict)")
                    
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
    
    // MARK:- UPDATE GOOGLE ID
    
    private func updateGoogleID(id: String, email: String) {
        
        MBProgressHUD.showAdded(to: self.view, animated: true);
        guard AppUtil.isInternetConnected() == true else {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showAlertView(titleStr: "No internet Connection", messageStr: "")
            return
        }
        
        var baseUrl =  AppUtil.getBaseUrl()
        baseUrl = baseUrl.appending("/api/v1/user/updateIDGoogle")
        
        let parameter = ["email" : email,
                         "id" : id] as [String : Any]
        
        APIManager.postAPIRequest(baseUrl, parameter: parameter , dataResponse: { (dataResponse) in
            if dataResponse.response?.statusCode == 200
            {
                let mainResponse =  dataResponse.result.value
                if (mainResponse is [Any])
                {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let array = mainResponse as! NSArray
                    let mainDict = array[0] as! NSDictionary
                    print("response from update Google id api: \(mainDict)")
                    
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
