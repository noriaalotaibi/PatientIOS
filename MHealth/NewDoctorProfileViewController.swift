//
//  NewDoctorProfileViewController.swift
//  MHealth
//
//  Created by trn15 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class NewDoctorProfileViewController: UIViewController, NetworkCaller {
    
    var newDoctor:DoctorDH = DoctorDH()
    var callerManager:DoctorFunctions? = nil


    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSpecialty: UILabel!
    @IBOutlet weak var labelLocation: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelName.text = newDoctor.firstName
        labelSpecialty.text = newDoctor.specialtyId
        labelLocation.text = newDoctor.location
        
        callerManager = DoctorFunctions.myInstance()
        callerManager?.callerInvitation = self
        
        
        // Painter
        
        let painter:AYPainter = AYPainter()
        painter.setTheme(AYTheme.loadThemeFromFile("BlueTheme"))
        painter.paint(self.view)
        
        // END Painter
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendInvitationRequest(sender: AnyObject) {
        
        DoctorFunctions.myInstance().sendInvitationRequest(PatientContainer.getInstance().loggedInPatient, doctor: newDoctor)
    }
    // Response in case of invitation sent
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        
    }
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        let alertControlle:UIAlertController = UIAlertController(title:NSLocalizedString("Success", comment: "") , message: NSLocalizedString("Invitation was sent sucessfully", comment: ""), preferredStyle: .Alert)
        
        let action:UIAlertAction =  UIAlertAction(title: "OK", style: .Cancel, handler: { (UIAlertAction) in
            self.navigationController?.popViewControllerAnimated(true)
        })
        alertControlle.addAction(action)
        self.presentViewController(alertControlle, animated: true, completion: nil)

    }

}
