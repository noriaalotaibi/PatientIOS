//
//  RegisterPersonalInfoVC.swift
//  MHealth
//
//  Created by trn14 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
import Whisper

class RegisterPersonalInfoVC: UIViewController, UIPickerViewDelegate {

    let networkManeger:Networking = Networking()
    
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
        else if !( Validator().validatePhoneNumber(phone) ) {
            var alert = UIAlertView(title: NSLocalizedString("Phone Number", comment: ""), message: NSLocalizedString("Invalid Phone Number", comment: "") , delegate: self, cancelButtonTitle: NSLocalizedString("OK", comment: ""))
            alert.show()
            
            valid = false
        }
        else if !( Validator().validateEmergencyPhoneNumber(emergency) ) {
            var alert = UIAlertView(title: NSLocalizedString("Phone Number", comment: ""), message: NSLocalizedString("Invalid Phone Number", comment: "") , delegate: self, cancelButtonTitle: NSLocalizedString("OK", comment: ""))
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

        if (!Networking.isInternetAvailable()) {
            let message = Message(title: NSLocalizedString("No Internet Connection", comment: ""), textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        }
        
        // Painter
        
        let painter:AYPainter = AYPainter()
        painter.setTheme(AYTheme.loadThemeFromFile("BlueTheme"))
        painter.paint(self.view)
        
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
        
        let date = sender.date
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        
        self.bDay = "\(year)-\(month)-\(day)"
    }


    
}