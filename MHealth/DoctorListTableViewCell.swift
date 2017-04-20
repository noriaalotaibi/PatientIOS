//
//  DoctorListTableViewCell.swift
//  MHealth
//
//  Created by Shamlan Al-Roumi on 4/9/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class DoctorListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var specialty: UILabel!
    @IBOutlet weak var gender: UILabel!
    
    
    var doctorData:DoctorDH = DoctorDH()
    
    var index:Int = 0
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        img.layer.borderWidth = 2.0
        img.layer.masksToBounds = true
        img.layer.cornerRadius = img.frame.size.height/2
        img.layer.borderColor = UIColor.init(red: (63.0/255.0), green: (202.0/255.0), blue: (221.0/255.0), alpha: 0.75).CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellData(doctor: DoctorDH) {
        doctorData = doctor;

        
        name.text = doctorData.firstName + doctorData.lastName
        specialty.text = doctorData.specialtyId;
    
        var genderNSString = NSString()
        genderNSString = doctorData.gender
        gender.text = "N/A"
        
        var placeholder = "dr"
        if (genderNSString != "") {
            if (genderNSString.substringToIndex(1).lowercaseString == "f") {
                gender.text = "Female"
                placeholder = "doctor_profile"
            } else {
                gender.text = "Male"
            }
        }
        
        img.sd_setImageWithURL( NSURL(string: doctor.imageUrl), placeholderImage: UIImage(named: placeholder))
    }
    
}
