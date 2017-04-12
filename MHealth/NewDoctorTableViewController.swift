//
//  NewDoctorTableViewController.swift
//  MHealth
//
//  Created by trn15 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit


class NewDoctorTableViewController: UITableViewController, NetworkCaller,  UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    private var allDoctors:[DoctorDH] = [DoctorDH]()
    private var filteredDoctors:[DoctorDH] = [DoctorDH]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    //
    
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
            networkManager.AMGetArrayData("http://34.196.107.188:8080/mHealthWS/ws/doctor", params: [:], reqId: 1, caller: self)
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
        searchController.searchBar.scopeButtonTitles = ["Name", "Specialty"]
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
                return filteredDoctors.count
            }
            return allDoctors.count
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "All Doctors"
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var curDoctor:DoctorDH = DoctorDH()
        
        if searchController.active && searchController.searchBar.text != "" {
            curDoctor = filteredDoctors[indexPath.row]
        } else {
            curDoctor = allDoctors[indexPath.row]
        }

        // Configure the cell...
        let cellTypeIdentifier:String = "DoctorListTableViewCell";
        
        
        let nib:NSArray = NSBundle.mainBundle().loadNibNamed(cellTypeIdentifier, owner: self, options: nil)
        
        let cell = nib.firstObject as! DoctorListTableViewCell
        cell.updateCellData(curDoctor)
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let nextScreen:NewDoctorProfileViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NewDoctorProfile") as! NewDoctorProfileViewController
        
        if searchController.active && searchController.searchBar.text != "" {
            nextScreen.newDoctor = filteredDoctors[indexPath.row]
        } else {
            nextScreen.newDoctor = allDoctors[indexPath.row]
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
                let doctor:DoctorDH = DoctorDH()
                
                doctor.loadDictionary( resp.objectAtIndex(i) as! NSDictionary )
                allDoctors.append(doctor)
            }
            
            print("My Doctors Set!")
        }
        self.tableView.reloadData()
    }
    
    
    
    
    // Custom Search Bar METHODS
    
    func filterContentForSearchText(searchText: String, scope: NSString = "Name") {

        filteredDoctors = allDoctors.filter { doctor in

            if (scope == searchController.searchBar.scopeButtonTitles![1]) {
                return (doctor.specialtyId).lowercaseString.containsString(searchText.lowercaseString)
            }
            else {
                return
                    (doctor.firstName+" "+doctor.lastName).lowercaseString.containsString(searchText.lowercaseString)
            }
        }
        
        tableView.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
 

}
