//
//  EditPersonalInfoVC.swift
//  MHealth
//
//  Created by Abrar Al-Failakawi on 3/7/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class EditPersonalInfoVC: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , NetworkCaller {
   var picker1selection = ""
    @IBOutlet weak var GenderPicker: UIPickerView!
  
    @IBOutlet weak var FnameLB: UITextField!
    @IBOutlet weak var MnameLB: UITextField!
    @IBOutlet weak var LnameLB: UITextField!
    @IBOutlet weak var CivilIDLB: UITextField!
 
    @IBOutlet weak var EmailLB: UITextField!
    @IBOutlet weak var PasswordLB: UITextField!
    @IBOutlet weak var PhoneLB: UITextField!
    @IBOutlet weak var EmergencyLB: UITextField!
    @IBOutlet weak var NationalityLB: UITextField!
    @IBOutlet weak var BirthDateLB: UIDatePicker!
     weak var BirthDate: UIDatePicker!
   
    let genderPickerOptions = ["Female" , "Male"]
  
    
    var patient:Patient?
    
    var records:NSMutableArray = NSMutableArray()
    
    @IBAction func UpdateButton(sender: AnyObject) {
        
        let networkManager:Networking = Networking()
        let valuesDict = patient?.toDictionary()
        
        networkManager.AMJSONArray(Const.URLs.Patients, httpMethod: "PUT", jsonData: valuesDict!, reqId: 1, caller: self)
       
        FnameLB?.text         = patient?.firstName
        
        print(patient?.firstName)
        CivilIDLB?.text       = patient?.civilId
        MnameLB?.text     = patient?.middleName
        LnameLB?.text    = patient?.lastName
    
        
        
        //   picker1selection.text      = patient.lastName
        
        EmailLB?.text     = patient?.email
            
        PasswordLB?.text     = patient?.password
        PhoneLB?.text        = patient?.phone
        EmergencyLB?.text      = patient?.emergencyNum
        NationalityLB?.text   = patient?.nationality
        //birthdate
         var gender = picker1selection
        
        

    }
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        
        print(resp)
    }
    
  
   override func viewDidLoad() {
        super.viewDidLoad()

        GenderPicker.dataSource = self
        GenderPicker.delegate = self
  

        // Do any additional setup after loading the view.
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return genderPickerOptions.count
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderPickerOptions[row]
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if(pickerView.tag == 1){
            
            picker1selection =  genderPickerOptions[row]
        }
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
