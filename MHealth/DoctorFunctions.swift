//
//  DoctorFunctions.swift
//  MHealth
//
//  Created by Shamlan Al-Roumi on 3/8/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class DoctorFunctions: NSObject, NetworkCaller {
    
    private static var singleton = DoctorFunctions()
    var callerReport:NetworkCaller? = nil
    var callerInvitation:NetworkCaller? = nil
    
    public static func myInstance()-> DoctorFunctions {
        return singleton
    }
    

    
    func sendReport(patient: UserDH, doctor: DoctorDH, report: PatientReportDH) {
        let networkManager = Networking()
        networkManager.logging = true
       
        let data: NSDictionary = ["bloodPressure":report.bloodPressure,"comments":report.comments,"coughing":report.coughing,"dizziness":report.dizziness,"drId": doctor.drId,"drcomment":report.drcomment,"fever":report.fever,"headache":report.headache,"heartbeatRate":report.heartbeatRate,"nauseous":report.nauseous,"pain":report.pain,"painlocation":report.painlocation,"patientId":2,"sugarLevel":report.sugarLevel]
        
        networkManager.AMJSONArray("http://34.196.107.188:8080/mHealthWS/ws/doctor", httpMethod: "POST", jsonData: data, reqId: 1, caller: self)
        
        
    }
    
    func sendInvitationRequest(patient: Patient, doctor: DoctorDH) {
        let networkManager = Networking()
        networkManager.logging = true
        
        
        //let data: NSDictionary = ["drId": doctor.drId, "patientId": patient.patientID, "status": 0]
        //"addingTime": timestamp
        
        //networkManager.AMGetDictData("http://34.196.107.188:8081/MhealthWeb/webresources/getPr/\(patient.patientID)", httpMethod: "GET", reqId: 2, caller: self)
        
    }
    
    // Sends response to delegate classes (View Controllers) once response is received
    // reqId: 1  -> Invitation request response
    // reqId: 2  -> Patient report request response
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        if (reqId == 1) {
            self.callerReport?.setDictResponse(resp, reqId: reqId)
        } else if (reqId == 2) {
            self.callerInvitation?.setDictResponse(resp, reqId: reqId)
        }
    }
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        if (reqId == 1) {
            self.callerReport?.setArrayResponse(resp, reqId: reqId)
            print(resp)
        } else if (reqId == 2) {
            self.callerInvitation?.setArrayResponse(resp, reqId: reqId)
            print(resp)
        }
    }

}
