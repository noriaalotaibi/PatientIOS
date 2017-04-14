//
//  MyDoctorProfileViewController.swift
//  MHealth
//
//  Created by trn15 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class MyDoctorProfileViewController: UIViewController {
    
    var myDoctor:DoctorDH = DoctorDH()

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSpecialty: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    
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
    
    
    
    


}
