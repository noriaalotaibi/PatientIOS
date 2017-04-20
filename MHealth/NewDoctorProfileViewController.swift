//
//  NewDoctorProfileViewController.swift
//  MHealth
//
//  Created by trn15 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
import Whisper
import SwiftSpinner
class NewDoctorProfileViewController: UIViewController, NetworkCaller {
    
    var newDoctor:DoctorDH = DoctorDH()
    var callerManager:DoctorFunctions? = nil

    

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSpecialty: UILabel!
    @IBOutlet weak var labelLocation: UILabel!

    @IBOutlet weak var localGender: UILabel!
    @IBOutlet weak var labelGender: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelName.text = newDoctor.firstName
        labelSpecialty.text = newDoctor.specialtyId
        labelLocation.text = newDoctor.location
       labelGender.text = newDoctor.gender
        
        callerManager = DoctorFunctions.myInstance()
        callerManager?.callerInvitation = self
        
        localGender.text=Langs.arabicTitleForString("Gender")
        
        //labelGender.text=Langs.arabicTitleForString("Gender")
        

        
    }
    
    override func viewDidAppear(animated: Bool) {
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
    
    @IBAction func sendInvitationRequest(sender: AnyObject) {
        
        let patientDic:NSDictionary = NSUserDefaults.standardUserDefaults().valueForKey(Const.UserDefaultsKeys.loggedinUser) as! NSDictionary
        
        let patient:Patient = Patient()
        patient.loadDictionary(patientDic);
        
        //   patient!.loadDictionary(Patient)
        
        patient.loadDictionary(patientDic);
        
        print (newDoctor.drId)

        // Send Invitation Request
        
        let data: NSDictionary = ["drId": newDoctor.drId, "patientId": patient.patientID, "status": "0"]
        //"addingTime": timestamp
        
        if (Networking.isInternetAvailable()) {
            let networkManager = Networking()
            networkManager.logging = true
            SwiftSpinner.show("Connecting...")
            SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 22.0))
            networkManager.AMJSONDictionary(Const.URLs.PatientInvitationRequest, httpMethod: "POST", jsonData: data, reqId: 2, caller: self)
        } else {
            let message = Message(title:NSLocalizedString("No Internet Connection", comment: "") , textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        }
        
        
    }
    // Response in case of invitation sent
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        print(resp)
        SwiftSpinner.hide()
        if resp.count == 0 {
            let alertControlle:UIAlertController = UIAlertController(title: NSLocalizedString("Success", comment: ""), message: NSLocalizedString("Invitation was sent sucessfully", comment: ""), preferredStyle: .Alert)
            
            let action:UIAlertAction =  UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Cancel, handler: { (UIAlertAction) in
                self.navigationController?.popViewControllerAnimated(true)
            })
            alertControlle.addAction(action)
            self.presentViewController(alertControlle, animated: true, completion: nil)
            
            
        }else{
            let alertControlle:UIAlertController = UIAlertController(title: NSLocalizedString("Failed", comment: ""), message: NSLocalizedString("Invitation failed to send", comment: ""), preferredStyle: .Alert)
            
            let action:UIAlertAction =  UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Cancel, handler: { (UIAlertAction) in
            })
            alertControlle.addAction(action)
            self.presentViewController(alertControlle, animated: true, completion: nil)
        }
    }
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        

    }

}
