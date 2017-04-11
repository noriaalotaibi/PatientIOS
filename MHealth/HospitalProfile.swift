//
//  HospitalProfile.swift
//  MHealth
//
//  Created by Abrar Al-Failakawi on 4/10/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class HospitalProfile: UIViewController, NetworkCaller {

    @IBOutlet weak var HospitalAdditionalInfo: UILabel!
    @IBOutlet weak var HospitalEmail: UILabel!
    @IBOutlet weak var HospitalAddress: UILabel!
    @IBOutlet weak var HospitalPhoneNum: UILabel!
    @IBOutlet weak var HospitalWorkingHours: UILabel!
    @IBOutlet weak var HospitalSpeciality: UILabel!
    @IBOutlet weak var HospitalImage: UIImageView!
    @IBOutlet weak var HospitalName: UILabel!
    @IBOutlet weak var HospitalType: UILabel!
    
     var hospital:HospitalDH = HospitalDH()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testHospital()
        
        
        let net:Networking = Networking()
        net.AMGetArrayData(Const.URLs.Hospital, params: [:], reqId: 1, caller: self)
        
       let Hospital:NSDictionary = NSUserDefaults.standardUserDefaults().valueForKey(Const.UserDefaultsKeys.hospitalProfile) as! NSDictionary
        
        hospital.loadDictionary(Hospital)
        
        HospitalName.text=hospital.hospitalName
        HospitalEmail.text=hospital.hospitalEmail
        HospitalType.text=hospital.hospitalType
        HospitalPhoneNum.text=hospital.hospitalPhone
       // HospitalImage=hospital.hospitalLogoURL
        HospitalWorkingHours.text=hospital.hospitalWorkingHours
        HospitalAddress.text=hospital.hospitalAddress
        HospitalAdditionalInfo.text=hospital.hospitalExtrainfo
        

        
        // Do any additional setup after loading the view.
    }
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        // print(resp)
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
       
        //
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testHospital(){
        
        var hospital:NSDictionary = NSDictionary()
        var name:String = ""
        
        
        NSUserDefaults.standardUserDefaults().setValue(hospital, forKey: Const.UserDefaultsKeys.hospitalId)
    
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
