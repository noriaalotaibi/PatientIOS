//
//  PatientReportViewController.swift
//  MHealth
//
//  Created by Shamlan Al-Roumi on 3/8/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
import Whisper

class PatientReportViewController: UIViewController, NetworkCaller, UITextViewDelegate, UITextFieldDelegate {
    
    var myDoctor:DoctorDH = DoctorDH()
    
    var callerManager:DoctorFunctions? = nil

    @IBOutlet weak var bloodPressureSegment: UISegmentedControl!
    @IBOutlet weak var heartBeatSegment: UISegmentedControl!
    @IBOutlet weak var sugarLevelSegment: UISegmentedControl!
    
    
    @IBOutlet weak var patientComments: UITextView!
    
    @IBOutlet weak var painLocation: UITextField!
    
    
    @IBOutlet weak var feverSwitch: UISwitch!
    @IBOutlet weak var nauseousSwitch: UISwitch!
    @IBOutlet weak var headacheSwitch: UISwitch!
    @IBOutlet weak var dizzinessSwitch: UISwitch!
    
    
    @IBOutlet weak var coughingSwitch: UISwitch!

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    let networkManager:Networking = Networking()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        callerManager = DoctorFunctions.myInstance()
        callerManager?.callerReport = self
        
        
        bloodPressureSegment.selectedSegmentIndex = 1
        heartBeatSegment.selectedSegmentIndex = 1
        sugarLevelSegment.selectedSegmentIndex = 1
     
        scrollView.contentSize.height = self.view.frame.size.height + 50
        
        
        // Painter
        
//        let painter:AYPainter = AYPainter()
//        painter.setTheme(AYTheme.loadThemeFromFile("BlueTheme"))
//        painter.paint(self.view)
        
        // END Painter
        
        patientComments.delegate = self
        painLocation.delegate = self
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
        if (!Networking.isInternetAvailable()) {
            let message = Message(title: NSLocalizedString("No Internet Connection", comment: ""), textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendPatientReport(sender: AnyObject) {
        
        
        if patientComments.text == "" {
            let alertControlle:UIAlertController = UIAlertController(title:NSLocalizedString("Error", comment: "") , message:NSLocalizedString("Comment can't be empty", comment: "") , preferredStyle: .Alert)
            
            let action:UIAlertAction =  UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Cancel, handler: { (UIAlertAction) in
            })
            alertControlle.addAction(action)
            self.presentViewController(alertControlle, animated: true, completion: nil)
            return;
        }
        
        let patientDic:NSDictionary = NSUserDefaults.standardUserDefaults().valueForKey(Const.UserDefaultsKeys.loggedinUser) as! NSDictionary
        
        let patient:Patient = Patient()
        patient.loadDictionary(patientDic);
        
        
        let newReport:PatientReportDH = PatientReportDH()
        
        if self.bloodPressureSegment.selectedSegmentIndex == 0 {
            newReport.bloodPressure = NSLocalizedString("High", comment: "")
        }else if self.bloodPressureSegment.selectedSegmentIndex == 1 {
            newReport.bloodPressure = NSLocalizedString("Moderate", comment: "")
        }else{
            newReport.bloodPressure =  NSLocalizedString("Low", comment: "")
        }
        
        newReport.comments = self.patientComments.text
        
        if self.coughingSwitch.selected == true {
            newReport.coughing = NSLocalizedString("YES", comment: "")
        }else{
            newReport.coughing = NSLocalizedString("NO", comment: "")
        }
        
        
        if self.dizzinessSwitch.selected == true {
            newReport.dizziness = NSLocalizedString("YES", comment: "")
        }else{
            newReport.dizziness = NSLocalizedString("NO", comment: "")
        }
        
        
        newReport.drId = myDoctor.drId 
        newReport.drcomment = ""
        
        if self.feverSwitch.selected == true {
            newReport.fever = NSLocalizedString("YES", comment: "")
        }else{
            newReport.fever = NSLocalizedString("NO", comment: "")
        }
        
        if self.headacheSwitch.selected == true {
            newReport.headache = NSLocalizedString("YES", comment: "")
        }else{
            newReport.headache = NSLocalizedString("NO", comment: "")
        }
        
        if self.heartBeatSegment.selectedSegmentIndex == 0 {
            newReport.heartbeatRate =  NSLocalizedString("High", comment: "")
        }else if self.heartBeatSegment.selectedSegmentIndex == 1 {
            newReport.heartbeatRate = NSLocalizedString("Moderate", comment: "")
        }else{
            newReport.heartbeatRate = NSLocalizedString("Low", comment: "")
        }
        
        if self.nauseousSwitch.selected == true {
            newReport.nauseous = NSLocalizedString("YES", comment: "")
        }else{
            newReport.nauseous = NSLocalizedString("NO", comment: "")
        }
        
        
        if self.painLocation.text == "" {
            newReport.pain = false
            newReport.painlocation = ""
        }else{
            newReport.pain = true
            newReport.painlocation = self.painLocation.text!
        }
        
        if self.sugarLevelSegment.selectedSegmentIndex == 0 {
            newReport.sugarLevel = NSLocalizedString("High", comment: "")
        }else if self.sugarLevelSegment.selectedSegmentIndex == 1 {
            newReport.sugarLevel = NSLocalizedString("Moderate", comment: "")
        }else{
            newReport.sugarLevel = NSLocalizedString("Low", comment: "")
        }
        
        
        
        newReport.patientId = patient.patientID
        
        let rDic:NSDictionary = newReport.toDictionary()
        
        let reportDic:NSMutableDictionary = rDic.mutableCopy() as! NSMutableDictionary
        reportDic.removeObjectForKey("name")
        reportDic.removeObjectForKey("timestamp")
        reportDic.removeObjectForKey("reportId")
        
        print("request body:")
        print(reportDic)
        
        if (Networking.isInternetAvailable()) {
            networkManager.AMJSONDictionary(Const.URLs.PatientReport, httpMethod: "POST", jsonData: reportDic, reqId: 0, caller: self)
        } else {
            let message = Message(title:NSLocalizedString("No Internet Connection", comment: "") , textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        }
        
    }

    func setArrayResponse(resp: NSArray, reqId: Int) {
        
        
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        
        print("response send report")
        print(resp)
        if resp.count == 0 {
            let alertControlle:UIAlertController = UIAlertController(title: NSLocalizedString("Success", comment: ""), message: NSLocalizedString("Patient report was sent sucessfully", comment: ""), preferredStyle: .Alert)
            
            let action:UIAlertAction =  UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Cancel, handler: { (UIAlertAction) in
                self.navigationController?.popViewControllerAnimated(true)
            })
            alertControlle.addAction(action)
            self.presentViewController(alertControlle, animated: true, completion: nil)
            
            
        }else{
            let alertControlle:UIAlertController = UIAlertController(title: NSLocalizedString("Failed", comment: ""), message: NSLocalizedString("Patient report failed to sent", comment: ""), preferredStyle: .Alert)
            
            let action:UIAlertAction =  UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Cancel, handler: { (UIAlertAction) in
            })
            alertControlle.addAction(action)
            self.presentViewController(alertControlle, animated: true, completion: nil)
        }
    }

}
