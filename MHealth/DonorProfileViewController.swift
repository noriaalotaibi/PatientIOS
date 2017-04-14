//
//  DonorProfileViewController.swift
//  MHealth
//
//  Created by trn15 on 3/7/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class DonorProfileViewController: UIViewController {

    var Donor:DonorDH = DonorDH()
    
  
    @IBOutlet var DonorName: UILabel!
    
    @IBOutlet var BloodType: UILabel!
    
    @IBOutlet var Email: UILabel!
    
    @IBOutlet var CivilId: UILabel!
    
    @IBOutlet var Gender: UILabel!
    
    @IBOutlet var Nationality: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DonorName.text = Donor.firstName
        BloodType.text = Donor.bloodType
        Email.text = Donor.email
        CivilId.text = Donor.civilId
        if Donor.gender == "M"
        {
        Gender.text = NSLocalizedString("Male", comment: "")
        } else if Donor.gender == "F" {
            Gender.text = NSLocalizedString("Female", comment: "")
        } else {
            Gender.text = NSLocalizedString("Wrong", comment: "")
        }
        
        Nationality.text = Donor.nationality
        
        
    
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
