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
        img.layer.borderColor = UIColor.init(red: (255.0/255.0), green: 0.0, blue: 0.0, alpha: 0.75).CGColor
            //UIColor.init(red: 0, green: (191.0/255.0), blue: (255.0/255.0), alpha: 0.7).CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellData(doctor: DoctorDH) {
        doctorData = doctor;
        var placeholder = ""
        if doctor.gender == "f" || doctor.gender == "F" {
            placeholder = "doctor_profile"
        } else {
            placeholder = "dr"
        }
        
        img.sd_setImageWithURL( NSURL(string: doctor.imageUrl), placeholderImage: UIImage(named: placeholder))
        name.text = doctorData.firstName + doctorData.lastName
        specialty.text = doctorData.specialtyId;
        gender.text = doctor.gender
//        gender.text?.append(doctor.gender)
    }
    
}
