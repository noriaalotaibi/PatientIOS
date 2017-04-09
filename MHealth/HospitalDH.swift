//
//  HospitalDH.swift
//  MHealth
//
//  Created by trn14 on 4/9/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import Foundation
class HospitalDH: NSObject, DataHolder {
    
    public var hospitalId:Int = 0
    public var hospitalName:String = ""
    public var hospitalWebsite:String = ""
    public var hospitalLogoURL:String = ""
    public var hospitalAddress:String = ""
    public var hospitalWorkingHours:String = ""
    public var hospitalExtrainfo:String = ""
    public var hospitalType:String = ""
    
    public var hospitalSpecilityId:String = ""
    
    public var hospitalFax:String = ""
    
    public var hospitalEmail:String = ""
    
    public var hospitalPhone:String = ""
    
    public var hospitalLang:String = ""
    
    public var hospitalAlt:String = ""
    
 
    
    
    // for post
    func toDictionary() -> NSDictionary {
        let values:NSMutableDictionary = NSMutableDictionary()
        
        values.setValue(hospitalId, forKey: "hospitalId")
        values.setValue(hospitalName, forKey: "hospitalName")
        
        values.setValue(hospitalWebsite, forKey: "hospitalWebsite")
        values.setValue(hospitalLogoURL, forKey: "hospitalLogoURL")
        
        values.setValue(hospitalAddress, forKey: "hospitalAddress")
        values.setValue(hospitalWorkingHours, forKey: "hospitalWorkingHours")
        values.setValue(hospitalExtrainfo, forKey: "hospitalExtrainfo")
        
        values.setValue(hospitalType, forKey: "hospitalType")
        
        values.setValue(hospitalSpecilityId, forKey: "hospitalSpecilityId")
        
        
        values.setValue(hospitalFax, forKey: "hospitalFax")
        
        values.setValue(hospitalEmail, forKey: "hospitalEmail")
        
        values.setValue(hospitalPhone, forKey: "hospitalPhone")
        
        values.setValue(hospitalLang, forKey: "hospitalLang")
        values.setValue(hospitalAlt, forKey: "hospitalAlt")
        //values.setValue(gender, forKey: "gender")
        
        return values
    }
    
    // for get
    func loadDictionary(values: NSDictionary) {
        
        self.hospitalId = values.valueForKey("hospitalId") as! Int
        
        self.hospitalName = values.valueForKey("hospitalName") as! String
        self.hospitalWebsite = values.valueForKey("hospitalWebsite") as! String
        self.hospitalLogoURL = values.valueForKey("hospitalLogoURL") as! String
        self.hospitalAddress = values.valueForKey("hospitalAddress") as! String
        self.hospitalWorkingHours = values.valueForKey("hospitalWorkingHours") as! String
        self.hospitalExtrainfo = values.valueForKey("hospitalExtrainfo") as! String
        
        self.hospitalType = values.valueForKey("hospitalType") as! String
        self.hospitalSpecilityId = values.valueForKey("hospitalSpecilityId") as! String
        
        self.hospitalFax = values.valueForKey("hospitalFax") as! String
        
         self.hospitalEmail = values.valueForKey("hospitalEmail") as! String
         self.hospitalPhone = values.valueForKey("hospitalPhone") as! String
         self.hospitalLang = values.valueForKey("hospitalLang") as! String
         self.hospitalAlt = values.valueForKey("hospitalAlt") as! String
        
        //self.gender = values.valueForKey("location") as! Character
        
        
        
    }
    
}
