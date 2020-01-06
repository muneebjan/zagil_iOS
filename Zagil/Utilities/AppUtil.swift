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
    
    
    
    class func getStringFromImagee(userImage : UIImage) -> NSString
    {
        let imagee = userImage
        let resizImage  = imagee//self.resizeImage(image: imagee, targetSize: CGRect(x: 0, y: 0, width: widthh, height: heightt))
        let imageData: NSData = resizImage.pngData()! as NSData
        let imageStr = imageData.base64EncodedString(options: .lineLength64Characters)
        return imageStr as NSString
    }
    
    class  func resizeImage(image : UIImage, targetSize : CGRect) -> UIImage
    {
        let imageWitdh = targetSize.width
        let imageHeight = targetSize.height
        UIGraphicsBeginImageContext(CGSize(width: imageWitdh, height: imageHeight))
        image.draw(in: targetSize)
        let resizeImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizeImage
    }
    class func getImageFromString(imageName : String) -> UIImage
    {
        let imageStr = imageName
        let dataDecodede : Data = Data(base64Encoded: imageStr as String, options: .ignoreUnknownCharacters)!
        // var image = UIImage(Data : dataDecodede)
        let getImage = UIImage(data: dataDecodede)
        return getImage!
        
    }

    class func getBaseUrl() -> String
    {
        return "http://ec2-52-15-243-205.us-east-2.compute.amazonaws.com:3000"
        
    }
    
  
    
    class func getImageBaseUrl() -> String
    {
        return  "https://s3.us-east-2.amazonaws.com/luxelivery/"
    }

    
    class func getStringFromCurrentDate() -> String
    {
        let date : Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let todaysDate = dateFormatter.string(from: date)
        return todaysDate
    }
    
    class func gettDateFromSring(dateStr : String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dateeee = dateFormatter.date(from: dateStr)
        return dateeee!
    }
    
    class func getStringDateFromSring(dateStr : String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateeee = dateFormatter.date(from: dateStr)
        let stringDate = dateFormatter.string(from: dateeee!)
        return stringDate
    }
    
    
    class func getStringFromCurrentDateforS3Buckket() -> String
    {
        let date : Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd_HHmm"
        let todaysDate = dateFormatter.string(from: date)
        return todaysDate
    }
    class func getRandomNumber() -> Int
    {
        let number = Int.random(in: 100000 ..< 1000000)
        return number
    }
    
    
} // end class


