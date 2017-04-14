//
//  EditPersonalInfoVC.swift
//  MHealth
//
//  Created by Abrar Al-Failakawi on 3/7/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class EditPersonalInfoVC: UIViewController , NetworkCaller {
  var bDay=""
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
        
        
        let networkManager:Networking = Networking()
//        patient.firstName=fname!
//        patient.lastName=lname!
//        patient.civilId=civilId!
//        patient.email=email!
//        patient.dateOfBirth=bDay
//        patient.gender=gender
//        patient.phone=phoneNum!
//        patient.emergencyNum=emergencyNum!
//        patient.nationality=nationality!
//        patient.password=password!
        
         let valuesDict = patient.toDictionary()
        
        //newPatient.password=password!
      //  current.newPatient.gender=gender
        print("values for update")
        print(valuesDict)
        networkManager.AMJSONDictionary(Const.URLs.Patients + "/" + "\(patient.patientID)", httpMethod: "PUT", jsonData: valuesDict, reqId: 1, caller: self)
       
        
        var alert = UIAlertView(title: "Success", message: "Updated", delegate: self, cancelButtonTitle: "OK")
        alert.show()
        
    }
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        print(resp)
        
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        print("response: ")
        print(resp)
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
        // Do any additional setup after loading the view.
    
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
        //        Reg1VC.current.newPatient.birthDate = bDay;
        
        let date = sender.date
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        
        self.bDay = "\(year)-\(month)-\(day)"
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
