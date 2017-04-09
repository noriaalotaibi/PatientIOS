//
//  BloodViewController.swift
//  MHealth
//
//  Created by trn15 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.


import UIKit

class BloodViewController: UIViewController  , UIPickerViewDelegate , UIPickerViewDataSource{

    
    let BloodTypePD = ["A+" , "A" , "A-" , "B+" , "B" , "B-" , "O+" , "O" , "O-", "AB+" , "AB" , "AB-"]
    
    
    @IBOutlet var BloodTypePicker: UIPickerView!
    
    
    @IBAction func SearchDonorAction(sender: AnyObject) {
        
        let nextScreen:BloodTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("BloodDonors") as! BloodTableViewController
        
        nextScreen.bloodType = BloodTypePD[BloodTypePicker.selectedRowInComponent(0)]
        
        
        
        let nav:UINavigationController = self.navigationController!
        
        
        
        nav.pushViewController(nextScreen, animated: true)

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BloodTypePicker.delegate = self
        BloodTypePicker.dataSource = self
        BloodTypePicker.tag = 1
        
        
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){
            return BloodTypePD.count
        }
    return 1
    }
    
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return BloodTypePD[row]
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
