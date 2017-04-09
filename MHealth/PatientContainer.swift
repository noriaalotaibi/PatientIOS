//
//  MyPatient.swift
//  MHealth
//
//  Created by Shamlan Al-Roumi on 3/8/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class PatientContainer: NSObject {
    
    
    private static var singleton:PatientContainer = PatientContainer()
    
    public var loggedInPatient:PatientDH = PatientDH()
    
    static func getInstance() -> PatientContainer { return singleton }
    
    override init() {
        loggedInPatient.id = 4
    }
    
    // to use...   PatientContainer.getInstance().loggedInPatient
    // this returns the Patient Object
    // We will consider this as the logged in patient that we will use for all screens
    
    

}
