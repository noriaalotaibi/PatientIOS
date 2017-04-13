//
//  ReportTableViewCell.swift
//  MHealth
//
//  Created by Shamlan Al-Roumi on 4/13/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class ReportTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var timeStamp: UILabel!
    
    @IBOutlet weak var doctotrName: UILabel!
    
    var reportData:PatientReportDH = PatientReportDH()
    
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
    
    func updateCellData(report: PatientReportDH) {
        reportData = report;
        
        name.text = report.name
        timeStamp.text = report.timestamp
    }

    
}
