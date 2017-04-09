//
//  UserDH.swift
//  MHealth
//
//  Created by Ahmed on 3/4/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class UserDH: NSObject, DataHolder {
    //Patient Data
    var firstName:String = ""
    var middleName:String = ""
    var lastName:String = ""
    var password:String = ""
    var gender:Bool = true
    var email:String = ""
    var age:Int = 0
    var nationality:String = ""
    var dateOfBirth:NSDate = NSDate()
    var PhoneNumber:Int = 0
    var EmergencyNumber:Int = 0
    var bloodType:String = ""
    var diabetes:Bool = true
    var asthma:Bool = true
    var allergies:String = ""
    var medications:String = ""
    var civilID:Int = 0
    
    //Doctor
    

    
    
    func toDictionary() -> NSDictionary {
        let values:NSMutableDictionary = NSMutableDictionary()
        //values.setValue(name, forKey: "name")
        values.setValue(age, forKey: "age")
        values.setValue(email, forKey: "email")
        return values
    }
    
    func loadDictionary(values: NSDictionary) {
        //self.name = values.valueForKey("name") as! String
        self.age = values.valueForKey("age") as! Int
        self.email = values.valueForKey("email") as! String
    }
    
    
    
}
