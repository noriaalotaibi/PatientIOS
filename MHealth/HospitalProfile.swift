//
//  HospitalProfile.swift
//  MHealth
//
//  Created by Abrar Al-Failakawi on 4/10/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
import SDWebImage
import Whisper

class HospitalProfile: UIViewController {

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
        
        
        
        HospitalName.text=hospital.hospitalName
        HospitalEmail.text=hospital.hospitalEmail
        HospitalType.text=hospital.hospitalType
        HospitalPhoneNum.text=hospital.hospitalPhone
        HospitalImage.sd_setImageWithURL( NSURL(string: hospital.hospitalLogoURL), placeholderImage: UIImage(named: "hospital-1"))
        //HospitalSpeciality.text = hospital.hospitalSpecilityId
        HospitalWorkingHours.text=hospital.hospitalWorkingHours
        HospitalAddress.text=hospital.hospitalAddress
        HospitalAdditionalInfo.text=hospital.hospitalExtrainfo

        
        // Painter
        
        let painter:AYPainter = AYPainter()
        painter.setTheme(AYTheme.loadThemeFromFile("BlueTheme"))
        painter.paint(self.view)
        
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
