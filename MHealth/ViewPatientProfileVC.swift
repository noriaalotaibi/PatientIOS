//
//  ViewPatientProfileVC.swift
//  MHealth
//
//  Created by trn14 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class ViewPatientProfileVC: UIViewController, NetworkCaller {
    @IBOutlet weak var LnameLabel: UILabel!
    @IBOutlet weak var FnameLabel: UILabel!
    @IBOutlet weak var MnameLabel: UILabel!
    @IBOutlet weak var NationalityLabel: UILabel!
    @IBOutlet weak var CivilIdLabel: UILabel!
    @IBOutlet weak var GenderLabel: UILabel!
    @IBOutlet weak var BirthDateLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PhoneNumLabel: UILabel!
    @IBOutlet weak var EmergencyNumLabel: UILabel!
    var patient=Patient()
    
    var newPatient:Patient = Patient()

    
    @IBAction func logoutButton(sender: UIButton) {
        
        
    }
    @IBAction func editPatientPhoto(sender: UIButton) {
        
        
    }
   
    @IBAction func UpdateProfile(sender: AnyObject) {
        
        
         
        
    }
    
    @IBAction func ViewMedicalInfoButton(sender: AnyObject) {
         print("user clicked More")
        
        //        let nextScreen:ViewMedicalInfoVC = self.storyboard?.instantiateViewControllerWithIdentifier("viewMedicalInfo") as! ViewMedicalInfoVC
        //
        //        self.presentViewController(nextScreen, animated: true, completion: {})
        
        //   let nav:UINavigationController = self.navigationController!
        
        //  nav.pushViewController(nextScreen, animated: true)
 
    }
    
//    var records:NSMutableArray = NSMutableArray()
//    var index:Int = 0

//    func loadData() {
////        
////        print( patient?.toDictionary())
////       
////        
////       // print(patient?.firstName)
////        CivilIdLabel?.text       = patient?.civilId
////        MnameLabel?.text    = patient?.middleName
////        LnameLabel?.text      = patient?.lastName
////        NationalityLabel?.text = patient?.nationality
////        GenderLabel?.text = patient?.gender
////        BirthDateLabel?.text = patient?.birthDate
////        EmailLabel?.text = patient?.email
////        PhoneNumLabel?.text = patient?.phone
////        EmergencyNumLabel?.text = patient?.emergencyNum
//        
//        
//    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
      //  patient.convFromDictionary(records.objectAtIndex(index) as! NSDictionary)
        
        let net:Networking = Networking()
        net.AMGetArrayData(Const.URLs.Patients, params: [:], reqId: 1, caller: self)
        
        let Patient:NSDictionary = NSUserDefaults.standardUserDefaults().valueForKey(Const.UserDefaultsKeys.loggedinUser) as! NSDictionary
        
     //   patient!.loadDictionary(Patient)
        
        patient.loadDictionary(Patient);
        
        FnameLabel?.text  = patient.firstName
        CivilIdLabel?.text = patient.civilId
        LnameLabel?.text      = patient.lastName
        NationalityLabel?.text = patient.nationality
        if patient.gender.characters.first == "f" || patient.gender.characters.first == "F" {
            GenderLabel?.text = "Female"
        }else{
            GenderLabel?.text = "Male"
        }
        
        BirthDateLabel?.text = patient.dateOfBirth
        EmailLabel?.text = patient.email
        PhoneNumLabel?.text = patient.phone
        EmergencyNumLabel?.text = patient.emergencyNum
        
        
        
       // loadData()
        
        // Do any additional setup after loading the view.
    }
    
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
       // print(resp)
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
//        records = NSMutableArray()
//        records.addObjectsFromArray(resp as! [AnyObject])
//        FnameLabel?.text = records.valueForKey("firstName") as! String
//        
        
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
