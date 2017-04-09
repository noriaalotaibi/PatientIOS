//
//  DonorDH.swift
//  MHealth
//
//  Created by trn15 on 3/7/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class DonorDH: NSObject, DataHolder {

    public var donorId:Int = 0
    public var firstName:String = ""
//    public var middleName:String = ""
    public var lastName:String = ""
    public var email:String = ""
    public var nationality:String = ""
    public var imageUrl:String = ""
    public var civilId:String = ""
   // public var phoneNumber:Int = ""
    public var password:String = ""
    public var birthDate:NSDate = NSDate()
    public var bloodType:String = ""

    var gender:Character = "M"
    
//    
//    [{"birthDate":"2017-01-01T00:00:00Z","bloodType":"A+","civilId":"122223","donorId":3,"email":"hakona@matata.com","firstName":"Mohammad","gender":"m","lastName":"ALdosari","nationality":"K","password":"123","phoneNumber":"1234","status":false},
//    
    
    
    
    
    
    // for post
    func toDictionary() -> NSDictionary {
        let values:NSMutableDictionary = NSMutableDictionary()
        
        values.setValue(donorId, forKey: "donorId")
       // values.setValue(phoneNumber, forKey: "phoneNumber")
        
        values.setValue(firstName, forKey: "firstName")
        values.setValue(password, forKey: "password")
        values.setValue(lastName, forKey: "lastName")
        values.setValue(email, forKey: "email")
        values.setValue(nationality, forKey: "nationality")
        values.setValue(birthDate, forKey: "birthDate")
        values.setValue(bloodType, forKey: "bloodType")
        values.setValue(civilId, forKey: "civilId")
        
        //values.setValue(gender, forKey: "gender")
        
        return values
    }
    
    // for get
    func loadDictionary(values: NSDictionary) {
        
        self.donorId = values.valueForKey("donorId") as! Int
        
       // self.phoneNumber = values.valueForKey("phoneNumber") as! Int
        self.firstName = values.valueForKey("firstName") as! String
        self.password = values.valueForKey("password") as! String
        self.lastName = values.valueForKey("lastName") as! String
        self.email = values.valueForKey("email") as! String
        self.nationality = values.valueForKey("nationality") as! String
        //self.birthDate = values.valueForKey("birthDate") as! NSDate
        self.bloodType = values.valueForKey("bloodType") as! String
        self.civilId = values.valueForKey("civilId") as! String
        
      //  self.gender = values.valueForKey("gender") as! Character
        
        
    }

}
