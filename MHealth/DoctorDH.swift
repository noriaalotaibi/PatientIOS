//
//  DoctorDH.swift
//  MHealth
//
//  Created by Shamlan Al-Roumi on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class DoctorDH: NSObject, DataHolder {
    
    public var drId:Int = 0
    public var specialtyId:String = ""
    
    public var firstName:String = ""
    public var middleName:String = ""
    public var lastName:String = ""
    public var email:String = ""
    public var nationality:String = ""
    public var imageUrl:String = ""
    public var cvUrl:String = ""
    public var location:String = ""
    
    var gender:Character = "M"
    
    
    // for post
    func toDictionary() -> NSDictionary {
        let values:NSMutableDictionary = NSMutableDictionary()
        
        values.setValue(drId, forKey: "drId")
        values.setValue(specialtyId, forKey: "specialityId")
        
        values.setValue(firstName, forKey: "firstName")
        values.setValue(middleName, forKey: "middleName")
        values.setValue(lastName, forKey: "lastName")
        values.setValue(email, forKey: "email")
        values.setValue(nationality, forKey: "nationality")
        values.setValue(imageUrl, forKey: "imageUrl")
        values.setValue(cvUrl, forKey: "cvUrl")
        values.setValue(location, forKey: "location")
        
        //values.setValue(gender, forKey: "gender")
        
        return values
    }
    
    // for get
    func loadDictionary(values: NSDictionary) {
        
        self.drId = values.valueForKey("drId") as! Int
        
        self.specialtyId = values.valueForKey("specialityId") as! String
        self.firstName = values.valueForKey("firstName") as! String
        self.middleName = values.valueForKey("middleName") as! String
        self.lastName = values.valueForKey("lastName") as! String
        self.email = values.valueForKey("email") as! String
        self.nationality = values.valueForKey("nationality") as! String
        self.imageUrl = values.valueForKey("imageUrl") as! String
        self.cvUrl = values.valueForKey("cvUrl") as! String
        self.location = values.valueForKey("location") as! String
        
        //self.gender = values.valueForKey("location") as! Character
        
        
        
    }

}
