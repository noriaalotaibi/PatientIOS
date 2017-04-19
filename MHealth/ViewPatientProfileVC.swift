//
//  ViewPatientProfileVC.swift
//  MHealth
//
//  Created by trn14 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
import Whisper
import SwiftSpinner

class ViewPatientProfileVC: UIViewController, NetworkCaller,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var LnameLabel: UILabel!
    @IBOutlet weak var FnameLabel: UILabel!
    @IBOutlet weak var MnameLabel: UILabel!
    @IBOutlet weak var NationalityLabel: UILabel!
    @IBOutlet weak var CivilIdLabel: UILabel!
    @IBOutlet weak var GenderLabel: UILabel!
    @IBOutlet weak var BirthDateLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PhoneNumLabel: UILabel!
    @IBOutlet weak var EmergencyNumLabel: UILabel!
    
    var updatedPatient:Patient?

    var patient=Patient()
    let networkManager:Networking = Networking()

    var newPatient:Patient = Patient()

    var tempImageHolder:UIImage?
    
    @IBOutlet weak var patientImage: UIImageView!
    
    @IBAction func logoutButton(sender: UIButton) {
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: Const.UserDefaultsKeys.patientId)
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: Const.UserDefaultsKeys.loggedinUser)
        self.dismissViewControllerAnimated(true) {
            
        }
        
    }
    @IBAction func editPatientPhoto(sender: UIButton) {
        let alertController = UIAlertController(title: "Upload Image", message: "Choose one of the two options", preferredStyle: .ActionSheet)
        
        let CameraRollAction = UIAlertAction(title: "Camera roll", style: .Default, handler: {(action: UIAlertAction) -> Void in
            print("Camera Roll")
            
            let imagePicker:UIImagePickerController = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
        })
        
        let CameraAction = UIAlertAction(title: "Take photo", style: .Default, handler: {(action: UIAlertAction) -> Void in
            print("Camera ")
            let imagePicker:UIImagePickerController = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        })
        
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {(action: UIAlertAction) -> Void in
            print("Cancel")
        })
        
        alertController.addAction(CameraAction)
        alertController.addAction(CameraRollAction)
        alertController.addAction(CancelAction)
        
        self.presentViewController(alertController, animated: true, completion: { _ in })
        
        print ("Button clicked")
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        //Encode base64
        let imageData = UIImagePNGRepresentation(image)

        
        let strBase64:String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)

        
        
        tempImageHolder = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let reach = Reach()
        if reach.connectionStatus().description == ReachabilityStatus.Offline.description{
            let message = Message(title: "No Internet Connection", textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        }else{
            SwiftSpinner.show(NSLocalizedString("Uploading...", comment: ""))
            
            
            let params:[String:AnyObject] = ["appID": "patient" , "imgData": strBase64 , "title":"" , "description":""]
            
            networkManager.AMPostDictData(Const.URLs.UploadImage, params: params, reqId: 5, caller: self)
        }
        
    }
    

    @IBAction func UpdateProfile(sender: AnyObject) {}
    
    @IBAction func ViewMedicalInfoButton(sender: AnyObject) {
         print("user clicked More")
        
        //        let nextScreen:ViewMedicalInfoVC = self.storyboard?.instantiateViewControllerWithIdentifier("viewMedicalInfo") as! ViewMedicalInfoVC
        //
        //        self.presentViewController(nextScreen, animated: true, completion: {})
        
        //   let nav:UINavigationController = self.navigationController!
        
        //  nav.pushViewController(nextScreen, animated: true)
 
    }
    
//    var records:NSMutableArray = NSMutableArray()
//    var index:Int = 0

//    func loadData() {
////        
////        print( patient?.toDictionary())
////       
////        
////       // print(patient?.firstName)
////        CivilIdLabel?.text       = patient?.civilId
////        MnameLabel?.text    = patient?.middleName
////        LnameLabel?.text      = patient?.lastName
////        NationalityLabel?.text = patient?.nationality
////        GenderLabel?.text = patient?.gender
////        BirthDateLabel?.text = patient?.birthDate
////        EmailLabel?.text = patient?.email
////        PhoneNumLabel?.text = patient?.phone
////        EmergencyNumLabel?.text = patient?.emergencyNum
//        
//        
//    }

   
    override func viewDidLoad() {
     //   var current_lan = NSUserDefaults.standardUserDefaults().valueForKey("AppleLanguages");
        
        super.viewDidLoad()
        
        
   
        
    
        let Patient:NSDictionary = NSUserDefaults.standardUserDefaults().valueForKey(Const.UserDefaultsKeys.loggedinUser) as! NSDictionary
        
        patient.loadDictionary(Patient);
        if Validator().verifyUrl(patient.imageUrl)
        {
            let url:NSURL = NSURL(string: patient.imageUrl)!
            self.patientImage.sd_setImageWithURL(url, placeholderImage: UIImage(named: "profileImage"))
            
        }
        
        
        // PAINTER
        
//        let painter:AYPainter = AYPainter()
//        painter.setTheme(AYTheme.loadThemeFromFile("BlueTheme"))
//        painter.paint(self.view)
        
        // END Painter
    }
    
    
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
       // print(resp)
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {

        SwiftSpinner.hide()
        
        if resp.valueForKey("Error") != nil && reqId == 5 {
            
            let alert:UIAlertController = Alert().getAlert(NSLocalizedString("Error", comment: ""), msg: "Image size is too big, try different image")
            self.presentViewController(alert, animated: true, completion: nil)
            return
            
        }else if resp.valueForKey("Error") != nil && reqId == 6{
            let alert:UIAlertController = Alert().getAlert(NSLocalizedString("Error", comment: ""), msg: "Cannot update profile, try again later")
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        
        if reqId == 5 {
            print("response Upload image")
            if (resp.valueForKey("errorMsgEn") != nil) {
                let result:String = resp.valueForKey("errorMsgEn") as! String
                if result.lowercaseString == "Done".lowercaseString{
                    let alertControlle:UIAlertController = UIAlertController(title: "Image Upload", message: "Upload successful", preferredStyle: .Alert)
                    
                    //UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                    let action:UIAlertAction =  UIAlertAction(title: NSLocalizedString( "OK", comment: ""), style: .Cancel, handler: { (UIAlertAction) in
                        let imgPath:String = resp.valueForKey("imgPath") as! String
                        self.UpdatePatientProfileImage(imgPath)
                    })
                    alertControlle.addAction(action)
                    self.presentViewController(alertControlle, animated: true, completion: nil)
                }else{
                    let alert:UIAlertController = Alert().getAlert(NSLocalizedString("Error", comment: ""), msg: NSLocalizedString("Can't upload image right now", comment: ""))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        }else if reqId == 6{
            print("response update profile")
            if (resp.valueForKey("errorMsgEn") == nil){
                let alert:UIAlertController = Alert().getAlert(NSLocalizedString("Error", comment: ""), msg: NSLocalizedString("Can't update profile right now", comment: ""))
                self.presentViewController(alert, animated: true, completion: nil)
                return
                //alert
            }
            
            let responseMessage:String = resp.valueForKey("errorMsgEn") as! String
            
            if responseMessage != "Done" {
                
                let alert:UIAlertController = Alert().getAlert(NSLocalizedString("Error", comment: ""), msg: NSLocalizedString("Can't update profile right now", comment: ""))
                
                self.presentViewController(alert, animated: true, completion: nil)
                
                return
            }
            
            
            let alert:UIAlertController = Alert().getAlert(NSLocalizedString("Updated", comment: ""), msg: NSLocalizedString("Profile is updated", comment: ""))
            
            
            NSUserDefaults.standardUserDefaults().setObject(updatedPatient!.toDictionary(), forKey: Const.UserDefaultsKeys.loggedinUser)
            
            self.patientImage.image = tempImageHolder
            if Validator().verifyUrl(updatedPatient!.imageUrl)
            {
                let url:NSURL = NSURL(string: updatedPatient!.imageUrl)!
                self.patientImage.sd_setImageWithURL(url, placeholderImage: UIImage(named: "profileImage"))
                
            }
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }

    func UpdatePatientProfileImage(imgPath:String) {
        
        
        let patientDic:NSDictionary = NSUserDefaults.standardUserDefaults().valueForKey(Const.UserDefaultsKeys.loggedinUser) as! NSDictionary
        
        //   patient!.loadDictionary(Patient)
        let newPatient:Patient = Patient()
        newPatient.loadDictionary(patientDic);

        newPatient.imageUrl = imgPath
        
        let url:String = Const.URLs.Patients + "/" + "\(patient.patientID)"
        
        self.updatedPatient = newPatient;
        
        let reach = Reach()
        
        print ("Connection status!!!!!!!:")
        if reach.connectionStatus().description == ReachabilityStatus.Offline.description{
            let message = Message(title: "No Internet Connection", textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        }else{
            SwiftSpinner.show(NSLocalizedString("Connecting...", comment: ""))
            networkManager.AMJSONDictionary(url, httpMethod: "PUT", jsonData: newPatient.toDictionary(), reqId: 6, caller: self)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let net:Networking = Networking()
        net.AMGetArrayData(Const.URLs.Patients, params: [:], reqId: 1, caller: self)
        
        let Patient:NSDictionary = NSUserDefaults.standardUserDefaults().valueForKey(Const.UserDefaultsKeys.loggedinUser) as! NSDictionary
        
        //   patient!.loadDictionary(Patient)
        
        patient.loadDictionary(Patient);
        
        FnameLabel?.text  = patient.firstName
        CivilIdLabel?.text = patient.civilId
        LnameLabel?.text      = patient.lastName
        NationalityLabel?.text = patient.nationality
        if patient.gender.characters.first == "f" || patient.gender.characters.first == "F" {
            GenderLabel?.text = "Female"
        }else{
            GenderLabel?.text = "Male"
        }
        
        BirthDateLabel?.text = patient.dateOfBirth
        EmailLabel?.text = patient.email
        PhoneNumLabel?.text = patient.phone
        EmergencyNumLabel?.text = patient.emergencyNum
        
        
        
        if (!Networking.isInternetAvailable()) {
            let message = Message(title: NSLocalizedString("No Internet Connection", comment: ""), textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        }
        
        
        // Painter
        
//        let painter:AYPainter = AYPainter()
//        painter.setTheme(AYTheme.loadThemeFromFile("BlueTheme"))
//        painter.paint(self.view)

        
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
