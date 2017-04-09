//
//  ViewMedicalInfoVC.swift
//  MHealth
//
//  Created by Abrar Al-Failakawi on 3/7/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class ViewMedicalInfoVC: UIViewController , NetworkCaller {
    @IBOutlet weak var BloodTypeLabel: UILabel!
    @IBOutlet weak var DiabetesLabel: UILabel!
    @IBOutlet weak var AsthmaLabel: UILabel!
    @IBOutlet weak var AllergiesLabel: UILabel!
    @IBOutlet weak var MedicationLabel: UILabel!

    var patient:Patient?
    
    func loadData() {
        BloodTypeLabel?.text         = patient?.bloodType
        DiabetesLabel?.text       =  "\(patient?.diabetes)"
        AsthmaLabel?.text    =  "\(patient?.asthma)"
        AllergiesLabel?.text      = patient?.allergies
        MedicationLabel?.text = patient?.medication
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let net:Networking = Networking()
        net.AMGetArrayData(Const.URLs.Patients, params: [:], reqId: 1, caller: self)
        
        loadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setArrayResponse(resp: NSArray, reqId: Int) {
        print(resp)
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        
        
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
