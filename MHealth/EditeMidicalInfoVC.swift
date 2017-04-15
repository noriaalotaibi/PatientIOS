//
//  EditeMidicalInfoVC.swift
//  MHealth
//
//  Created by Abrar Al-Failakawi on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class EditeMidicalInfoVC: UIViewController, NetworkCaller{
    
    
    var picker1selection = ""
    var diabetes:Bool = false
    var asthma:Bool = false
    
    @IBOutlet var BloodtypeSelection: [UIButton]!
    
    @IBAction func BloodTypeButton(sender: UIButton) {
        
        
        if sender.tag==1{
            picker1selection="A+"
        }
            
        else if sender.tag==2{
            picker1selection="A-"
        }
            
        else if sender.tag==3{
            picker1selection="B+"
        }
            
        else if sender.tag==4{
            picker1selection="B-"
        }
            
        else if sender.tag==5{
            picker1selection="O+"
        }
            
        else if sender.tag==6{
            picker1selection="O-"
        }
            
        else if sender.tag==7{
            picker1selection="AB+"
        }
            
        else {
            picker1selection="AB-"
        }
        
        setSelectedBloodTypeButton(sender.tag)
        
    }
    
    func setSelectedBloodTypeButton(tag:Int){
        
        for button in BloodtypeSelection {
            if button.tag == tag {
                
                button.layer.borderColor = UIColor.redColor().colorWithAlphaComponent(1.0).CGColor
                button.layer.borderWidth = 1.0
                //The rounded corner part, where you specify your view's corner radius:
                button.layer.cornerRadius = 5;
                button.clipsToBounds = true;
                button.alpha = 1.0
                
            }else{
                
                button.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.5).CGColor
                button.layer.borderWidth = 1.0
                //The rounded corner part, where you specify your view's corner radius:
                button.layer.cornerRadius = 5;
                button.clipsToBounds = true;
                button.alpha = 0.5
            }
        }
    }
    @IBAction func DiabetesSegment(sender: AnyObject) {
        
        if sender.selectedSegmentIndex == 0 {
            
            self.diabetes = false
            
        }else if sender.selectedSegmentIndex == 1{
            
            self.diabetes = true
        }
    }
    
    
   
    
    var records:NSMutableArray = NSMutableArray()
    var index:Int = 0
    var patient=Patient()

    
    
    
    
    @IBOutlet weak var AllergiesUpdatedTF: UITextField!

    @IBOutlet weak var MedicationsUpdatedTF: UITextField!
    
    @IBOutlet weak var BloodTypePicker: UIPickerView!
        ///
    @IBAction func asthmaSegment(sender: AnyObject) {
        if sender.selectedSegmentIndex == 0 {
            
            self.asthma = false
            
        }else if sender.selectedSegmentIndex == 1{
            
            self.asthma = true
        }
    
    }
    @IBOutlet weak var diabetesPicker: UIPickerView!
    @IBOutlet weak var asthmaPicker: UIPickerView!
    
    @IBAction func SaveChangesButton(sender: AnyObject) {
        
        var bloodType = picker1selection
        var diabetesValue = diabetes
        var medication = MedicationsUpdatedTF.text
        var allergies = AllergiesUpdatedTF.text
        var asthmaValue = asthma
       
        
        let modifiedPatient:Patient = Patient()
            modifiedPatient.loadDictionary(patient.toDictionary())
        
        modifiedPatient.bloodType = bloodType
        modifiedPatient.diabetes=diabetesValue
        modifiedPatient.asthma=asthmaValue
        modifiedPatient.allergies=allergies!
        modifiedPatient.medication=medication!
        
        
     let networkManager:Networking = Networking()
     let valuesDict = modifiedPatient.toDictionary()
        
        networkManager.AMJSONDictionary(Const.URLs.Patients + "/" + "\(patient.patientID)", httpMethod: "PUT", jsonData: valuesDict, reqId: 1, caller: self)
        
        
        var alert = UIAlertView(title: "Success", message: "Updated", delegate: self, cancelButtonTitle: "OK")
        alert.show()
    
    }
    func setArrayResponse(resp: NSArray, reqId: Int) {
        
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        
        print(resp)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setSelectedBloodTypeButton(1)
        
       
        
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
        
        // Painter
        
//        let painter:AYPainter = AYPainter()
//        painter.setTheme(AYTheme.loadThemeFromFile("BlueTheme"))
//        painter.paint(self.view)
        
        // END Painter
        
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
