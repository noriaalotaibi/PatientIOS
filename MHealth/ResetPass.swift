//
//  ResetPass.swift
//  MHealth
//
//  Created by Abrar Al-Failakawi on 3/6/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class ResetPass: UIViewController ,NetworkCaller {

    @IBOutlet weak var emailTF: UITextField!
    
    
    @IBOutlet weak var CivilidTF: UITextField!
    
    @IBAction func ResetPassButton(sender: AnyObject) {
        
        
        //add civil id civilid
        var resetPass = emailTF.text
        let networkManager:Networking = Networking()
        let values:[String:AnyObject] = ["email":resetPass!]
        
         networkManager.AMJSONDictionary(Const.URLs.ResetPassword, httpMethod: "POST", jsonData: values, reqId: 0, caller: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        
    }
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
