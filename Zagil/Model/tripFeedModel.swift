//
//  tripFeedModel.swift
//  Zagil
//
//  Created by Apple on 24/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class tripFeedModel: NSObject {

    static let singleton = tripFeedModel()
    var tripFeedArray: [tripFeedModel] = []
    
    var id : Int?
    var uid: Int?
    var source : String?
    var destination: String?
    var weight : String?
    var size: String?
    var date : String?
    var descriptionText: String?
    var prize: String?

}
