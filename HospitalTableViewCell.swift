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

class HospitalTableViewCell: UITableViewCell{

    @IBOutlet weak var hospitalPicture: UIImageView!
    
    @IBOutlet weak var hospitalN: UILabel!
    
    @IBOutlet weak var hospitalLocation: UILabel!
    @IBOutlet weak var HospitalType: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    
    var latitude:Float = 0.0
    var longitude:Float = 0.0
    
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
    
    func updateCellData(hospital: HospitalDH, latitude:Double, longitude:Double) {
        hospitalObject = hospital;
        HospitalType.text = hospitalObject.hospitalType;
        hospitalN.text = hospitalObject.hospitalName;
        hospitalPicture.sd_setImageWithURL( NSURL(string: hospitalObject.hospitalLogoURL), placeholderImage: UIImage(named: "hospital-1"))
        hospitalLocation.text = hospitalObject.hospitalAddress;
        let d:Double = distance(latitude, lon1: longitude, lat2: hospital.hospitalAlt, lon2: hospital.hospitalLang)
        distance.text = String(format:NSLocalizedString("%.2f KM", comment: "") , d);     }
    
    func distance(lat1:Double, lon1:Double, lat2:Double, lon2:Double) -> Double {
        let theta = lon1 - lon2
        var dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) + cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta))
        dist = acos(dist)
        dist = rad2deg(dist)
        dist = dist * 60 * 1.1515

        dist = dist * 1.609344

//        if (unit == "K") {
//            dist = dist * 1.609344
//        }
//        else if (unit == "N") {
//            dist = dist * 0.8684
//        }
        return dist
    }
    func rad2deg(rad:Double) -> Double {
        return rad * 180.0 / M_PI
    }
    func deg2rad(deg:Double) -> Double {
        return deg * M_PI / 180
    }
}
