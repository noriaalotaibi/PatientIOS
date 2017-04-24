//
//  MyReportViewController.swift
//  MHealth
//
//  Created by Shamlan Al-Roumi on 4/12/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
import Whisper

class MyReportViewController: UITableViewController {
    
    //var parentVC:ReportsTVC?
    //var parentVC2:PatientProfileVC?
    var currentIndex = 0
    
    var currentPatientReport:PatientReportDH?
    
    var bloodPressure=Langs.arabicTitleForString("Blood pressure")
    var heartRate=Langs.arabicTitleForString("Heart rate")
    var sugarLevel=Langs.arabicTitleForString("Sugar level")
    var fever=Langs.arabicTitleForString("Fever")
    var caughing=Langs.arabicTitleForString("Caughing")
    var dizziness=Langs.arabicTitleForString("Dizziness")
    var nauseous=Langs.arabicTitleForString("Nauseous")
    var headache=Langs.arabicTitleForString("Headache")
    
    var reportTitles:[String] = []
    
    
    
    var reportIcons:[String] = ["bpiconnn","cardiogram","diabetes",
                                "fever","cough","dizziness",
                                "nauseous","headache", "painn"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportTitles = [self.bloodPressure,
        self.heartRate,
        self.sugarLevel,
        self.fever,
        self.caughing,
        self.dizziness,
        self.nauseous,
        self.headache]
        
        let button1 = UIBarButtonItem(image: nil, style: .Plain, target: self, action: #selector(openReplyController))
        button1.title = NSLocalizedString("View Reply", comment: "")
        
        self.navigationItem.rightBarButtonItem = button1
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if (self.currentPatientReport?.pain) == true {
            var painLocation=Langs.arabicTitleForString("Pain location")

            reportTitles.append(painLocation)
        }
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
         var connTitle=Langs.arabicTitleForString("No Internet Connection")
        if (!Networking.isInternetAvailable()) {
            let message = Message(title: connTitle, textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        }
    }
    
    func openReplyController()  {
        print("open Reply controleer")
        
        let reply:MyReportCommentsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MyReportComments") as! MyReportCommentsViewController
    
        reply.currentReport = self.currentPatientReport
        reply.reportIndex = self.currentIndex
        self.navigationController?.pushViewController(reply, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 //reportTitles.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    //
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        //         Configure the cell...
        
        let cell:UITableViewCell = UITableViewCell()
        let array:NSArray = (currentPatientReport?.toArray())!
        let theSelected:String = array.objectAtIndex(indexPath.section) as! String
        cell.textLabel?.text = theSelected
        cell.imageView?.image = UIImage(named:reportIcons[indexPath.section])
        
        var itemSize = CGSizeMake(35, 35)
        if (self.currentPatientReport?.pain) == true && indexPath.section == (reportTitles.count-1){
            itemSize = CGSizeMake(50, 40)
        }
        
        /*UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.mainScreen().scale)
        let imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height)
        cell.imageView?.image!.drawInRect(imageRect)
        cell.imageView?.image! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()*/
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return reportTitles[section]
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return " "
    }
    
    /*func updateReportAtIndex(index:Int, reportID:Int, report:PatientReportDH){
        self.currentPatientReport = report
        self.tableView.reloadData()
        if self.parentVC != nil {
            
            self.parentVC?.updateReportAtIndex(index, reportID: reportID, report: report)
        }
    }*/
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }


}
