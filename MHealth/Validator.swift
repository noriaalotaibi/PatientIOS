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
        
        print("PhoneNumber :\(phoneNumber)")
        if (phoneNumber == nil || phoneNumber == "") {
            return false
        }
        
        let phoneNumberString = phoneNumber!
        
        // has extension? length must be  5 + 8/9
        if phoneNumberString.substringToIndex(1) == "00"  {
            if !( phoneNumberString.length == 12 || phoneNumberString.length == 11) {
                return false
            }
        } else {
            if !( phoneNumberString.length == 8 || phoneNumberString.length == 9) {
                return false
            }
        }
        
        return true
    }
    
    func validateEmergencyPhoneNumber(phoneNumber: NSString?) -> Bool {
        
        if (phoneNumber == nil) {
            return false
        }
        
        let phoneNumberString = phoneNumber!
        
        
        if (phoneNumberString == "") { // empty phone number, valid
            return true
        
        } else if !(validatePhoneNumber(phoneNumber)) { // not empty, not valid phone #
            return false
        }
        
        return true
    }
    
    func validateCivilId(civilId: NSString?) -> Bool {
        if (civilId == nil) {
            return false
        }
        
        let civilIdStr = civilId!
        
        if (civilIdStr.length <= 8 || civilIdStr == "" ) {
            return false
        }
        
        //var civilIdRegex = NSRegularExpression.init(pattern: regex, options: nil)
        
    }
    
}
