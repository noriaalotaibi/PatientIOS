//
//  PatientReportDH.swift
//  MHealth
//
//  Created by Shamlan Al-Roumi on 3/8/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class PatientReportDH: NSObject, DataHolder {
    
    
    var name:String = ""
    var bloodPressure:String = ""
    var comments:String = ""
    var coughing:String = ""
    var dizziness:String = ""
    var drId:Int = 0
    var drcomment:String = ""
    var fever:String = ""
    var headache:String = ""
    var heartbeatRate:String = ""
    var nauseous:String = ""
    var pain:Bool = false
    var painlocation:String = ""
    var patientId:Int = 0
    var reportId:Int = 0
    var sugarLevel:String = ""
    var timestamp:String = ""
    var imageURL:String = ""
    
    
    func toDictionary() -> NSDictionary {
        let values:NSMutableDictionary = NSMutableDictionary()
        values.setValue(name, forKey: "name")
        values.setValue(bloodPressure, forKey: "bloodPressure")
        values.setValue(comments, forKey: "comments")
        values.setValue(coughing, forKey: "coughing")
        values.setValue(dizziness, forKey: "dizziness")
        values.setValue(drId, forKey: "drId")
        values.setValue(drcomment, forKey: "drcomment")
        values.setValue(fever, forKey: "fever")
        
        values.setValue(headache, forKey: "headache")
        values.setValue(heartbeatRate, forKey: "heartbeatRate")
        values.setValue(nauseous, forKey: "nauseous")
        values.setValue(pain, forKey: "pain")
        
        values.setValue(painlocation, forKey: "painlocation")
        values.setValue(patientId, forKey: "patientId")
        values.setValue(reportId, forKey: "reportId")
        
        values.setValue(sugarLevel, forKey: "sugarLevel")
        values.setValue(timestamp, forKey: "timestamp")
        values.setValue(imageURL, forKey: "imageUrl")
        return values
    }
    
    func loadDictionary(values: NSDictionary) {
        if (values.valueForKey("name") != nil) {
            self.name = values.valueForKey("name") as! String
        } else {
            self.name = ""
        }
        
        self.bloodPressure = values.valueForKey("bloodPressure") as! String
        self.comments = values.valueForKey("comments") as! String
        self.coughing = values.valueForKey("coughing") as! String
        
        self.dizziness = values.valueForKey("dizziness") as! String
        self.drId = values.valueForKey("drId") as! Int
        self.drcomment = values.valueForKey("drcomment") as! String
        
        self.fever = values.valueForKey("fever") as! String
        self.headache = values.valueForKey("headache") as! String
        self.heartbeatRate = values.valueForKey("heartbeatRate") as! String
        
        self.nauseous = values.valueForKey("nauseous") as! String
        self.pain = values.valueForKey("pain") as! Bool
        self.painlocation = values.valueForKey("painlocation") as! String
        
        self.patientId = values.valueForKey("patientId") as! Int
        self.reportId = values.valueForKey("reportId") as! Int
        self.sugarLevel = values.valueForKey("sugarLevel") as! String
        self.imageURL = values.valueForKey("imageUrl") as! String
        
        if (values.valueForKey("timestamp") != nil) {
            self.timestamp = values.valueForKey("timestamp") as! String
        } else {
            self.timestamp = ""
        }
        
    }
    
    func toArray()->NSArray{
        
        let valuesArray = NSMutableArray()
        valuesArray.addObject(bloodPressure)
        valuesArray.addObject(heartbeatRate)
        valuesArray.addObject(sugarLevel)
        valuesArray.addObject(fever)
        valuesArray.addObject(coughing)
        valuesArray.addObject(dizziness)
        valuesArray.addObject(nauseous)
        valuesArray.addObject(headache)
     
        valuesArray.addObject(painlocation)
        return valuesArray
        
    }


}
