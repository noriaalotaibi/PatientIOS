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
    
    func validatePhoneNumber(phoneNumber: NSString?) -> Bool {
        
        if (phoneNumber == nil || phoneNumber == "") {
            return false
        }
        
        let phoneNumberString = phoneNumber!
        
        if (phoneNumberString.length > 15) {
            return false
        }
        
        // has extension? length must be  5 + 8 (Kuwait) / 10 (KSA) /
        
        /*if phoneNumberString.substringToIndex(2) == "00"  {
            if !( phoneNumberString.length == 13 || phoneNumberString.length == 14) {
                return false
            }
        } else {
            // Default kuwaiti number
            if !( phoneNumberString.length == 8) {
                return false
            }
        }*/
        
        return true
    }
    
    func validateEmergencyPhoneNumber(phoneNumber: NSString?) -> Bool {
        
        if (phoneNumber == nil) {
            return true
        }
        
        let phoneNumberString = phoneNumber!
        
        
        if (phoneNumberString == "") { // empty phone number, valid
            return true
        
        } else if !(validatePhoneNumber(phoneNumber)) { // not empty, not valid phone #
            return false
        }
        
        return true
    }
    
    
    func validatePassword(password: NSString?) -> Bool {
        if (password == nil) {
            return false
        }
        
        let passwordStr = password!
        
        if (passwordStr.length < 8) {
            return false
        }
        
        //var civilIdRegex = NSRegularExpression.init(pattern: regex, options: nil)
        
        return true
    }
    
    func validateCivilId(civilId: NSString?) -> Bool {
        if (civilId == nil) {
            return false
        }
        
        let civilIdStr = civilId!
        
        if (civilIdStr.length != 12) {
            return false
        }
        
        //var civilIdRegex = NSRegularExpression.init(pattern: regex, options: nil)
        
        return true
    }
    
}
