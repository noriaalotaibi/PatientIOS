//
//  MyDoctorsCache.swift
//  MHealth
//
//  Created by Shamlan Al-Roumi on 3/6/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
import Whisper

class MyDoctorsCache: NSObject, NetworkCaller {
    
    private var myDoctors:[DoctorDH] = [DoctorDH]()
    private static var singleton = MyDoctorsCache()
    var caller:NetworkCaller? = nil
    var doctorsCount = 0
    
    public static func myInstance() -> MyDoctorsCache { return singleton }
    
    public func addDoctor( newDoctor: DoctorDH ) {
        myDoctors.append( newDoctor )
    }
    
    public func removeDoctor( removableDoctor: DoctorDH ) {
        for doctor in myDoctors {
            if doctor.drId == removableDoctor.drId {
                let curIndex:Int? = myDoctors.indexOf(doctor)
                myDoctors.removeAtIndex(curIndex!)
            }
        }
    }
    
    public func getDoctors() -> [DoctorDH] { return myDoctors }
    
    override init() {
        // get doctors as array
        super.init()
        
        if (Networking.isInternetAvailable()) {
            let networkManager = Networking()
            networkManager.logging = true
            
            let loggedInPatient = Patient()
            let patient:NSDictionary = NSUserDefaults.standardUserDefaults().valueForKey(Const.UserDefaultsKeys.loggedinUser) as! NSDictionary
            
            loggedInPatient.loadDictionary(patient);
            var ID = loggedInPatient.patientID
            print("Patient ID \(ID)")
            // testing
           // ID = 2
            //
            networkManager.AMGetArrayData("http://34.196.107.188:8081/MhealthWeb/webresources/patient/accepteddoctor/\(ID)", params: [:], reqId: 1, caller: self)
        }
        
        
    }
    
    func setDictResponse(resp:NSDictionary, reqId:Int) {
       
    }
    
    func setArrayResponse(resp:NSArray, reqId:Int) {
        
        // set doctors
        if (reqId == 1) {
            print( resp )
            
            for i in 0..<resp.count {
                let doctor:DoctorDH = DoctorDH()
                doctor.loadDictionary( resp.objectAtIndex(i) as! NSDictionary )
                self.addDoctor(doctor)
            }
            
        }
        self.caller?.setArrayResponse(resp, reqId: reqId)
    }
    

}
