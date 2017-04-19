//
//  ViewMedicalInfoVC.swift
//  MHealth
//
//  Created by Abrar Al-Failakawi on 3/7/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
import Whisper

class ViewMedicalInfoVC: UIViewController  {
    @IBOutlet weak var BloodTypeLabel: UILabel!
    @IBOutlet weak var DiabetesLabel: UILabel!
    @IBOutlet weak var AsthmaLabel: UILabel!
    @IBOutlet weak var AllergiesLabel: UILabel!
    @IBOutlet weak var MedicationLabel: UILabel!
    
    var patient=Patient()
    
    var newPatient:Patient = Patient()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Painter
        
//        let painter:AYPainter = AYPainter()
//        painter.setTheme(AYTheme.loadThemeFromFile("BlueTheme"))
//        painter.paint(self.view)
        
        // END Painter
    }

    override func viewDidAppear(animated: Bool) {
        let Patient:NSDictionary = NSUserDefaults.standardUserDefaults().valueForKey(Const.UserDefaultsKeys.loggedinUser) as! NSDictionary
        
        patient.loadDictionary(Patient);
        BloodTypeLabel?.text=patient.bloodType
        DiabetesLabel?.text = "\(patient.diabetes)"
        AsthmaLabel?.text = "\(patient.asthma)"
        AllergiesLabel?.text = patient.allergies
        MedicationLabel?.text = patient.medication
        
            if (!Networking.isInternetAvailable()) {
                let message = Message(title: NSLocalizedString("No Internet Connection", comment: ""), textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
                Whisper(message, to: self.navigationController!, action: .Show)
                Silent(self.navigationController!, after: 3.0)
            }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
