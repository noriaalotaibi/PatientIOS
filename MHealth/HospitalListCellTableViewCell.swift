//
//  HospitalListCellTableViewCell.swift
//  MHealth
//
//  Created by Abrar Al-Failakawi on 4/9/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class HospitalListCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var hospitalPicture: UIImageView!
    
    @IBOutlet weak var hospitalN: UILabel!

    @IBOutlet weak var hospitalLocation: UILabel!
    @IBOutlet weak var HospitalType: UILabel!
    
    
    var hospitalObject:HospitalDH = HospitalDH()
    
    var hospitalIndex:Int = 0
    
    var hospitalVC:HospotalListVC?
    
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
        hospitalN.text = hospitalObject.hospitalName;
        
        HospitalType.text = hospitalObject.hospitalType;
        hospitalLocation.text = hospitalObject.hospitalAddress;
   
    }

}
