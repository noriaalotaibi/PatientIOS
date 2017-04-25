//
//  ResetPass.swift
//  MHealth
//
//  Created by Abrar Al-Failakawi on 3/6/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
import Whisper
import SwiftSpinner
class ResetPass: UIViewController ,NetworkCaller,UITextFieldDelegate {

    
    
    let networkManager:Networking = Networking()
    @IBOutlet weak var emailTF: UITextField!
    
    
    @IBOutlet weak var CivilidTF: UITextField!
    
    @IBAction func ResetPassButton(sender: AnyObject) {
        
        
        //add civil id civilid
       // var resetPass = emailTF.text
        let email:String = emailTF.text!
        let civil:String = CivilidTF.text!
        
        
      //  let values:[String:AnyObject] = ["email":resetPass!]
        
//        networkManager.AMJSONDictionary(Const.URLs.ResetPassword, httpMethod: "POST", jsonData: values, reqId: 0, caller: self)

        var valid = true
        
        if !( Validator().validateEmail(email) )
        {
            print("please enter a valid email")
            valid = false
            return
        }
        
        if  !( Validator().validateCivilId(civil) ) {
            var CivilTitle = Langs.arabicTitleForString("Civil ID")
            var civilMsg = Langs.arabicTitleForString("Invalid Civil ID")
            var cancelButton = Langs.arabicTitleForString("OK")
            var alert = UIAlertView(title: CivilTitle, message: civilMsg, delegate: self, cancelButtonTitle: cancelButton )
            alert.show()
            
            valid = false
            return
        }

        if (valid) {
            SwiftSpinner.show("Connecting...")
            SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 22.0))
            networkManager.AMJSONDictionary(Const.URLs.ResetPassword, httpMethod: "POST", jsonData: ["username":email, "civilid":civil], reqId: 3, caller: self)
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        emailTF.delegate = self
        CivilidTF.delegate = self
        
        // Painter
//        let painter:AYPainter = AYPainter()
//        painter.setTheme(AYTheme.loadThemeFromFile("BlueTheme"))
//        painter.paint(self.view)
        
        // END Painter
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewDidAppear(animated: Bool) {
        var noNetwork = Langs.arabicTitleForString("No Internet Connection")
        if (!Networking.isInternetAvailable()) {
            let message = Message(title: noNetwork, textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
     SwiftSpinner.hide()
        if (resp.valueForKey("errorMsgEn") == nil){
            
            print("Error Connection to server Error")
            var cancelButton = Langs.arabicTitleForString("OK")
            
            var alert = UIAlertView(title:"", message: "" , delegate: self, cancelButtonTitle: cancelButton)
            return
        }
        
        
        let responseMessage:String = resp.valueForKey("errorMsgEn") as! String
        

            print("password is sent")
            var cancelButton = Langs.arabicTitleForString("OK")
        
                var massageE = Langs.arabicTitleForString("Please check your email for the new password")
            var alert = UIAlertView(title:"Successful", message: massageE , delegate: self, cancelButtonTitle: cancelButton)
            alert.show()

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
