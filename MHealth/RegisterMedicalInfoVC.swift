//
//  RegisterMedicalInfoVC.swift
//  MHealth
//
//  Created by trn14 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class RegisterMedicalInfoVC: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource, NetworkCaller {

    
    var picker1selection = ""
   var diabetes = 0
var asthma = 0
    
    
    @IBOutlet weak var DiabetesSegment: UISegmentedControl!
    
    
    @IBAction func DiabetesSelection(sender: AnyObject) {
        
        if sender.selectedSegmentIndex == 0 {
            
            self.diabetes = 0
            
        }else if sender.selectedSegmentIndex == 1{
            
            self.diabetes = 1
        }else if sender.selectedSegmentIndex == 2{
            self.diabetes = 2
        }
    }
    
    
    @IBOutlet weak var AsthmaSegment: UISegmentedControl!
    
    @IBAction func AsthmaSegment(sender: AnyObject) {
        if sender.selectedSegmentIndex == 0 {
            
            self.asthma = 0
            
        }else if sender.selectedSegmentIndex == 1{
            
            self.asthma = 1
        }
    }
      @IBOutlet weak var BloodTypePicker: UIPickerView!
        var btPickerSelected:Int = 0
     let BloodTypePD = ["A+" , "A-" , "B+" , "B-","O+" , "O-", "AB+" , "AB-"]
    
    
    
    
    @IBOutlet weak var DiabetesPicker: UIPickerView!
    
    let DiabetesPickerOptions = ["Type One" ,"Type Two" , "No" ]
    
    let asthmaPickerOptions = ["Yes" , "No"]
    
    
    @IBOutlet weak var allergiesTF: UITextField!
    
    
    @IBOutlet weak var medicationTF: UITextField!
    
    
    @IBAction func Reg3Button(sender: AnyObject) {
        
        var btSelectedValue = BloodTypePD
        var bloodType=picker1selection
        
        var diabetesValue = diabetes
        var allergies=allergiesTF.text
        var medication=medicationTF.text
      
        
        
        Reg1VC.current.newPatient.bloodType=bloodType
     //   Reg1VC.current.newPatient.diabetes = (diabetes)
        Reg1VC.current.newPatient.asthma = (asthma)
        Reg1VC.current.newPatient.diabetes = diabetesValue
        Reg1VC.current.newPatient.allergies=allergies!
        Reg1VC.current.newPatient.medication=medication!
        
        
        
        
        let networkManager:Networking = Networking()
        let values = Reg1VC.current.newPatient.toDictionary()
        print(values)
       networkManager.AMJSONDictionary(Const.URLs.Patients, httpMethod: "POST", jsonData: values, reqId: 1, caller: self)
        
    }
    
    
    
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        
        print(resp)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            BloodTypePicker.delegate = self
            BloodTypePicker.dataSource = self
        
     }
    
        func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
            return 1
        }
        func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          
               return BloodTypePD.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        return BloodTypePD[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    
           
            picker1selection =  BloodTypePD[row]
            
        }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
