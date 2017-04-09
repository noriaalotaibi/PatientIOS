//
//  EditeMidicalInfoVC.swift
//  MHealth
//
//  Created by Abrar Al-Failakawi on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class EditeMidicalInfoVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource , NetworkCaller{
    
    
    var picker1selection = ""
    var picker2selection = ""
    var picker3selection = ""
    
    var records:NSMutableArray = NSMutableArray()
    var index:Int = 0
    var patient:Patient?

    
    let BloodTypePD = ["A+" , "A-" , "B+" , "B-","O+" , "O-", "AB+" , "AB-"]
    
    
    let DiabetesPickerOptions = ["Type One" ,"Type Two" , "No" ]
    
    let asthmaPickerOptions = ["Yes" , "No"]
    
    @IBOutlet weak var AllergiesUpdatedTF: UITextField!

    @IBOutlet weak var MedicationsUpdatedTF: UITextField!
    
    @IBOutlet weak var BloodTypePicker: UIPickerView!
        ///
    @IBOutlet weak var diabetesPicker: UIPickerView!
    @IBOutlet weak var asthmaPicker: UIPickerView!
    
    @IBAction func SaveChangesButton(sender: AnyObject) {
            var bloodType = picker1selection
            var diabeties = picker2selection
            var asthma = picker3selection
        //change
       //     var allergies =AllergiesUpdatedTF.text
        
        
       var bd = patient!.bloodType = (bloodType)
        var dia = patient!.diabetes = Int(diabeties)!
       var asth = patient!.asthma = Int(asthma)!
        var alle = patient!.allergies = (AllergiesUpdatedTF?.text)!
        var med = patient!.medication = (MedicationsUpdatedTF.text)!
        
     let networkManager:Networking = Networking()
     let valuesDict = patient?.toDictionary()
        
        networkManager.AMJSONArray(Const.URLs.Patients, httpMethod: "PUT", jsonData: valuesDict!, reqId: 1, caller: self)
        //AMJSONDictionary(Const.URLs.Login, httpMethod: "POST", jsonData: values, reqId: 1, caller: self)

     //   AMJSONAr
//        
//        //records.replaceObjectAtIndex(records[row], withObject: <#T##AnyObject#>)
//        
//       records.replaceObjectAtIndex(index, withObject: (patient?.toDictionary())!)
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
        diabetesPicker.delegate = self
        diabetesPicker.dataSource = self
        asthmaPicker.dataSource = self
        asthmaPicker.delegate = self
        
        asthmaPicker.tag = 3
        diabetesPicker.tag = 2
        BloodTypePicker.tag = 1
        // Do any additional setup after loading the view.
        
        
        
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
