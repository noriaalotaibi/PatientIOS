//
//  HospitalTableViewController.swift
//  MHealth
//
//  Created by trn15 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class HospitalTableViewController: UITableViewController, NetworkCaller,  UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    private var allHospitals:[HospitalDH] = [HospitalDH]()
    private var filteredHospitals:[HospitalDH] = [HospitalDH]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false
        self.tableView.separatorColor = UIColor.clearColor()
        self.tableView.rowHeight = 125
        
        // Check Internet
        if (Networking.isInternetAvailable()) {
            let networkManager = Networking()
            networkManager.logging = true
            networkManager.AMGetArrayData("http://34.196.107.188:8080/mHealthWS/ws/hospital", params: [:], reqId: 1, caller: self)
        } else {
            
        }
        // --------------
        
        
        // Search Bar
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableHeaderView?.backgroundColor = UIColor.init(red: (255.0/255.0), green: 0.0, blue: 0.0, alpha: 0.75)
        searchController.searchBar.backgroundColor = UIColor.init(red: (255.0/255.0), green: 0.0, blue: 0.0, alpha: 0.75)
        searchController.searchBar.tintColor = UIColor.whiteColor()
        searchController.searchBar.barTintColor = UIColor.init(red: (255.0/255.0), green: 0.0, blue: 0.0, alpha: 0.75)
        searchController.searchBar.scopeButtonTitles = ["Public", "Private"]
        searchController.searchBar.delegate = self
        
        
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
                return filteredHospitals.count
            }
            return allHospitals.count
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Hospitals"
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var curHospital:HospitalDH = HospitalDH()
        
        if searchController.active && searchController.searchBar.text != "" {
            curHospital = filteredHospitals[indexPath.row]
        } else {
            curHospital = allHospitals[indexPath.row]
        }
        
        // Configure the cell...
        let cellTypeIdentifier:String = "HospitalTableViewCell";
        
        
        let nib:NSArray = NSBundle.mainBundle().loadNibNamed(cellTypeIdentifier, owner: self, options: nil)
        
        let cell = nib.firstObject as! HospitalTableViewCell
        cell.updateCellData(curHospital)
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let nextScreen:HospitalProfile = self.storyboard?.instantiateViewControllerWithIdentifier("HospitalProfile") as! HospitalProfile
        
        if searchController.active && searchController.searchBar.text != "" {
            nextScreen.hospital = filteredHospitals[indexPath.row]
        } else {
            nextScreen.hospital = allHospitals[indexPath.row]
        }
        
        
        let nav:UINavigationController = self.navigationController!
        
        //nextScreen.parent = self
        
        
        nav.pushViewController(nextScreen, animated: true)
    }
    
    
    func setDictResponse(resp:NSDictionary, reqId:Int) {
        self.tableView.reloadData()
    }
    
    func setArrayResponse(resp:NSArray, reqId:Int) {
        // set doctors
        if (reqId == 1) {
            print( resp )
            
            for i in 0..<resp.count {
                let hospital:HospitalDH = HospitalDH()
                
                hospital.loadDictionary( resp.objectAtIndex(i) as! NSDictionary )
                allHospitals.append(hospital)
            }
            
        }
        self.tableView.reloadData()
    }
    
    
    
    
    // Custom Search Bar METHODS
    
    func filterContentForSearchText(searchText: String, scope: NSString = "Public") {
        
        filteredHospitals = allHospitals.filter { hospital in
            
            return (hospital.hospitalType).lowercaseString.containsString(scope as String)
            
            /*if (scope == searchController.searchBar.scopeButtonTitles![1]) {
                return (hospital.hospitalType).lowercaseString.containsString(searchText.lowercaseString)
            }
            else {
                return
                    (doctor.firstName+" "+doctor.lastName).lowercaseString.containsString(searchText.lowercaseString)
            }*/
        }
        
        tableView.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
    
    
}
