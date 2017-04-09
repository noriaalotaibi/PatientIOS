//
//  Networking.swift
//  me@ayossef.net
//
//  Created by Ahmed Yossef on 4/18/16.
//  Copyright © 2016 PIFSS. All rights reserved.
//

import UIKit
import SystemConfiguration
import Alamofire
import SwiftyJSON
import ObjectMapper

protocol NetworkCaller{
    func setDictResponse(resp:NSDictionary, reqId:Int)
    func setArrayResponse(resp:NSArray, reqId:Int)
}

class Networking: NSObject {
    var logging: Bool = false
    func AMJSONDictionary(url:String, httpMethod:String, jsonData:NSObject, reqId:Int, caller:NetworkCaller?) -> OutputResult{
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(jsonData, options: [])
        var result:OutputResult = OutputResult(status: true)
        Alamofire.request(request)
            .responseJSON { response in
                switch response.result {
                case .Failure(let error):
                    print(error)
                    result =  OutputResult(status: false)
                    result.items = []
                    if let realCaller = caller{
                        realCaller.setDictResponse(["Error":"Error"], reqId: reqId)
                    }
                case .Success:
                    if let value = response.result.value {
                        if let realCaller = caller{
                            if value.isKindOfClass(NSNull){
                                realCaller.setDictResponse([:], reqId: reqId)
                            }
                            else {
                                realCaller.setDictResponse(value as! NSDictionary, reqId: reqId)
                            }
                        }
                    }
                }
        }
        return result
    }
    
    func AMJSONArray(url:String, httpMethod:String, jsonData:NSObject, reqId:Int, caller:NetworkCaller?) -> OutputResult{
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(jsonData, options: [])
        var result:OutputResult = OutputResult(status: true)
        
        
        
        Alamofire.request(request)
            .responseJSON { response in
                let outData = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
                if self.logging {
                    print("Out Data : \(outData)")
                }
                switch response.result {
                case .Failure(let error):
                    print(error)
                    print(NSString(data: (response.data)!,encoding: NSUTF8StringEncoding))
                    result =  OutputResult(status: false)
                    result.items = []
                    if let realCaller = caller{
                        realCaller.setArrayResponse(["Error"], reqId: reqId)
                    }
                case .Success:
                    print("SUCESS")
                    print(NSString(data: (response.data)!,encoding: NSUTF8StringEncoding))
                    if let value = response.result.value {
                        if let realCaller = caller{
                            if value.isKindOfClass(NSNull){
                                realCaller.setArrayResponse([], reqId: reqId)
                            }
                            else {
                                realCaller.setArrayResponse(value as! NSArray, reqId: reqId)
                            }
                        }
                    }
                }
        }
        return result
    }

    
    
    func AMPostDictData(url:String, params:[String:AnyObject], reqId:Int, caller:NetworkCaller?)-> OutputResult{
        
        var result:OutputResult = OutputResult(status: true)
        Alamofire.request(.POST, url, parameters: params).validate().responseJSON { response in
            
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    if let realCaller = caller{
                        realCaller.setDictResponse(value as! NSDictionary, reqId: reqId)
                    }
                }
            case .Failure(let error):
                print(error)
                result =  OutputResult(status: false)
                result.items = []
                if let realCaller = caller{
                    realCaller.setDictResponse(["Error":"Error"], reqId: reqId)
                }
            }
            print("result was \(response.result)")
        }
        return result
    }
    
    
    func AMGetArrayData(url:String, params:[String:AnyObject], reqId:Int, caller:NetworkCaller?)-> OutputResult{
        
        var result:OutputResult = OutputResult(status: true)
        Alamofire.request(.GET, url, parameters: params).validate().responseJSON { response in
            let outData = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
            if self.logging {
                print("Out Data : \(outData)")
            }
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    if let realCaller = caller{
                        realCaller.setArrayResponse(value as! NSArray, reqId: reqId)
                    }
                }
                
            case .Failure(let error):
                print(error)
                result =  OutputResult(status: false)
                result.items = []
                if let realCaller = caller{
                    realCaller.setArrayResponse(["Error"], reqId: reqId)
                }
            }
            print("result was \(response.result)")
        }
        return result
    }
    
    
    func AMGetDictData(url:String, params:[String:AnyObject], reqId:Int, caller:NetworkCaller?)-> OutputResult{
        
        var result:OutputResult = OutputResult(status: true)
        Alamofire.request(.GET, url, parameters: params).validate().responseJSON { response in
            let outData = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
            if self.logging {
                print("Out Data : \(outData)")
            }
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    if let realCaller = caller{
                        realCaller.setDictResponse(value as! NSDictionary, reqId: reqId)
                    }
                }
                
            case .Failure(let error):
                print(error)
                result =  OutputResult(status: false)
                result.items = []
                if let realCaller = caller{
                    realCaller.setDictResponse(["Error":"Error"], reqId: reqId)
                }
            }
            print("result was \(response.result)")
        }
        return result
    }
    
    
    func AMPostArrayData(url:String, params:[String:AnyObject], reqId:Int, caller:NetworkCaller?)-> OutputResult{
        
        var result:OutputResult = OutputResult(status: true)
        Alamofire.request(.POST, url, parameters: params).validate().responseJSON { response in
            
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    if let realCaller = caller{
                        realCaller.setArrayResponse(value as! NSArray, reqId: reqId)
                    }
                }
            case .Failure(let error):
                print(error)
                result =  OutputResult(status: false)
                result.items = []
                if let realCaller = caller{
                    realCaller.setArrayResponse(["Error"], reqId: reqId)
                }
            }
            print("result was \(response.result)")
        }
        return result
    }
}
