//
//  PBServiceHelper.swift
//  Postablur
//
//  Created by Saraschandra on 19/01/18.
//  Copyright © 2018 MobiwareInc. All rights reserved.
//

import UIKit
import Alamofire

class PBServiceHelper: NSObject
{
    typealias PBPostCompletionHandler = (Bool?, AnyObject?, String?) -> Swift.Void
    
    //typealias PBGetCompletionHandler = (Bool?, AnyObject?, String?) -> Swift.Void
    
    var appdelegate : AppDelegate!
    
    // MARK: Upload Profile Image
    func uploadProfileImage(image: UIImage, imageName: String)
    {
        self.appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        if appdelegate.isNetworkReachable() == false
        {
            DispatchQueue.main.async(execute: { () -> Void in
                
            })
            return
        }
        let urlString = String(format: Urls.uploadImageUrl)
        
        let request = NSMutableURLRequest(url: NSURL(string:urlString)! as URL)
        
        let session = URLSession.shared
        
        request.httpMethod = "POST"
        
        request.allHTTPHeaderFields = ["content-type":"multipart/form-data",Urls.AccessToken: Urls.AccessTokenValue]
        
        //request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        
        
     
    }
    
    
    func post(url:String, parameters:NSDictionary, completion: @escaping PBPostCompletionHandler)
    {
        self.appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        if appdelegate.isNetworkReachable() == false
        {
            DispatchQueue.main.async(execute: { () -> Void in
                completion(false, nil, "No Internet Connection")
            })
            return
        }
        
        let request = NSMutableURLRequest(url: NSURL(string:url)! as URL)
        
        let session = URLSession.shared
        
        request.httpMethod = "POST"
        
        request.allHTTPHeaderFields = ["Content-Type":"application/json; charset=utf-8", Urls.AccessToken: Urls.AccessTokenValue]
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            guard data != nil else
            {
                DispatchQueue.main.async(execute: { () -> Void in
                    completion(false, nil, "Something went wrong")
                })
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? AnyObject
                {
                    DispatchQueue.main.async
                    {
                        completion(true, json, nil)
                    }
                }
                else
                {
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    //print("Error could not parse JSON: \(jsonStr)")
                    //failed
                    completion(false,jsonStr, nil)
                    
                }
            }
            catch let parseError
            {
                let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                ///print("Error could not parse JSON: '\(jsonStr)'")
                completion(false, jsonStr, nil)
                
            }
        }
        
        task.resume()
    }
    
    /*func get(url:String, completion: @escaping PBGetCompletionHandler)
    {
        
        let request = NSMutableURLRequest(url: NSURL(string:url)! as URL)
        
        let session = URLSession.shared
        
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = ["Content-Type":"application/json; charset=utf-8", Urls.AccessToken: Urls.AccessTokenValue]
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            guard data != nil else
            {
                //print("no data found: \(error)")
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? AnyObject
                {
                    DispatchQueue.main.async
                    {
                        completion(true, nil, json)
                    }
                }
                else
                {
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    //No error thrown, but not NSDictionary
                    //print("Error could not parse JSON: \(jsonStr)")
                    //failed
                    completion(false, jsonStr as String?, nil)
                }
            }
            catch let parseError
            {
                let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                //print("Error could not parse JSON: '\(jsonStr)'")
                completion(false, jsonStr as String?, nil)
                
            }
        }
        
        task.resume()
    }*/
}
