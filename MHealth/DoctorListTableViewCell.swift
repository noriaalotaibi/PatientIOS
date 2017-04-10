//
//  DoctorListTableViewCell.swift
//  MHealth
//
//  Created by Shamlan Al-Roumi on 4/9/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class DoctorListTableViewCell: UITableViewCell {
    
    //@IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var specialty: UILabel!
    @IBOutlet weak var gender: UILabel!
    
    
    var doctorData:DoctorDH = DoctorDH()
    
    var index:Int = 0
    
    var doctorVC:HospotalListVC?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        /*image.layer.borderWidth = 2.0
        image.layer.masksToBounds = true
        image.layer.cornerRadius = image.frame.size.height/2*/
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellData(doctor: DoctorDH) {
        doctorData = doctor;
        name.text = doctorData.firstName + doctorData.lastName
        specialty.text = doctorData.specialtyId;
        gender.text = "";
        gender.text?.append(doctorData.gender);
    }
    
}
