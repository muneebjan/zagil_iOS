//
//  mapsViewController.swift
//  Zagil
//
//  Created by Apple on 16/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class mapsViewController: UIViewController {

    // MARK:- VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.hidesBottomBarWhenPushed = false
    }
    
    // VARIABLES
    
    var searchBar: UISearchBar?
    

    var tableDataSource: GMSAutocompleteTableDataSource?
    var srchDisplayController: UISearchController?
    var mapView = GMSMapView()
    var saveString = String()
    
    var lat = Double()
    var long = Double()
    
    
    // MARK:- VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
    }

}



