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
    var diabetes:Int = 0
    var asthma = 0
    
    @IBAction func DiabetesSegment(sender: AnyObject) {
        
        if sender.selectedSegmentIndex == 0 {
            
            self.diabetes = 0
            
        }else if sender.selectedSegmentIndex == 1{
            
            self.diabetes = 1
        }else if sender.selectedSegmentIndex == 2{
            self.diabetes = 2
        }
    }
    
    
   
    
    var records:NSMutableArray = NSMutableArray()
    var index:Int = 0
    var patient=Patient()

    
    let BloodTypePD = ["A+" , "A-" , "B+" , "B-","O+" , "O-", "AB+" , "AB-"]
    
    
    @IBOutlet weak var AllergiesUpdatedTF: UITextField!

    @IBOutlet weak var MedicationsUpdatedTF: UITextField!
    
    @IBOutlet weak var BloodTypePicker: UIPickerView!
        ///
    @IBAction func asthmaSegment(sender: AnyObject) {
        if sender.selectedSegmentIndex == 0 {
            
            self.asthma = 0
            
        }else if sender.selectedSegmentIndex == 1{
            
            self.asthma = 1
        }
    
    }
    @IBOutlet weak var diabetesPicker: UIPickerView!
    @IBOutlet weak var asthmaPicker: UIPickerView!
    
    @IBAction func SaveChangesButton(sender: AnyObject) {
            var bloodType = picker1selection
           
        //change
       //     var allergies =AllergiesUpdatedTF.text
        
        
        var medication = MedicationsUpdatedTF.text
        var allergies = AllergiesUpdatedTF.text
        var asthmaValue = asthma
       
        
        
        
     let networkManager:Networking = Networking()
     let valuesDict = patient.toDictionary()
        
        networkManager.AMJSONArray(Const.URLs.Patients, httpMethod: "PUT", jsonData: valuesDict, reqId: 1, caller: self)
        
    
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
        
        let net:Networking = Networking()
        
        
        let Patient:NSDictionary = NSUserDefaults.standardUserDefaults().valueForKey(Const.UserDefaultsKeys.loggedinUser) as! NSDictionary
        
        print("patient json")
        print(Patient)
        patient.loadDictionary(Patient);
        
        
        print("patient object")
        print(patient)
        
        
        MedicationsUpdatedTF?.text  = patient.medication
        AllergiesUpdatedTF.text = patient.allergies
        asthma = patient.asthma
        picker1selection = patient.bloodType
        diabetes = patient.diabetes
        
        
       
        // Do any additional setup after loading the view.
        
        
        
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
        
        if(pickerView.tag == 1){
            
            picker1selection =  BloodTypePD[row]
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
