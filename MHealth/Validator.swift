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

    
    func validateEmail (email:String) -> Bool
    {
    
        if email == ""{
        
            return false
        }
        return true
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

    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.sharedApplication().canOpenURL(url)
            }
        }
        return false
    }
    
}
