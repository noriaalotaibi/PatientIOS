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
    var picker2selection = ""
    var picker3selection = ""
    
      @IBOutlet weak var BloodTypePicker: UIPickerView!
    
     let BloodTypePD = ["A+" , "A-" , "B+" , "B-","O+" , "O-", "AB+" , "AB-"]
    
    @IBOutlet weak var DiabetesPicker: UIPickerView!
    
    let DiabetesPickerOptions = ["Type One" ,"Type Two" , "No" ]
    
    
    @IBOutlet weak var allergiesTF: UITextField!
    
    
    @IBOutlet weak var medicationTF: UITextField!
    
    
    @IBAction func Reg3Button(sender: AnyObject) {
        
        var bloodType=picker1selection
        var diabetes=picker2selection
        var asthma=picker3selection
        
        var allergies=allergiesTF.text
        var medication=medicationTF.text
        
        
        Reg1VC.current.newPatient.bloodType=bloodType
        Reg1VC.current.newPatient.diabetes = Int(diabetes)!
        Reg1VC.current.newPatient.asthma = Int(asthma)!
        Reg1VC.current.newPatient.allergies=allergies!
        Reg1VC.current.newPatient.medication=medication!
        
        
        
        let networkManager:Networking = Networking()
        let values = Reg1VC.current.newPatient.toDictionary()
        print(values)
       networkManager.AMJSONDictionary(Const.URLs.Patients, httpMethod: "POST", jsonData: values, reqId: 1, caller: self)
        
    }
    
    @IBOutlet weak var AsthmaPicker: UIPickerView!
    
    let asthmaPickerOptions = ["Yes" , "No"]
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        
        print(resp)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            BloodTypePicker.delegate = self
            BloodTypePicker.dataSource = self
            DiabetesPicker.delegate = self
            DiabetesPicker.dataSource = self
            AsthmaPicker.delegate = self
            AsthmaPicker.dataSource = self
        
            AsthmaPicker.tag = 3
            DiabetesPicker.tag = 2
            BloodTypePicker.tag = 1
    
    }
    
        func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
            return 1
        }
        func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if(pickerView.tag == 1){
               return BloodTypePD.count
            }
           else if (pickerView.tag == 2)
                {
                    return DiabetesPickerOptions.count
                }
            else if (pickerView.tag == 3){
                  return asthmaPickerOptions.count
            }
            return 1
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        
        if(pickerView.tag == 1){
            return BloodTypePD[row]
            
            
        }
        if (pickerView.tag == 2)
        {
            return DiabetesPickerOptions[row]
        }
        if (pickerView.tag == 3){
             return asthmaPickerOptions[row]
        }
        
        return ""
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerView.tag == 1){
            
            picker1selection =  BloodTypePD[row]
        }
        if (pickerView.tag == 2)
        {
            picker2selection = DiabetesPickerOptions[row]
        }
        if (pickerView.tag == 3){
            picker3selection = asthmaPickerOptions[row]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
