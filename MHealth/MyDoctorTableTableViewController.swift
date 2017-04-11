//
//  MyDoctorTableTableViewController.swift
//  MHealth
//
//  Created by trn15 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class MyDoctorTableViewController: UITableViewController, NetworkCaller,  UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    var cacheManager:MyDoctorsCache? = nil
    private var filteredDoctors:[DoctorDH] = [DoctorDH]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //
    func alert(title: String, message: String) {
        if let getModernAlert: AnyClass = NSClassFromString("UIAlertController") { // iOS 8
            let myAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            myAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(myAlert, animated: true, completion: nil)
        } else { // iOS 7
            let alert: UIAlertView = UIAlertView()
            alert.delegate = self
            
            alert.title = title
            alert.message = message
            alert.addButtonWithTitle("OK")
            
            alert.show()
        }
    }
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cacheManager = MyDoctorsCache.myInstance()
        cacheManager?.caller = self
        
        // Check Internet
        if (Networking.isInternetAvailable()) {
            // network requests managed in Cache; error message auto. displayed
        }
        // --------------
        
        self.tableView.rowHeight = 125
        self.tableView.separatorColor = UIColor.clearColor()
        
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
        if (section == 0) {
            if searchController.active && searchController.searchBar.text != "" {
                return filteredDoctors.count
            }
            return MyDoctorsCache.myInstance().getDoctors().count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "My Doctors"
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var curDoctor = DoctorDH()
        if searchController.active && searchController.searchBar.text != "" {
            curDoctor = filteredDoctors[indexPath.row]
        } else {
            curDoctor = MyDoctorsCache.myInstance().getDoctors()[indexPath.row]
        }

        // Configure the cell...
        let cellTypeIdentifier:String = "DoctorListTableViewCell";
        
        
        let nib:NSArray = NSBundle.mainBundle().loadNibNamed(cellTypeIdentifier, owner: self, options: nil)
        
        let cell = nib.firstObject as! DoctorListTableViewCell
        cell.updateCellData(curDoctor)
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let nextScreen:MyDoctorProfileViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MyDoctorProfile") as! MyDoctorProfileViewController
        
        if searchController.active && searchController.searchBar.text != "" {
            nextScreen.myDoctor = filteredDoctors[indexPath.row]
        } else {
            nextScreen.myDoctor = MyDoctorsCache.myInstance().getDoctors()[indexPath.row]
        }
        
        
        
        let nav:UINavigationController = self.navigationController!
        
        //nextScreen.parent = self
        
        
        nav.pushViewController(nextScreen, animated: true)
    }
    
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        self.tableView.reloadData()
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        self.tableView.reloadData()
    }
    
    // Custom Search Bar METHODS
    
    func filterContentForSearchText(searchText: String, scope: NSString = "Name") {
        
        filteredDoctors = MyDoctorsCache.myInstance().getDoctors().filter { doctor in
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
