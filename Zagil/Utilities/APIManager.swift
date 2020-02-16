//
//  APIManager.swift
//  luxeLiveryValet
//
//  Created by Muneeb on 13/05/2019.
//  Copyright © 2019 devstop. All rights reserved.

import UIKit
import Alamofire

class APIManager: NSObject {
    
    
    // MARK: - Get  data Respons Request
    class func getAPIRequest(_ urlStr : String, parameter : Parameters?, dataResponse:@escaping(DataResponse<Any>) -> Void, failure:@escaping (Error) -> Void)
    {
        let defaultt  = UserDefaults.standard
        let accessToken =  defaultt.value(forKey: "access_token") as? String
        var tokenValueStr =  "Bearer" + " "//.appending(accessToken)
        if accessToken != nil {
            tokenValueStr = tokenValueStr.appending(accessToken!)
        }
        let header : HTTPHeaders = ["Authorization" : tokenValueStr]
        
        Alamofire.request(urlStr, method: .get, parameters: parameter, encoding: URLEncoding.queryString, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if response.result.value
                    != nil
                {
                    //let resJson = (response.result.value!)
                    dataResponse(response as Any as! DataResponse<Any>)
                }
                break
            case .failure(_):
                let error : Error =  response.result.error!
                failure(error)
                break
            } // switch End
        }
    } // end Method
    
    
    // MARK: - Get  data Respons Request
    class func getAPIRequest123(_ urlStr : String, parameter : Parameters?, dataResponse:@escaping(DataResponse<Any>) -> Void, failure:@escaping (Error) -> Void)
    {
        let defaultt  = UserDefaults.standard
        let accessToken =  defaultt.value(forKey: "access_token") as? String
        var tokenValueStr =  "Bearer" + " "//.appending(accessToken)
        if accessToken != nil {
            tokenValueStr = tokenValueStr.appending(accessToken!)
        }
        let header : HTTPHeaders = ["Authorization" : tokenValueStr]
        
        Alamofire.request(urlStr, method: .get, parameters: parameter, encoding: URLEncoding.queryString, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if response.result.value
                    != nil
                {
                    //let resJson = (response.result.value!)
                    dataResponse(response as Any as! DataResponse<Any>)
                }
                break
            case .failure(_):
                let error : Error =  response.result.error!
                failure(error)
                break
            } // switch End
        }
    } // end Method
    
    
    // MARK: -  Post Api Requesttt
    class func postAPIRequest(_ url : String, parameter : Parameters,dataResponse:@escaping(DataResponse<Any>) -> Void, failure:@escaping (Error) -> Void)
        
    {
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.queryString, headers: nil).responseJSON{
            (response : DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if response.result.value
                    != nil
                {
                    //let resJson = (response.result.value!)
                    dataResponse(response as Any as! DataResponse<Any>)
                }
                break
            case .failure(_):
                let error : Error =  response.result.error!
                failure(error)
                break
            } // switch End
        }
    }// end method
    
    class func deleteAPIRequest(_ url : String, parameter : Parameters,dataResponse:@escaping(DataResponse<Any>) -> Void, failure:@escaping (Error) -> Void)
        
    {
        let defaultt  = UserDefaults.standard
        let accessToken =  defaultt.value(forKey: "access_token") as? String
        var tokenValueStr =  "Bearer" + " "
        if accessToken != nil {
            tokenValueStr = tokenValueStr.appending(accessToken!)
        }
        
        let header : HTTPHeaders = ["Authorization" : tokenValueStr]
        
        Alamofire.request(url, method: .delete, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON{
            (response : DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if response.result.value
                    != nil
                {
                    //let resJson = (response.result.value!)
                    dataResponse(response as Any as! DataResponse<Any>)
                }
                break
            case .failure(_):
                let error : Error =  response.result.error!
                failure(error)
                break
            } // switch End
        }
    }// end method
    


} // end class
