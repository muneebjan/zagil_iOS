//
//  newTripVC.swift
//  Zagil
//
//  Created by Apple on 17/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class newTripVC: UIViewController {

    // MARK:- IBOUTLETS
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
    @IBAction func postTripHandler(_ sender: Any) {
        print("post trip pressed")
    }
    @IBAction func selectDateHandler(_ sender: Any) {
        print("select date pressed")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popOver = storyBoard.instantiateViewController(withIdentifier: "calendarPopOverVC") as! calendarPopOverVC
        popOver.calendarDelegate = self
        self.present(popOver, animated: true, completion: nil)
        // calendarPopOverVC
        
    }

}

// MARK:- EXTENSION UITEXTVIEW

extension newTripVC: UITextViewDelegate{
    
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

extension newTripVC: myCalenderProtocol{
    
    func selectDateFunction(date: String) {
        self.dateMonthLabel.text = date
    }
    
    
}
