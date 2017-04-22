//
//  ReportTableViewController.swift
//  MHealth
//
//  Created by Shamlan Al-Roumi on 4/12/17.
//  Copyright © 2017 PIFSS. All rights reserved.
// http://34.196.107.188:8081/MhealthWeb/webresources/patientreport/

import UIKit
import Whisper
import SwiftSpinner

class ReportTableViewController: UITableViewController, NetworkCaller,  UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {

    
    private var allReports:[PatientReportDH] = [PatientReportDH]()
    private var filteredReports:[PatientReportDH] = [PatientReportDH]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false
        self.tableView.separatorColor = UIColor.clearColor()
        self.tableView.rowHeight = 125
        
        
        // Search Bar
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        //searchController.searchBar.scopeButtonTitles = ["Doctor Name"]
        searchController.searchBar.delegate = self
        
        // Painter
               // END Painter
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // Check Internet
        if (Networking.isInternetAvailable()) {
            let networkManager = Networking()
            networkManager.logging = true
            
            // Logged in Patient
            let loggedInPatient:Patient = Patient()
            let patient:NSDictionary = NSUserDefaults.standardUserDefaults().valueForKey(Const.UserDefaultsKeys.loggedinUser) as! NSDictionary
            
            loggedInPatient.loadDictionary(patient);
            
            SwiftSpinner.show("Retrieving Data...")
            SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 22.0))
            
            networkManager.AMGetArrayData("http://34.196.107.188:8081/MhealthWeb/webresources/patientreport/getPr/\(loggedInPatient.patientID)", params: [:], reqId: 1, caller: self)
            
            //  Spinner
            
            
        } else {
            //askk
             var connTitle=Langs.arabicTitleForString("No Internet Connection")
            let message = Message(title: connTitle, textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        }
        // --------------
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            if searchController.active && searchController.searchBar.text != "" {
                return filteredReports.count
            }
            return allReports.count
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Reports"
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var curReport:PatientReportDH = PatientReportDH()
        
        if searchController.active && searchController.searchBar.text != "" {
            curReport = filteredReports[indexPath.row]
        } else {
            curReport = allReports[indexPath.row]
        }
        
        // Configure the cell...
        let cellTypeIdentifier:String = "ReportTableViewCell";
        
        
        let nib:NSArray = NSBundle.mainBundle().loadNibNamed(cellTypeIdentifier, owner: self, options: nil)
        
        let cell = nib.firstObject as! ReportTableViewCell
        cell.updateCellData(curReport)
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let nextScreen:MyReportViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MyReport") as! MyReportViewController
        
        if searchController.active && searchController.searchBar.text != "" {
            nextScreen.currentPatientReport = filteredReports[indexPath.row]
        } else {
            nextScreen.currentPatientReport = allReports[indexPath.row]
        }
        
        
        let nav:UINavigationController = self.navigationController!
        
        //nextScreen.parent = self
        
        
        nav.pushViewController(nextScreen, animated: true)
    }
    
    
    func setDictResponse(resp:NSDictionary, reqId:Int) {
        /*if (reqId == 1) {
            print( resp )
            
            let report:PatientReportDH = PatientReportDH()
            report.loadDictionary(resp)
            allReports.append(report)
            
        }
        
        self.tableView.reloadData()*/
    }
    
    func setArrayResponse(resp:NSArray, reqId:Int) {
        if (resp.count == 0) {
            
        } else {

        allReports.removeAll()
        filteredReports.removeAll()
        // set doctors
        if (reqId == 1) {
            print( resp )
            
            for i in 0..<resp.count {
                let report:PatientReportDH = PatientReportDH()
                
                report.loadDictionary( resp.objectAtIndex(i) as! NSDictionary )
                
                allReports.append(report)
            }
            
        }
        self.tableView.reloadData()
            
        }
        SwiftSpinner.hide()
    }
    
    
    
    
    // Custom Search Bar METHODS
    //askk
    func filterContentForSearchText(searchText: String, scope: NSString = "Doctor Name") {
        
        filteredReports = allReports.filter { report in
            
            return report.name.lowercaseString.containsString(searchText.lowercaseString)
            /*if (scope == searchController.searchBar.scopeButtonTitles![0]) {
                return searchText.lowercaseString.containsString(report.name.lowercaseString)
            } else {
                return true
            }*/
            
        }
        
        tableView.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        //let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    


 

}
