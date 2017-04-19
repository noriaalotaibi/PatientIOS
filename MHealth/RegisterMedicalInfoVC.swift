//
//  RegisterMedicalInfoVC.swift
//  MHealth
//
//  Created by trn14 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
import Whisper
import SwiftSpinner
class RegisterMedicalInfoVC: UIViewController , NetworkCaller, UITextFieldDelegate {

    
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
    
    
    
    
    
    @IBOutlet weak var DiabetesPicker: UIPickerView!
    
    let DiabetesPickerOptions = ["Type One" ,"Type Two" , "No" ]
    
    let asthmaPickerOptions = ["Yes" , "No"]
    
    
    @IBOutlet weak var allergiesTF: UITextField!
    
    
    @IBOutlet weak var medicationTF: UITextField!
    
    
    @IBOutlet var BloodButtons: [UIButton]!
    
    
    @IBAction func SelectedBloodType(sender: UIButton) {
        
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
    
        for button in BloodButtons {
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
    @IBAction func Reg3Button(sender: AnyObject) {
        
     
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
        
        if (Networking.isInternetAvailable()) {
            SwiftSpinner.show("Connecting...")
            SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 22.0))
            networkManager.AMJSONDictionary(Const.URLs.Patients, httpMethod: "POST", jsonData: values, reqId: 1, caller: self)

            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            var noNetwork = Langs.arabicTitleForString("No Internet Connection")
            let message = Message(title: noNetwork, textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        }
        
        

    }
    
    
    
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        print("resp:")
       print(resp)
        SwiftSpinner.hide()
        let registerationStatus:Int = resp.valueForKey("errorCode") as! Int
        print(registerationStatus)
        
        var title = Langs.arabicTitleForString("Register")
        var msg1 = Langs.arabicTitleForString("Done")
        
        var title2 = Langs.arabicTitleForString("Error")
        var msg2 = Langs.arabicTitleForString("no complete")
        var cancelButton = Langs.arabicTitleForString("OK")
        
        if registerationStatus == 200 {
            
            print(registerationStatus)
            
           // NSUserDefaults.standardUserDefaults().setValue(valuesDict, forKey: Const.UserDefaultsKeys.loggedinUser)
        
            var alert = UIAlertView(title: title, message: msg1, delegate: self, cancelButtonTitle: cancelButton)
            alert.show()
        }
        else {
            
            var alert = UIAlertView(title: title2, message: msg2, delegate: self, cancelButtonTitle:cancelButton)
            alert.show()
            //NSLocalizedString("Updated" , comment: "")
        }

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allergiesTF.delegate = self
        medicationTF.delegate = self
        
        setSelectedBloodTypeButton(1)

        
        // Painter
        
//        let painter:AYPainter = AYPainter()
//        painter.setTheme(AYTheme.loadThemeFromFile("BlueTheme"))
//        painter.paint(self.view)
        
        // END Painter
        
     }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        var noConnection =  Langs.arabicTitleForString("No Internet Connection")
        if (!Networking.isInternetAvailable()) {
            let message = Message(title: noConnection, textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
