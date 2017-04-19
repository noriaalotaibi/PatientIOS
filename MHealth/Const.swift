//
//  Const.swift
//  MHealth
//
//  Created by Ahmed on 3/4/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class Const: NSObject {

    struct URLs {
        static let BASE:String = "http://34.196.107.188:8081/MhealthWeb/webresources"
        static let BBAdmin:String = BASE + "/BBAdmin"
        static let EditStatus:String = BASE + "/newdonationrecord/editStatus"
        static let Patients:String = BASE + "/patient"
        static let PatientLogin:String = BASE + "/patient/login"
        static let PatientInvitationRequest:String = BASE + "/patientdrlink"
        static let ReportURL:String = BASE + "/report"
        static let ResetPassword:String = BASE + "/patient/reset"
        static let Hospital:String = BASE + "/hospital"
        
        static let PatientReport:String = BASE + "/patientreport"
        static let UploadImage:String = "http://34.196.107.188:8081/MhealthWeb/addimgtogallery"

    }
    
    struct Files {
        let CACHE:String = ""
    }
    
    struct UserDefaultsKeys {
        let langKey = "lang"
        static let patientId = "patientId"
        static let loggedinUser = "loggedinUser"
        static let hospitalId = "hospitalId"
        static let hospitalProfile = "hospitalProfile"
        
    }
}
