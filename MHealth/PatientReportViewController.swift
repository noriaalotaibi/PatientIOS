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
