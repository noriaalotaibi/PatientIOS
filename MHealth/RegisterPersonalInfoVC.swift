//
//  RegisterPersonalInfoVC.swift
//  MHealth
//
//  Created by trn14 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class RegisterPersonalInfoVC: UIViewController, UIPickerViewDelegate, NetworkCaller {

    
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
        
        bDay = dateTextField.text!
        
        var fname = fNameTF.text
         var lname = lNameTF.text
        var nationality = NationalityTF.text
        var civilId = CivilIDTF.text
        var phone = PhoneNumberTF.text
        var emergency = EmergencyNumberTF.text
        
        
        Reg1VC.current.newPatient.firstName=fname!
        Reg1VC.current.newPatient.lastName=lname!
        Reg1VC.current.newPatient.dateOfBirth=bDay
        Reg1VC.current.newPatient.civilId=civilId!
        Reg1VC.current.newPatient.nationality=nationality!
        Reg1VC.current.newPatient.phone=phone!
        Reg1VC.current.newPatient.emergencyNum=emergency!
        
        
       
        
        let networkManager:Networking = Networking()
        let values = Reg1VC.current.newPatient.toDictionary()
       
   // var values:[String:AnyObject] = ["firstName":fname!, "birthDate":Bday!, "lastName":lname!, "nationality":nationality!, "civilId":civilId!, "emergencyNumber":emergency!, "phoneNumber":phone!]
     
        
        
        
        }
        
        
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        print()
        
        print(resp)
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
