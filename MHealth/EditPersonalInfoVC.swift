//
//  EditPersonalInfoVC.swift
//  MHealth
//
//  Created by Abrar Al-Failakawi on 3/7/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
import Whisper

class EditPersonalInfoVC: UIViewController , NetworkCaller {
  var bDay=""
    var valuesDict:NSDictionary = NSDictionary()
    var gender:String = ""
    @IBAction func GenderSegment(sender: AnyObject) {
        if sender.selectedSegmentIndex == 0 {
            self.gender = "m"
        }else  {
            self.gender = "f"
        }
    }
    @IBAction func textFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(EditPersonalInfoVC.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }

    @IBOutlet weak var FnameLB: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var LnameLB: UITextField!
    @IBOutlet weak var CivilIDLB: UITextField!
 
    @IBOutlet weak var EmailLB: UITextField!
    @IBOutlet weak var PasswordLB: UITextField!
    @IBOutlet weak var PhoneLB: UITextField!
    @IBOutlet weak var EmergencyLB: UITextField!
    @IBOutlet weak var NationalityLB: UITextField!
   
   
   
   
    
    var patient=Patient()
    var newPatient=Patient()
    
    var records:NSMutableArray = NSMutableArray()
    
    @IBAction func UpdateButton(sender: AnyObject) {
        
      //  bDay = dateTextField.text!
        
        var fname = FnameLB.text
        var lname = LnameLB.text
        var civilId = CivilIDLB.text
        var email = EmailLB.text
        var phoneNum = PhoneLB.text
        var emergencyNum = EmergencyLB.text
        var nationality = NationalityLB.text
        var password = PasswordLB.text
        
        let modifiedPatient:Patient = Patient()
        modifiedPatient.loadDictionary(patient.toDictionary())
        
        modifiedPatient.firstName = fname!
        modifiedPatient.lastName=lname!
        modifiedPatient.civilId=civilId!
        modifiedPatient.email=email!
        modifiedPatient.phone=phoneNum!
        modifiedPatient.emergencyNum=emergencyNum!
        modifiedPatient.nationality=nationality!
        modifiedPatient.password=password!
        
        var valid = true
        
        if fname == "" || lname == "" || nationality == "" || civilId == "" || phoneNum == ""  {
            var alert = UIAlertView(title: NSLocalizedString("Empty Fields", comment: "") , message:NSLocalizedString("Please fill all the missing fields", comment: "")  , delegate: self, cancelButtonTitle:NSLocalizedString("OK", comment: "")  )
            
            alert.show()
            
            valid = false
            return
        }
        else if  !( Validator().validateCivilId(civilId) ) {
            
            var alert = UIAlertView(title: NSLocalizedString("Civil ID", comment: ""), message: NSLocalizedString("Invalid Civil ID", comment: ""), delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
            valid = false
            return
        }
        else if !( Validator().validatePhoneNumber(phoneNum) ) {
            var alert = UIAlertView(title: NSLocalizedString("Phone Number", comment: ""), message: NSLocalizedString("Invalid Phone Number", comment: "") , delegate: self, cancelButtonTitle: NSLocalizedString("OK", comment: ""))
            alert.show()
            
            valid = false
        }
        else if !( Validator().validateEmergencyPhoneNumber(emergencyNum) ) {
            var alert = UIAlertView(title: NSLocalizedString("Phone Number", comment: ""), message: NSLocalizedString("Invalid Phone Number", comment: "") , delegate: self, cancelButtonTitle: NSLocalizedString("OK", comment: ""))
            alert.show()
            
            valid = false
        }

        let networkManager:Networking = Networking()

        
     valuesDict =  modifiedPatient.toDictionary()
        
        //newPatient.password=password!
      //  current.newPatient.gender=gender
        
        if (valid) {
            print("values for update")
            print(valuesDict)
            networkManager.AMJSONDictionary(Const.URLs.Patients + "/" + "\(patient.patientID)", httpMethod: "PUT", jsonData: valuesDict, reqId: 1, caller: self)
        } else {
            return
        }
       
        
//        var alert = UIAlertView(title: "Success", message: "Updated", delegate: self, cancelButtonTitle: "OK")
//        alert.show()
        
      //  trgytgtgtggtgt
        
       
       
        
    }
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        print(resp)
        
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        print("response: ")
        print(resp)
        
        
        let loginError:Int = resp.valueForKey("errorCode") as! Int
        print(loginError)
        
        
        if loginError == 200 {
            
            print(loginError)
            
             NSUserDefaults.standardUserDefaults().setValue(valuesDict, forKey: Const.UserDefaultsKeys.loggedinUser)
            
            var alert = UIAlertView(title: NSLocalizedString("Updated", comment: ""), message: NSLocalizedString("Profile updated", comment: ""), delegate: self, cancelButtonTitle: NSLocalizedString("OK", comment: ""))
            alert.show()
        }
        else {
            
            var alert = UIAlertView(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Failed to update the profile", comment: ""), delegate: self, cancelButtonTitle: NSLocalizedString("OK", comment: ""))
            alert.show()
            
        }
       
    }
    
  
   override func viewDidLoad() {
        super.viewDidLoad()
    
    
    let net:Networking = Networking()
  //  net.AMGetArrayData(Const.URLs.Patients, params: [:], reqId: 1, caller: self)
    
    let Patient:NSDictionary = NSUserDefaults.standardUserDefaults().valueForKey(Const.UserDefaultsKeys.loggedinUser) as! NSDictionary
  
    print("patient json")
    print(Patient)
    patient.loadDictionary(Patient);
    
    
    print("patient object")
    print(patient)
    
    FnameLB?.text  = patient.firstName
    dateTextField.text = patient.dateOfBirth
    CivilIDLB?.text = patient.civilId
    LnameLB?.text      = patient.lastName
    NationalityLB?.text = patient.nationality
    PasswordLB.text = patient.password
    EmailLB?.text = patient.email
    PhoneLB?.text = patient.phone
    EmergencyLB?.text = patient.emergencyNum
    gender=patient.gender
    self.bDay = patient.dateOfBirth
    
    
    // Painter
    
//    let painter:AYPainter = AYPainter()
//    painter.setTheme(AYTheme.loadThemeFromFile("BlueTheme"))
//    painter.paint(self.view)
    
    // END Painter
    }
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        dateTextField.text = dateFormatter.stringFromDate(sender.date)
        //        Reg1VC.current.newPatient.birthDate = bDay;
        
        let date = sender.date
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        
        self.bDay = "\(year)-\(month)-\(day)"
    }
    
    override func viewDidAppear(animated: Bool) {
        if (!Networking.isInternetAvailable()) {
            let message = Message(title: NSLocalizedString("No Internet Connection", comment: ""), textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        }
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
