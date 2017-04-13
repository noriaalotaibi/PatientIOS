//
//  PatientReportViewController.swift
//  MHealth
//
//  Created by Shamlan Al-Roumi on 3/8/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class PatientReportViewController: UIViewController, NetworkCaller {
    
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        callerManager = DoctorFunctions.myInstance()
        callerManager?.callerReport = self
        
        
        bloodPressureSegment.selectedSegmentIndex = 1
        heartBeatSegment.selectedSegmentIndex = 1
        sugarLevelSegment.selectedSegmentIndex = 1
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendPatientReport(sender: AnyObject) {
        
        
        let patientDic:NSDictionary = NSUserDefaults.standardUserDefaults().valueForKey(Const.UserDefaultsKeys.loggedinUser) as! NSDictionary
        
        let patient:Patient = Patient()
        patient.loadDictionary(patientDic);
        
        
        let newReport:PatientReportDH = PatientReportDH()
        
        if self.bloodPressureSegment.selectedSegmentIndex == 0 {
            newReport.bloodPressure = "High"
        }else if self.bloodPressureSegment.selectedSegmentIndex == 1 {
            newReport.bloodPressure = "Moderate"
        }else{
            newReport.bloodPressure = "Low"
        }
        
        newReport.comments = self.patientComments.text
        
        if self.coughingSwitch.selected == true {
            newReport.coughing = "YES"
        }else{
            newReport.coughing = "NO"
        }
        
        
        if self.dizzinessSwitch.selected == true {
            newReport.dizziness = "YES"
        }else{
            newReport.dizziness = "NO"
        }
        
        
        newReport.drId = myDoctor.drId 
        newReport.drcomment = ""
        
        if self.feverSwitch.selected == true {
            newReport.fever = "YES"
        }else{
            newReport.fever = "NO"
        }
        
        if self.headacheSwitch.selected == true {
            newReport.headache = "YES"
        }else{
            newReport.headache = "NO"
        }
        
        if self.heartBeatSegment.selectedSegmentIndex == 0 {
            newReport.heartbeatRate = "High"
        }else if self.heartBeatSegment.selectedSegmentIndex == 1 {
            newReport.heartbeatRate = "Moderate"
        }else{
            newReport.heartbeatRate = "Low"
        }
        
        if self.nauseousSwitch.selected == true {
            newReport.nauseous = "YES"
        }else{
            newReport.nauseous = "NO"
        }
        
        
        if self.painLocation.text == "" {
            newReport.pain = false
            newReport.painlocation = ""
        }else{
            newReport.pain = true
            newReport.painlocation = self.painLocation.text!
        }
        
        if self.sugarLevelSegment.selectedSegmentIndex == 0 {
            newReport.sugarLevel = "High"
        }else if self.sugarLevelSegment.selectedSegmentIndex == 1 {
            newReport.sugarLevel = "Moderate"
        }else{
            newReport.sugarLevel = "Low"
        }
        
        
        
        newReport.patientId = patient.patientID
        
        let rDic:NSDictionary = newReport.toDictionary()
        
        let reportDic:NSMutableDictionary = rDic.mutableCopy() as! NSMutableDictionary
        reportDic.removeObjectForKey("name")
        reportDic.removeObjectForKey("timestamp")
        reportDic.removeObjectForKey("reportId")
        
        
        
        
    }

    func setArrayResponse(resp: NSArray, reqId: Int) {
        let alertControlle:UIAlertController = UIAlertController(title: "Success", message: "Patient report was sent sucessfully", preferredStyle: .Alert)
        
        let action:UIAlertAction =  UIAlertAction(title: "OK", style: .Cancel, handler: { (UIAlertAction) in
            self.navigationController?.popViewControllerAnimated(true)
        })
        alertControlle.addAction(action)
        self.presentViewController(alertControlle, animated: true, completion: nil)
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        
    }

}
