//
//  shipmentFeedVC.swift
//  Zagil
//
//  Created by Apple on 19/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//


import UIKit
import GCCalendar
import MBProgressHUD

class shipmentFeedVC: UIViewController {

    // MARK:- IBOUTLETS
    @IBOutlet weak var calenderView: GCCalendarView!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var dataMonthLabel: UILabel!
    @IBOutlet weak var availableTripView: UIView!
    
    // MARK:- VARIABLES

    private var selectedDate = String()
    private var delegate: GCCalendarViewDelegate!
    let customBlueColor = UIColor(hexString: "#39D9A1")
    
    var ErrorLargeView : UIView = {
        var view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
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
        // table delegates and datasource
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        self.delegate = self
        self.availableTripView.layer.addBorder(edge: .bottom, color: self.customBlueColor, thickness: 2)
        
    }

    // MARK:- IB-ACTIONS
    @IBAction func backButtonHandler(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func newTripButtonHandler(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newtripController = storyBoard.instantiateViewController(withIdentifier: "newShipmentVC") as! newShipmentVC
        newtripController.hidesBottomBarWhenPushed = true
        cyl_push(newtripController, animated: true)
        
    }
    @IBAction func mapButtonHandler(_ sender: Any) {
        print("maps pressed")
        let mapsVC = mapsViewController()
        cyl_push(mapsVC, animated: true)
    }
    
    // MARK:- HIDE ERROR VIEW
    func hideErrorView() {
        if ErrorLargeView != nil {
                ErrorLargeView.removeFromSuperview()
        }
    }
    
    // MARK:- SHOW ERROR VIEW
    func showErrorView() {
        
        self.ErrorLargeView.backgroundColor = UIColor.white
        self.view.addSubview(ErrorLargeView)
        self.view.bringSubviewToFront(ErrorLargeView)
        
        ErrorLargeView.topAnchor.constraint(equalTo: myTableView.topAnchor).isActive = true
        ErrorLargeView.leftAnchor.constraint(equalTo: myTableView.leftAnchor).isActive = true
        ErrorLargeView.rightAnchor.constraint(equalTo: myTableView.rightAnchor).isActive = true
        ErrorLargeView.bottomAnchor.constraint(equalTo: myTableView.bottomAnchor).isActive = true
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image =  UIImage(named: "no_shifts2")
        self.ErrorLargeView.addSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.ErrorLargeView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.ErrorLargeView.centerYAnchor).isActive = true
    } // end method
    
    // MARK:-  SHOW API DATA BY DATE
        
    private func getTripDatabyDate(dateString: String) {
        
        
        MBProgressHUD.showAdded(to: self.view, animated: true);
        guard AppUtil.isInternetConnected() == true else {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showAlertView(titleStr: "No internet Connection", messageStr: "")
            return
        }
        
        var baseUrl =  AppUtil.getBaseUrl()
        baseUrl = baseUrl.appending("/api/v1/trips/getTrip")
        
        let parameter = ["date" : dateString] as [String : Any]
        
        APIManager.getAPIRequest(baseUrl, parameter: parameter, dataResponse: { (dataResponse) in
            if dataResponse.response?.statusCode == 200
            {
                MBProgressHUD.hide(for: self.view, animated: true)
                let jsonResponse =  dataResponse.result.value
                
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return
                }
                
                tripFeedModel.singleton.tripFeedArray.removeAll()
                
                for i in 0..<jsonArray.count{
                    
                    let obj = tripFeedModel()

                    obj.id = jsonArray[i]["id"] as? Int
                    obj.uid = jsonArray[i]["uid"] as? Int
                    obj.source = jsonArray[i]["source"] as? String
                    obj.destination = jsonArray[i]["destination"] as? String
                    obj.weight = jsonArray[i]["weight"] as? String
                    obj.size = jsonArray[i]["size"] as? String
                    obj.date = jsonArray[i]["date"] as? String
                    obj.descriptionText = jsonArray[i]["description"] as? String
                    obj.prize = jsonArray[i]["prize"] as? String

                    tripFeedModel.singleton.tripFeedArray.append(obj)
                    
                }
                
                self.myTableView.reloadData()

            }
            else
            {
            } // else
            
        })
        { (error) -> Void in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showAlertView(titleStr: "No Response Received", messageStr: "")
        }
    } // end methoD
}

// MARK:- EXTENTION FOR UITABLEVIEW DATASOURCE AND DELEGATE FUNCTIONS

extension shipmentFeedVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripFeedModel.singleton.tripFeedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripFeedCell") as! tripFeedCell
        
        let tripData = tripFeedModel.singleton.tripFeedArray[indexPath.row]
        
        cell.usernameLabel.text = "Muneeb Ahsan"
        cell.fromLabel.text = "21 Jan 2020"
        cell.toLabel.text = "18 Feb 2020"
        cell.typeLabel.text = "Parcle"
        cell.weightLabel.text = tripData.weight!
        
        
        return cell
        
    }
    
}



// MARK:- EXTENSION Calendar Methods

extension shipmentFeedVC: GCCalendarViewDelegate{
    
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
        
        self.getTripDatabyDate(dateString: selectedDate) // send date as parameter
    }
    
    
}


