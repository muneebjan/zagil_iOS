//
//  PersonalViewController.swift
//
//  v1.16.0 Created by 微博@iOS程序犭袁 ( http://weibo.com/luohanchenyilong/ ) on 10/20/15.
//  Copyright © 2018 https://github.com/ChenYilong . All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // MARK:- IBOUTLETS
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var dobTextfield: UITextField!
    @IBOutlet weak var addressTextfield: UITextField!
    @IBOutlet weak var cellPhoneTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    
    // MARK:- VARIABLES
    var imagePicker = UIImagePickerController()
    
    // MARK:- VIEW FUNCTIONS
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        
    }
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height / 2.0
    }
    
    // MARK:- SETUP VIEWS
    
    func setupView() {
        
        if(googleUser.userInstance.userid != nil){ // google signin activated
            print("google user exist")
            self.userName.text = googleUser.userInstance.fullname!
            self.emailTextfield.text = googleUser.userInstance.email!
            self.emailTextfield.isEnabled = false
            self.profileImage.downloaded(from: googleUser.userInstance.image!)
            self.dobTextfield.text = ""
            
        }else{
            print("local user exist")
            self.userName.text = UserModel.userInstance.username
            self.dobTextfield.text = UserModel.userInstance.birthday
            self.addressTextfield.text = UserModel.userInstance.address
            self.cellPhoneTextfield.text = UserModel.userInstance.phone
            self.emailTextfield.text = UserModel.userInstance.email
            self.emailTextfield.isEnabled = false
        }
        

    }
    
    // MARK:- IB ACTIONS
    @IBAction func openGalleryButtonHandler(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            
            let alert = UIAlertController(title: "Choose one of the following:", message: "", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (action) in
                
                self.imagePicker.sourceType = .savedPhotosAlbum
                self.present(self.imagePicker, animated: true, completion: nil)
                
            }))
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
                
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    // MARK:- AGREE HANDLER
    @IBAction func agreeHandler(_ sender: Any) {
        
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImage.contentMode = .scaleAspectFill
            self.profileImage.image = pickedImage
        }
     
        dismiss(animated: true, completion: nil)
    }

}
