//
//  UserModel.swift
//  Zagil
//
//  Created by Apple on 17/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class UserModel: NSObject {

    static let userInstance = UserModel()
    
    var userArray = [UserModel]()
    
    var userid: Int?
    var email: String?
    var password: String?
    var phone: String?
    var image: String?
    var name: String?
    var uid: Int?
    var username: String?
    var birthday: String?
    var address: String?
    var FId: String?
    var feedback: String?
    var GId: String?
    
}
