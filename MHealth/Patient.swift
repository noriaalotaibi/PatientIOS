//
//  Patient.swift
//  MHealth
//
//  Created by Abrar Al-Failakawi on 3/6/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import Foundation

class Patient: NSObject , DataHolder {

    
    var firstName:String = ""
    var middleName:String = " "
    var lastName:String = ""
    
    var email:String = ""
    var civilId:String = ""
   
    var gender:String = ""
    var password:String = ""
    var phone:String = ""
    var emergencyNum:String = ""
    var nationality:String = ""
    var bloodType:String = ""
    var diabetes:Bool = false
    var asthma:Bool = false
    var medication:String = ""
    var allergies:String = ""
    var patientID:Int = 0
   
    
    var dateOfBirth:String = ""
    var deleted:Int = 0
    var imageUrl:String = " "
    var status:Bool = true

    //dateOfBirth
    //deleted
    //imageUrl
    //medications
    //status
    
    func toDictionary() -> NSDictionary {
        
        let values:NSMutableDictionary = NSMutableDictionary()
        values.setValue(firstName, forKey: "firstName")
        values.setValue(middleName, forKey: "middleName")
        values.setValue(lastName, forKey: "lastName")
        values.setValue(email, forKey: "email")
      
        values.setValue(password, forKey: "password")
        values.setValue(gender, forKey: "gender")
        values.setValue(phone, forKey: "phoneNumber")
        values.setValue(emergencyNum, forKey: "emergencyNumber")
        values.setValue(nationality, forKey: "nationality")
        values.setValue(bloodType, forKey: "bloodType")
        values.setValue(diabetes, forKey: "diabetes")
        values.setValue(asthma, forKey: "asthma")
        values.setValue(medication, forKey: "medications")
        values.setValue(allergies, forKey: "allergies")
        values.setValue(civilId, forKey: "civilId")
        values.setValue(patientID, forKey: "patientId")
        
        values.setValue(dateOfBirth, forKey: "dateOfBirth")
        values.setValue(deleted, forKey: "deleted")
        values.setValue(imageUrl, forKey: "imageUrl")
        values.setValue(status, forKey: "status")

        
        print("Hello its the value \(values)");
        
        
        return values
    }
    
    
    func loadDictionary(values: NSDictionary){
           
        self.firstName = values.valueForKey("firstName") as! String
       
        self.middleName = values.valueForKey("middleName") as! String
        
        self.lastName = values.valueForKey("lastName") as! String
        
        self.email = values.valueForKey("email") as! String
        
               
        self.password = values.valueForKey("password") as! String
        
        self.gender = values.valueForKey("gender") as! String
        
        self.phone = values.valueForKey("phoneNumber") as! String
        
        self.medication = values.valueForKey("medications") as! String
        
        self.asthma = values.valueForKey("asthma") as! Bool
        
        self.diabetes = values.valueForKey("diabetes") as! Bool
        
        self.bloodType = values.valueForKey("bloodType") as! String
        
        self.nationality = values.valueForKey("nationality") as! String
        
        self.emergencyNum = values.valueForKey("emergencyNumber") as! String
        
        self.civilId = values.valueForKey("civilId") as! String
        
        self.allergies = values.valueForKey("allergies") as! String
        
        self.patientID = values.valueForKey("patientId") as! Int
        
        self.dateOfBirth = values.valueForKey("dateOfBirth") as! String
        
        self.deleted = values.valueForKey("deleted") as! Int

        if (values.valueForKey("imageUrl") != nil) {
            self.imageUrl = values.valueForKey("imageUrl") as! String
        } else {
            self.imageUrl = ""
        }

        self.status = values.valueForKey("status") as! Bool

        
    }

}