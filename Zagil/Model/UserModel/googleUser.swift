//
//  googleUser.swift
//  Zagil
//
//  Created by Apple on 29/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class googleUser: NSObject {

    static let userInstance = googleUser()
    
    var googleUserArray = [googleUser]()
    
    var userid: String?
    var email: String?
    var fullname: String?
    var image: URL?

    
}
