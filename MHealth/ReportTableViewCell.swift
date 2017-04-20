//
//  ReportTableViewCell.swift
//  MHealth
//
//  Created by Shamlan Al-Roumi on 4/13/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
import SDWebImage

class ReportTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var responseImage: UIImageView!
    
    @IBOutlet weak var doctorName: UILabel!
    
    @IBOutlet weak var timeStamp: UILabel!
    
    @IBOutlet weak var status: UILabel!
    
    var reportData:PatientReportDH = PatientReportDH()
    
    var index:Int = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        img.layer.borderWidth = 2.0
        img.layer.masksToBounds = true
        img.layer.cornerRadius = img.frame.size.height/2
        img.layer.borderColor = UIColor.init(red: (63.0/255.0), green: (202.0/255.0), blue: (221.0/255.0), alpha: 0.75).CGColor
        //UIColor.init(red: 0, green: (191.0/255.0), blue: (255.0/255.0), alpha: 0.7).CGColor
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateCellData(report: PatientReportDH) {
        reportData = report;
        
        
        
        doctorName.text = report.name
        
        // Response status
        if (report.drcomment == "" || report.drcomment.isEmpty) {

            
            status.text = Langs.arabicTitleForString("Pending Response")
            responseImage.image = UIImage(named: "Message Filled-50")
            
        } else {
            status.text = Langs.arabicTitleForString("Replied")
            
            responseImage.image = UIImage(named: "Feedback-50")
            
        }
        
        img.sd_setImageWithURL( NSURL(string: report.imageURL), placeholderImage: UIImage(named: "medical-result"))
        
        
        let date:NSString = (report.timestamp as NSString).substringToIndex(10)
        
        timeStamp.text = date as String
        


    }

    
}
