//
//  Validator.swift
//  MHealth
//

//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class Validator: NSObject {

    func isValidEmail(testStr:String) -> Bool {
        
        
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluateWithObject(testStr)
        
    }
    
     
    
    
    func isPasswordSame(password: String , confirmPassword : String) -> Bool {
        if password == confirmPassword{
            return true
        }
        else{
            
            var alert = UIAlertView(title: "Invalid", message: "Passwords dont match ", delegate: self, cancelButtonTitle: "OK")
            return false
            
        }
    }

    
    
}
