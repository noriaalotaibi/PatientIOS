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
        
            // get ids of doctors with invitation
            networkManager.AMGetArrayData("http://34.196.107.188:8080/mHealthWS/ws/patientdrlink", params: [:], reqId: 1, caller: self)
        } else {

        }
        
        
    }
    
    func setDictResponse(resp:NSDictionary, reqId:Int) {
        if (reqId >= 2) {
            let doctor:DoctorDH = DoctorDH()
            doctor.loadDictionary( resp )
            self.addDoctor( doctor )
            if reqId == 1+doctorsCount{
                caller?.setDictResponse(resp, reqId: reqId)
            }
        }
       
    }
    
    func setArrayResponse(resp:NSArray, reqId:Int) {
        
        // patient linked ids response
        if (reqId == 1) {
            let myDoctorsIds:NSMutableArray = NSMutableArray()
            for id in resp {
                
                let linkedDoctorDictionary:NSDictionary = id as! NSDictionary
                let patientId:Int = linkedDoctorDictionary.valueForKey("patientId") as! Int
                let doctorId:Int = linkedDoctorDictionary.valueForKey("drId") as! Int
                let status:Int = linkedDoctorDictionary.valueForKey("status") as! Int
                if (patientId == PatientContainer.getInstance().loggedInPatient.id && status == 1) {
                    myDoctorsIds.addObject(doctorId)
                }
            }
            doctorsCount = myDoctorsIds.count
            for i in 0 ..< myDoctorsIds.count{
                let d = myDoctorsIds.objectAtIndex(i) as! Int
                //print(d)

                let path = "http://34.196.107.188:8080/mHealthWS/ws/doctor/\(d)"
                //print(path)
                let networkManager = Networking()
                networkManager.logging = true
                networkManager.AMGetDictData(path, params: [:], reqId: 2+i, caller: self)
            }
            
            
        }
        
    }
    

}
