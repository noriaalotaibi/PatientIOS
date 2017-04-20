//
//  RegisterPersonalInfoVC.swift
//  MHealth
//
//  Created by trn14 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
import Whisper

class RegisterPersonalInfoVC: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {

    
    var bDay=""
    @IBOutlet weak var fNameTF: UITextField!
    
    @IBOutlet weak var mNameTF: UITextField!
    @IBOutlet weak var PhoneNumberTF: UITextField!
    @IBOutlet weak var EmergencyNumberTF: UITextField!
    
    @IBOutlet weak var lNameTF: UITextField!
    @IBOutlet weak var CivilIDTF: UITextField!
     @IBOutlet var dateTextField: UITextField!
    
    @IBAction func textFieldEditing(sender: UITextField) {
        // 6
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(RegisterPersonalInfoVC.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)

    }

     
   
    @IBOutlet weak var NationalityTF: UITextField!
    
  
    
    
    @IBOutlet weak var RegNextButtonOutlet: UIButton!
    
    @IBAction func reg2Button(sender: AnyObject) {
        var emptyTitle = Langs.arabicTitleForString("Empty Fields")
        var emptyMsg = Langs.arabicTitleForString("Please fill all the missing fields")
        var CivilTitle = Langs.arabicTitleForString("Civil ID")
        var civilMsg = Langs.arabicTitleForString("Invalid Civil ID")
        var phoneTitle = Langs.arabicTitleForString("Phone Number")
        var phoneMsg = Langs.arabicTitleForString("Invalid Phone Number")
        var cancelButton = Langs.arabicTitleForString("OK")
        var valid = true
        
        var fname = fNameTF.text
        var lname = lNameTF.text
        var nationality = NationalityTF.text
        var civilId = CivilIDTF.text
        var phone = PhoneNumberTF.text
        var emergency = EmergencyNumberTF.text
        var deleted:Int=0
        var status:Bool=true
        
        if fname == "" || lname == "" || nationality == "" || civilId == "" || phone == ""  {
            var alert = UIAlertView(title: emptyTitle , message: emptyMsg  , delegate: self, cancelButtonTitle: cancelButton  )
            
            alert.show()
            
            valid = false
            return
        }
        else if  !( Validator().validateCivilId(civilId) ) {
            
            var alert = UIAlertView(title: CivilTitle, message: civilMsg, delegate: self, cancelButtonTitle: cancelButton)
            alert.show()
            
            valid = false
            return
        }
        else if !( Validator().validatePhoneNumber(phone) ) {
            var alert = UIAlertView(title: phoneTitle, message: phoneMsg , delegate: self, cancelButtonTitle: cancelButton)
            alert.show()
            
            valid = false
        }
        else if !( Validator().validateEmergencyPhoneNumber(emergency) ) {
            var alert = UIAlertView(title:phoneTitle, message: phoneMsg , delegate: self, cancelButtonTitle: cancelButton)
            alert.show()
            
            valid = false
        }
        
        Reg1VC.current.newPatient.firstName=fname!
        Reg1VC.current.newPatient.lastName=lname!
        Reg1VC.current.newPatient.dateOfBirth=bDay
        Reg1VC.current.newPatient.civilId=civilId!
        Reg1VC.current.newPatient.nationality=nationality!
        Reg1VC.current.newPatient.phone=phone!
        Reg1VC.current.newPatient.emergencyNum=emergency!
        Reg1VC.current.newPatient.deleted=deleted
        Reg1VC.current.newPatient.status=status
        
        
        if (valid) {
            let next:RegisterMedicalInfoVC = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterMedicalInfo") as! RegisterMedicalInfoVC
        
            self.navigationController?.pushViewController(next, animated: true)
        }
        
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fNameTF.delegate = self
        
        mNameTF.delegate = self
        PhoneNumberTF.delegate = self
        EmergencyNumberTF.delegate = self
        
        lNameTF.delegate = self
        CivilIDTF.delegate = self
        dateTextField.delegate = self
        NationalityTF.delegate = self

        
        // Painter
        
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
        var noInternet = Langs.arabicTitleForString("No Internet Connection")
        
        if (!Networking.isInternetAvailable()) {
            
            let message = Message(title: noInternet, textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        }
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
        
        let date = sender.date
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        
        self.bDay = "\(year)-\(month)-\(day)"
    }


    
}