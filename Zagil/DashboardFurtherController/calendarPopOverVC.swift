//
//  calendarPopOverVC.swift
//  Zagil
//
//  Created by Apple on 17/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import GCCalendar


// MARK:- PROTOCOL
protocol myCalenderProtocol {
    func selectDateFunction(date: String)
}


class calendarPopOverVC: UIViewController {
    

    // MARK:- IBOUTLETS
    @IBOutlet weak var myCalendar: GCCalendarView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    // VARIABLES
    private var selectedDate = String()
    private var delegate: GCCalendarViewDelegate!
    var calendarDelegate: myCalenderProtocol!
    let customBlueColor = UIColor(hexString: "#39D9A1")
    
    // MARK:- VIEW WILL APPEAR
    
    // MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        
        
        
    }
    
    // MARK:- SETUP VIEW FUNCTION
    
    func setupView() {
        
        self.view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        self.myCalendar.translatesAutoresizingMaskIntoConstraints = false
        self.myCalendar.delegate = self
        self.myCalendar.displayMode = .month
        self.delegate = self
        
        self.topView.layer.cornerRadius = 12
        self.topView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.bottomView.layer.cornerRadius = 12
        self.bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
    }
    
    // MARK:- IB ACTION OUTLETS
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func okButtonPressed(_ sender: Any) {
        print(self.selectedDate)
        // delegate func here
        self.calendarDelegate.selectDateFunction(date: self.selectedDate)
        self.dismiss(animated: true, completion: nil)
        
    }
    

}

// MARK:- EXTENSION Calendar Methods

extension calendarPopOverVC: GCCalendarViewDelegate{
    
    func pastDatesEnabled(calendarView: GCCalendarView) -> Bool {
        return false
    }
    
    func currentDateSelectedBackgroundColor(calendarView: GCCalendarView) -> UIColor {
        
        return self.customBlueColor
    }
    
    func futureDateSelectedBackgroundColor(calendarView: GCCalendarView) -> UIColor{
        
        return self.customBlueColor
    }
    
    func pastDateSelectedBackgroundColor(calendarView: GCCalendarView) -> UIColor
    {
        return self.customBlueColor
    }
    
    func calendarView(_ calendarView: GCCalendarView, didSelectDate date: Date, inCalendar calendar: Calendar)
    {
        
        //  let now = Date()
        let dateFormatterMonth = DateFormatter()
        dateFormatterMonth.dateFormat = "LLLL"
        let nameOfMonth = dateFormatterMonth.string(from: date)
//        print("printing name of months ",nameOfMonth)
        self.monthLabel.text = nameOfMonth
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        self.selectedDate = dateFormatter.string(from: date)
        
        print(selectedDate)
    }
    
    
}
