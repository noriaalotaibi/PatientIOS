//
//  PatientDH.swift
//  MHealth
//
//  Created by Abrar Al-Failakawi on 3/6/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import Foundation

class PatientDH: NSObject, DataHolder {


    var id:Int = 0
    var firstName:String = ""
    var middleName:String = ""
    var lastName:String = ""
    
    var email:String? = ""
    var civilId:String = ""
    var birthDate:String = ""
    var gender:String = ""
    var password:String = ""
    var phone:String = ""
    var emergencyNum:String = ""
    var nationality:String = ""
    var bloodType:String = ""
    var diabetes:String = ""
    var asthma:String = ""
    var medication:String = ""
    var allergies:String = ""
   
    func toDictionary() -> NSDictionary {
        
        let values:NSMutableDictionary = NSMutableDictionary()
        
        values.setValue(id, forKey: "patientId")
        values.setValue(firstName, forKey: "firstName")
        values.setValue(middleName, forKey: "middleName")
        values.setValue(lastName, forKey: "lastName")
        values.setValue(email, forKey: "email")
        values.setValue(birthDate, forKey: "dateOfBirth")
        values.setValue(password, forKey: "password")
        values.setValue(gender, forKey: "gender")
        values.setValue(phone, forKey: "phoneNumber")
        values.setValue(emergencyNum, forKey: "emergencyNumber")
        values.setValue(nationality, forKey: "nationality")
        values.setValue(bloodType, forKey: "bloodType")
        values.setValue(diabetes, forKey: "diabetes")
        values.setValue(asthma, forKey: "asthma")
        values.setValue(medication, forKey: "medication")
        values.setValue(allergies, forKey: "allergies")
        values.setValue(civilId, forKey: "civilId")
        
        return values
    }
    
    func loadDictionary(values: NSDictionary) {
        self.id = values.valueForKey("patientId") as! Int
        self.firstName = values.valueForKey("firstName") as! String
        self.middleName = values.valueForKey("middleName") as! String
        self.lastName = values.valueForKey("lastName") as! String
        self.email = values.valueForKey("email") as! String
        self.birthDate = values.valueForKey("dateOfBirth") as! String
        self.password = values.valueForKey("password") as! String
        self.gender = values.valueForKey("gender") as! String
        self.phone = values.valueForKey("phoneNumber") as! String
        self.medication = values.valueForKey("medication") as! String
        self.asthma = values.valueForKey("asthma") as! String
        self.diabetes = values.valueForKey("diabetes") as! String
        self.bloodType = values.valueForKey("bloodType") as! String
        self.nationality = values.valueForKey("nationality") as! String
        self.emergencyNum = values.valueForKey("emergencyNumber") as! String
        self.civilId = values.valueForKey("civilId") as! String
        self.allergies = values.valueForKey("allergies") as! String
    }
    


}