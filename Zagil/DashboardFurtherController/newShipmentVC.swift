//
//  newShipmentVC.swift
//  Zagil
//
//  Created by Apple on 20/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//


import UIKit
import MBProgressHUD

class newShipmentVC: UIViewController {

    // MARK:- IBOUTLETS
    @IBOutlet weak var typeShipmentTextfield: UITextField!
    @IBOutlet weak var fullnameTextfield: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    
    @IBOutlet weak var fromTextfield: UITextField!
    @IBOutlet weak var toTextfield: UITextField!
    @IBOutlet weak var weightTextfield: UITextField!
    @IBOutlet weak var sizeTextfield: UITextField!
    @IBOutlet weak var descriptionTextview: UITextView!
    @IBOutlet weak var priceTextfield: UITextField!
    @IBOutlet weak var postTripImageView: UIImageView!
    @IBOutlet weak var dateMonthLabel: UILabel!
    
    
    // MARK:- VARIABLES

    
    // MARK:- VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
//        self.hidesBottomBarWhenPushed = false
    }
    
    // MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        
    }
    
    // MARK:- CUSTOM FUNCTIONS
    
    func setupView() {
        
        self.descriptionTextview.delegate = self
        self.descriptionTextview.text = "Description"
        self.descriptionTextview.textColor = UIColor.lightGray
        
        self.postTripImageView.clipsToBounds = true
        self.postTripImageView.layer.cornerRadius = 7
    }
    
    
    // MARK:- IB-ACTIONS
    @IBAction func backButtonHandler(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func postRequestHandler(_ sender: Any) {
        print("post request pressed")
        
//        guard let from = fromTextfield.text else {
//            ToastView.shared.short(self.view, txt_msg: "Please Enter From field")
//            return
//        }
//        guard let to = toTextfield.text else {
//            ToastView.shared.short(self.view, txt_msg: "Please Enter To field")
//            return
//        }
//        guard let weight = weightTextfield.text else {
//            ToastView.shared.short(self.view, txt_msg: "Please Enter Weight field")
//            return
//        }
//        guard let size = sizeTextfield.text else {
//            ToastView.shared.short(self.view, txt_msg: "Please Enter Size field")
//            return
//        }
//        guard let descriptionText = descriptionTextview.text else {
//            ToastView.shared.short(self.view, txt_msg: "Please Enter Description field")
//            return
//        }
//        guard let price = priceTextfield.text else {
//            ToastView.shared.short(self.view, txt_msg: "Please Enter Price field")
//            return
//        }
        
//        self.postTripData(fromCountry: "pakistan", toCountry: "Canada", date: "26/08/2019", weight: "2.5kg", size: "30cm", descriptionText: "I have added new trip", price: "30$")
        
    }
    
    
    @IBAction func selectDateHandler(_ sender: Any) {
        print("select date pressed")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popOver = storyBoard.instantiateViewController(withIdentifier: "calendarPopOverVC") as! calendarPopOverVC
        popOver.calendarDelegate = self
        self.present(popOver, animated: true, completion: nil)
        // calendarPopOverVC
        
    }
    
    
    // MARK:- NOTE: IMPLEMENT POST REQUEST API HERE.
    // MARK:- POST REQUEST API FUNCTION
    
//    private func postTripData(fromCountry: String, toCountry: String, date: String, weight: String, size: String, descriptionText: String, price: String) {
//
//        MBProgressHUD.showAdded(to: self.view, animated: true);
//        guard AppUtil.isInternetConnected() == true else {
//            MBProgressHUD.hide(for: self.view, animated: true)
//            self.showAlertView(titleStr: "No internet Connection", messageStr: "")
//            return
//        }
//
////        guard let userID = UserModel.userInstance.uid else {return}
//
//        var baseUrl =  AppUtil.getBaseUrl()
//        baseUrl = baseUrl.appending("/api/v1/trip/addTrip")
//
//        print(baseUrl)
//
//
//        let parameter = ["uid" : 6,
//                         "destination" : toCountry,
//                         "weight" : weight,
//                         "size" : size,
//                         "date" : date,
//                         "description" : descriptionText,
//                         "prize" : price,
//                         "source" : fromCountry] as [String : Any]
//
//        APIManager.postAPIRequest(baseUrl, parameter: parameter , dataResponse: { (dataResponse) in
//            if dataResponse.response?.statusCode == 200
//            {
//                let mainResponse =  dataResponse.result.value
//                if (mainResponse is [Any])
//                {
//                    MBProgressHUD.hide(for: self.view, animated: true)
//                    let array = mainResponse as! NSArray
//                    let mainDict = array[0] as! NSDictionary
//                    //                    let userid = mainDict.value(forKey: "id") as! Int
//
//
//                    ToastView.shared.short(self.view, txt_msg: "New Trip Has Been Added")
////                    self.navigationController?.popViewController(animated: true)
//
//                }
//                else if (mainResponse is [AnyHashable : Any])
//                {
//                    MBProgressHUD.hide(for: self.view, animated: true)
//                }
//
//            } // if
//            else
//            {
//            }
//
//        }) { (error) -> Void in
//
//            MBProgressHUD.hide(for: self.view, animated: true)
//            self.showAlertView(titleStr: "No Response Received", messageStr: "")
//        }
//    } // end method

}

// MARK:- EXTENSION UITEXTVIEW

extension newShipmentVC: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.darkGray
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
    
}

// MARK:- EXTENSION UITEXTVIEW

extension newShipmentVC: myCalenderProtocol{
    
    func selectDateFunction(date: String) {
        self.dateMonthLabel.text = date
    }
    
    
}
