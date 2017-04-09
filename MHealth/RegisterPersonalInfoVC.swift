//
//  RegisterPersonalInfoVC.swift
//  MHealth
//
//  Created by trn14 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class RegisterPersonalInfoVC: UIViewController, UIPickerViewDelegate, NetworkCaller {


    
    @IBOutlet weak var fNameTF: UITextField!
    
    @IBOutlet weak var mNameTF: UITextField!
    @IBOutlet weak var PhoneNumberTF: UITextField!
    @IBOutlet weak var EmergencyNumberTF: UITextField!
    
    @IBOutlet weak var lNameTF: UITextField!
    @IBOutlet weak var CivilIDTF: UITextField!
    
    @IBOutlet weak var NationalityTF: UITextField!
    
    var year:Int = 0
    var month:Int = 0
    var day:Int = 0
    
    
  
    
    
    @IBOutlet weak var RegNextButtonOutlet: UIButton!
    
    @IBAction func reg2Button(sender: AnyObject) {
        
        
        
       // self.RegNextButtonOutlet.enabled=false
        if year == 0 || month == 0 || day == 0{
            
            let alert:UIAlertController = Alert().getAlert(NSLocalizedString("Error", comment: ""), msg: NSLocalizedString("Please insert birthday", comment: ""))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
            
          //  self.RegNextButtonOutlet.enabled = true
            
            return
            
            
            
        }
        
        
        
        var fname = fNameTF.text
        var mname = mNameTF.text
        var lname = lNameTF.text
        var nationality = NationalityTF.text
        var civilId = CivilIDTF.text
       // var Bday = day
        
        var phone = PhoneNumberTF.text
        var emergency = EmergencyNumberTF.text
      
       
        
        
        Reg1VC.current.newPatient.firstName=fname!
        Reg1VC.current.newPatient.middleName=mname!
        Reg1VC.current.newPatient.lastName=lname!
        Reg1VC.current.newPatient.civilId=civilId!
        Reg1VC.current.newPatient.nationality=nationality!
        Reg1VC.current.newPatient.phone=phone!
        Reg1VC.current.newPatient.emergencyNum=emergency!
   

       let networkManager:Networking = Networking()
        let values:[String:AnyObject] = ["firstName":fname!, "middleName":mname!, "lastName":lname!, "nationality":nationality!, "civilId":civilId!, "emergencyNumber":emergency!, "phoneNumber":phone!]
            
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        
        print(resp)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
    }
    
         func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        
        
//        if (pickerView.tag == 2)
//        {
//            picker2selection = DiabetesPickerOptions[row]
//        }
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
