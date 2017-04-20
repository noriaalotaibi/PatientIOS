//
//  MyDoctorProfileViewController.swift
//  MHealth
//
//  Created by trn15 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
import Whisper

class MyDoctorProfileViewController: UIViewController {
    
    var myDoctor:DoctorDH = DoctorDH()

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSpecialty: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var genderLocal: UILabel!
    
    @IBOutlet weak var labelGender: UILabel!
    @IBAction func sendReport(sender: UIButton) {
        
        
        let nextScreen:PatientReportViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CaseReport") as! PatientReportViewController
        
        nextScreen.myDoctor = self.myDoctor
        
        let nav:UINavigationController = self.navigationController!
        
        //nextScreen.parent = self
        
        
        nav.pushViewController(nextScreen, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        labelName.text = myDoctor.firstName
        labelSpecialty.text = myDoctor.specialtyId
        labelLocation.text = myDoctor.location
        labelGender.text = myDoctor.gender
        
        genderLocal.text = Langs.arabicTitleForString("Gender")
        
        // Painter
        
//        let painter:AYPainter = AYPainter()
//        painter.setTheme(AYTheme.loadThemeFromFile("BlueTheme"))
//        painter.paint(self.view)
        
        // END Painter
        
    }
    
    override func viewDidAppear(animated: Bool) {
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
