//
//  LoginVC.swift
//  MHealth
//
//  Created by trn14 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
import VideoSplashKit
import Whisper

class LoginVC: VideoSplashViewController , NetworkCaller {

    @IBAction func ForgetPassword(sender: AnyObject) {
    }
    @IBOutlet weak var UsernameTF: UITextField!
    
    @IBOutlet weak var PasswordTF: UITextField!
  
    @IBOutlet weak var Image2: UIImageView!
    
    var patientC:PatientContainer?
    var patientID = 0
    
    
    
    @IBAction func LoginButton(sender: AnyObject) {
        
        
        // Read username and password from fields
    

        var username = UsernameTF.text
        
        var password = PasswordTF.text
        
        // Send username and password to service for verification
        
        
        let values:[String:AnyObject] = [NSLocalizedString( "username", comment: ""):username!, NSLocalizedString( "password", comment: ""):password!]
        // NSLocalizedString( "Sending Report ..", comment: "")
        
        print(username)
        let networkManager:Networking = Networking()
        networkManager.logging = true
 
        if (Networking.isInternetAvailable()) {
            networkManager.AMJSONDictionary(Const.URLs.PatientLogin, httpMethod: "POST", jsonData: values, reqId: 0, caller: self)
            PatientContainer.getInstance().loggedInPatient.email = username
            PatientContainer.getInstance().loggedInPatient.password = password!
            // PatientContainer.getInstance().loggedInPatient.patientID = patientID
        }
        else {
            let message = Message(title: NSLocalizedString("No Internet Connection", comment: ""), textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        }
        

        
        
        
        
    }
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        print("Get array resp \(resp)")
        
        
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        print("Get dict resp \(resp)")
        
        let loginError:Int = resp.valueForKey("errorCode") as! Int
        print(loginError)
        
        
        if loginError == 1 {
        
           print(loginError)
            
            var alert = UIAlertView(title:NSLocalizedString("Invalid", comment: "") , message: NSLocalizedString("Invalid Password or Username" , comment: ""), delegate: self, cancelButtonTitle:NSLocalizedString("OK", comment: "") )
            alert.show()
        }
        else {
            let nextScreen:UITabBarController = self.storyboard?.instantiateViewControllerWithIdentifier("TabBar") as! UITabBarController
            var patient = Patient()
            let patientProfile:NSDictionary = resp.objectForKey("items") as! NSDictionary
            patient.loadDictionary(patientProfile)
            NSUserDefaults.standardUserDefaults().setValue(patientProfile, forKey: Const.UserDefaultsKeys.loggedinUser)
            //nextScreen.patient = patient
            
            self.presentViewController(nextScreen, animated: true, completion: {})
            

            
        }
        
//        let loginResult = resp.valueForKey("result") as! Bool
//        if loginResult {
//            
////            let detailsScreen:RegisterPersonalInfoVC = self.storyboard?.instantiateViewControllerWithIdentifier("PatientInfo") as! RegisterPersonalInfoVC
////            
////            var net:UINavigationController = self.navigationController!
////            net.pushViewController(detailsScreen, animated: true)
//        }
//        else {
//            var alert = UIAlertView(title: "Invalid", message: "Invalid Password or Username", delegate: self, cancelButtonTitle: "OK")
//            alert.show()
//        }

    }


    
    @IBAction func RegisterButton(sender: AnyObject) {
        
        
    }
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("heart", ofType: "mp4")!)
        
        self.videoFrame = view.frame
        self.fillMode = .ResizeAspectFill
        self.alwaysRepeat = true
        self.sound = true
        self.startTime = 0.0
        self.duration = 10.0
        self.alpha = 0.7
        self.backgroundColor = UIColor.whiteColor()
        self.contentURL = url
        self.restartForeground = true

        
        if NSUserDefaults.standardUserDefaults().valueForKey(Const.UserDefaultsKeys.loggedinUser) != nil{
            
            let patient:NSDictionary = NSUserDefaults.standardUserDefaults().valueForKey(Const.UserDefaultsKeys.loggedinUser)  as! NSDictionary
            var p:Patient=Patient()
            p.loadDictionary(patient)
            UsernameTF.text = p.email
            PasswordTF.text=p.password
            LoginButton(UIButton())
            
            
            
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(true)
        if (!Networking.isInternetAvailable()) {
            let message = Message(title: NSLocalizedString("No Internet Connection", comment: ""), textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
            
            
            
            
           
            
        }
        
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
