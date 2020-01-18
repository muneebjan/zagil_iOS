//
//  AppUtil.swift
//  luxeLiveryValet
//
//  Created by Muneeb on 13/05/2019.
//  Copyright © 2019 devstop. All rights reserved.
//

import UIKit

import Alamofire

class AppUtil: NSObject {
    
    
    class func isInternetConnected() -> Bool
    {
        return NetworkReachabilityManager()!.isReachable
    }

    
    class func getBaseUrl() -> String
    {
        return "http://ec2-18-219-185-175.us-east-2.compute.amazonaws.com:3000"
        
    }
    
    class func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    class func getBlueCustomColor() -> UIColor
    {
        let color = UIColor(red: 42/255, green: 180/255, blue: 202/255, alpha: 1)
        return color
    }
    
//    class func getImageBaseUrl() -> String
//    {
//        return  "https://s3.us-east-2.amazonaws.com/luxelivery/"
//    }
    
    
} // end class


