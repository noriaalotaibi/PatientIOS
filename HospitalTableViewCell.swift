//
//  HospitalTableViewCell.swift
//  MHealth
//
//  Created by Shamlan Al-Roumi on 4/11/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class HospitalTableViewCell: UITableViewCell {

    @IBOutlet weak var hospitalPicture: UIImageView!
    
    @IBOutlet weak var hospitalN: UILabel!
    
    @IBOutlet weak var hospitalLocation: UILabel!
    @IBOutlet weak var HospitalType: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    
    
    var hospitalObject:HospitalDH = HospitalDH()
    
    var hospitalIndex:Int = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        hospitalPicture.layer.borderWidth = 2.0
        hospitalPicture.layer.masksToBounds = true
        // hospitalPicture.layerborderColor = Customization().UIColorFromRGB(0x4C9DB9).CGColor
        hospitalPicture.layer.cornerRadius = hospitalPicture.frame.size.height/2
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateCellData(hospital: HospitalDH) {
        hospitalObject = hospital;
        HospitalType.text = hospitalObject.hospitalType;
        hospitalN.text = hospitalObject.hospitalName;
        hospitalPicture.sd_setImageWithURL( NSURL(string: hospitalObject.hospitalLogoURL), placeholderImage: UIImage(named: "hospital-1"))
        hospitalLocation.text = hospitalObject.hospitalAddress;
        distance.text = "N/A";
        
    }
    
}
