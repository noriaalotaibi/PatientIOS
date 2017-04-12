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
    
    public var hospitalSpecilityId:Int = 0
    
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
        //values.setValue(hospitalLogoURL, forKey: "logoUrl")
        
        values.setValue(hospitalAddress, forKey: "address")
        values.setValue(hospitalWorkingHours, forKey: "workingHours")
        values.setValue(hospitalExtrainfo, forKey: "extraInfo")
        
        values.setValue(hospitalType, forKey: "type")
        
        values.setValue(hospitalSpecilityId, forKey: "specialityId")
        
        
        values.setValue(hospitalFax, forKey: "fax")
        
        values.setValue(hospitalEmail, forKey: "email")
        
        values.setValue(hospitalPhone, forKey: "phone")
        
        values.setValue(hospitalLang, forKey: "hospitalLang")
        values.setValue(hospitalAlt, forKey: "hospitalAlt")
        
        return values
    }
    
    // for get
    func loadDictionary(values: NSDictionary) {
        
        self.hospitalId = values.valueForKey("hospitalId") as! Int
        
        self.hospitalName = values.valueForKey("hospitalName") as! String
        self.hospitalWebsite = values.valueForKey("webSite") as! String
        //self.hospitalLogoURL = values.valueForKey("logoUrl") as! String
        self.hospitalAddress = values.valueForKey("address") as! String
        self.hospitalWorkingHours = values.valueForKey("workingHours") as! String
        self.hospitalExtrainfo = values.valueForKey("extraInfo") as! String
        
        self.hospitalType = values.valueForKey("type") as! String
        self.hospitalSpecilityId = values.valueForKey("specialityId") as! Int
        
        self.hospitalFax = values.valueForKey("fax") as! String
        
         self.hospitalEmail = values.valueForKey("email") as! String
         self.hospitalPhone = values.valueForKey("phone") as! String
         self.hospitalLang = values.valueForKey("hospitalLang") as! String
         self.hospitalAlt = values.valueForKey("hospitalAlt") as! String
        
        //self.gender = values.valueForKey("location") as! Character
        
        
        
    }
    
}
