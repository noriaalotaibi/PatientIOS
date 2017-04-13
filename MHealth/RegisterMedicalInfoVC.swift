//
//  RegisterMedicalInfoVC.swift
//  MHealth
//
//  Created by trn14 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class RegisterMedicalInfoVC: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource, NetworkCaller {

    
    var picker1selection = "A+"
    var diabetes:Bool = false
    var asthma:Bool = false
    
    let networkManager:Networking = Networking()

    
    @IBOutlet weak var DiabetesSegment: UISegmentedControl!
    
    
    @IBAction func DiabetesSelection(sender: AnyObject) {
        
        if sender.selectedSegmentIndex == 0 {
            
            self.diabetes = false
            
        }else if sender.selectedSegmentIndex == 1{
            
            self.diabetes = true
        }
    }
    
    
    @IBOutlet weak var AsthmaSegment: UISegmentedControl!
    
    @IBAction func AsthmaSegment(sender: AnyObject) {
        if sender.selectedSegmentIndex == 0 {
            
            self.asthma = false
            
        }else if sender.selectedSegmentIndex == 1{
            
            self.asthma = true
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
        var asthmaValue=asthma
        var diabetesValue = diabetes
        var allergies=allergiesTF.text
        var medication=medicationTF.text
      
        
        
        Reg1VC.current.newPatient.bloodType=bloodType
     //   Reg1VC.current.newPatient.diabetes = (diabetes)
        Reg1VC.current.newPatient.asthma = asthmaValue
     
        Reg1VC.current.newPatient.diabetes=diabetesValue
        Reg1VC.current.newPatient.allergies=allergies!
        Reg1VC.current.newPatient.medication=medication!
        
        
        Reg1VC.current.newPatient.imageUrl=""
        Reg1VC.current.newPatient.middleName=""


        
        
        let dic:NSDictionary = Reg1VC.current.newPatient.toDictionary()
        let values:NSMutableDictionary = dic.mutableCopy() as! NSMutableDictionary
        values.removeObjectForKey("patientId")
        
        print("values")
        print(values)
        networkManager.AMJSONDictionary(Const.URLs.Patients, httpMethod: "POST", jsonData: values, reqId: 1, caller: self)
        

    }
    
    
    
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        print("resp:")
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
