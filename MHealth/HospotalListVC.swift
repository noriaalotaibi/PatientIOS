//
//  HospotalListVC.swift
//  MHealth
//
//  Created by Abrar Al-Failakawi on 4/9/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class HospotalListVC: UITableViewController, NetworkCaller {
    
    
    struct list {
        static var hospitalList:NSMutableArray = NSMutableArray()
    }
    
    func loadData(){
        
        
      //  let hospitalId:Int = NSUserDefaults.standardUserDefaults().valueForKey(Const.UserDefaultsKeys.hospitalID) as! Int
        
        let url:String = Const.URLs.Hospital
        
        
        
        let networkManager:Networking = Networking()
       // SwiftSpinner.show(NSLocalizedString("Connecting...", comment: ""))
        
        networkManager.AMGetArrayData(url, params: [:], reqId: 1, caller: self)
        
        
    }
    
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
               // loop on resp .. get each dictionary .. convert to object .. add to list manager
        
        print (resp)
        list.hospitalList.removeAllObjects()
        for item in resp {
            
            let hosItem = item as! NSDictionary
            
            let hospital:HospitalDH = HospitalDH()
            
            hospital.loadDictionary(hosItem)
            
            list.hospitalList.addObject(hospital)
        }
        
        self.tableView.reloadData()
    }
    
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        
    }

    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.registerNib(UINib(nibName: "HospitalListCellTableViewCell", bundle: nil), forCellReuseIdentifier: "HospitalListCellTableViewCell")
        
        loadData()
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
        return list.hospitalList.count
    }
    
    

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        
     //   let cell:HospitalListCellTableViewCell = (tableView.dequeueReusableCellWithIdentifier("HospitalListCellTableViewCell ") as? HospitalListCellTableViewCell )!
        
        let hospital:HospitalDH = list.hospitalList.objectAtIndex(indexPath.row) as! HospitalDH
        
        print("***")
        
        
        let url:NSURL = NSURL(string: hospital.hospitalLogoURL)!
        
        let hospitalName:String = hospital.hospitalName
        
        let hospitalType:String = hospital.hospitalType
        let hospitalAddress:String = hospital.hospitalAddress
        
        
//        cell.hospitalN.text = hospitalName
//        
//        cell.hospitalLocation.text = hospitalAddress
//        
//        cell.HospitalType.text = hospitalType
//        
//        
//        
//        cell.hospitalObject = hospital
//        cell.hospitalIndex = indexPath.row
        

        return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let cell:HospotalListVC = (tableView.dequeueReusableCellWithIdentifier("HospotalListVC") as? HospotalListVC)!
        
        
      //  return cell.frame.size.height
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
