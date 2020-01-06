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

//        self.view.backgroundColor = UIColor.green

    }
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height / 2.0
    }
    
    // MARK:- IB ACTIONS
    @IBAction func openGalleryButtonHandler(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
        
    }
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
