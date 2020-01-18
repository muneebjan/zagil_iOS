//
//  tripFeedVC.swift
//  Zagil
//
//  Created by Apple on 16/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import GCCalendar

class tripFeedVC: UIViewController {

    // MARK:- IBOUTLETS
    @IBOutlet weak var calenderView: GCCalendarView!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var dataMonthLabel: UILabel!
    @IBOutlet weak var availableTripView: UIView!
    
    // MARK:- VARIABLES

    private var selectedDate = String()
    private var delegate: GCCalendarViewDelegate!
    let customBlueColor = UIColor(hexString: "#39D9A1")
    
    // MARK:- VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        self.calenderView.translatesAutoresizingMaskIntoConstraints = false
        self.calenderView.delegate = self
        self.calenderView.displayMode = .week
        
        self.delegate = self
  
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/YYYY"
//        self.selectedDate = dateFormatter.string(from: Date())
////        shiftTableView.tableFooterView = UIView(frame: .zero)
//
//
//        let dateFormatterMonth = DateFormatter()
//        dateFormatterMonth.dateFormat = "dd MMMM"
//        let nameOfMonth = dateFormatterMonth.string(from: Date())
//        self.dataMonthLabel.text = nameOfMonth
        
        self.availableTripView.layer.addBorder(edge: .bottom, color: self.customBlueColor, thickness: 2)
        
    }

    // MARK:- IB-ACTIONS
    @IBAction func backButtonHandler(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func newTripButtonHandler(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newtripController = storyBoard.instantiateViewController(withIdentifier: "newTripVC") as! newTripVC
        newtripController.hidesBottomBarWhenPushed = true
        cyl_push(newtripController, animated: true)
        
    }
    @IBAction func mapButtonHandler(_ sender: Any) {
        print("maps pressed")
        let mapsVC = mapsViewController()
        cyl_push(mapsVC, animated: true)
    }
    
}

// MARK:- EXTENSION Calendar Methods

extension tripFeedVC: GCCalendarViewDelegate{
    
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
        dateFormatterMonth.dateFormat = "dd MMMM"
        let nameOfMonth = dateFormatterMonth.string(from: date)
        self.dataMonthLabel.text = nameOfMonth
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        self.selectedDate = dateFormatter.string(from: date)
        print(selectedDate)
        //            self.showShift(status: statusType)
    }
    
    
}

// MARK:- EXTENSION BORDER OF CA LAYER

extension CALayer {

    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

        let border = CALayer()

        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        default:
            break
        }

        border.backgroundColor = color.cgColor;

        addSublayer(border)
    }
}
