//
//  PatientReportViewController.swift
//  MHealth
//
//  Created by Shamlan Al-Roumi on 3/8/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class PatientReportViewController: UIViewController, NetworkCaller {
    
    var callerManager:DoctorFunctions? = nil

    @IBOutlet weak var bloodPressureSegment: UISegmentedControl!
    @IBOutlet weak var heartBeatSegment: UISegmentedControl!
    @IBOutlet weak var sugarLevelSegment: UISegmentedControl!
    
    @IBAction func bloodPressureChange(sender: UISegmentedControl) {
    }
    
    @IBAction func heartBeatRateChange(sender: UISegmentedControl) {
    }
    
    
    @IBAction func sugarLevelChange(sender: UISegmentedControl) {
    }
    
    
    @IBOutlet weak var patientComments: UITextView!
    
    @IBOutlet weak var painLocation: UITextField!
    
    @IBAction func feverChange(sender: UISwitch) {
    }
    
    @IBAction func nauseousChange(sender: UISwitch) {
    }
    
    @IBAction func headacheChange(sender: UISwitch) {
    }
    
    @IBAction func dizzinessChange(sender: UISwitch) {
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        callerManager = DoctorFunctions.myInstance()
        callerManager?.callerReport = self
        
        
        
        
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
        
        newReport.bloodPressure = ""//High low natural
        newReport.comments = ""
        newReport.coughing = "" //YES NO
        newReport.dizziness = ""
        newReport.drId = 0 //
        newReport.drcomment = ""
        newReport.fever = ""//YES NO
        newReport.headache = "" //YES NO
        newReport.heartbeatRate = ""//High low moderate
        newReport.nauseous = ""//NO YES
//        if painLocation.text == "" {
//            newReport.pain = false
//            newReport.painlocation = ""
//        }else{
//            newReport.pain = true
//            newReport.painlocation = ""
//        }
        newReport.sugarLevel = "" //High Low Medium
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
