//
//  langVC.swift
//  MHealth
//
//  Created by trn14 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
import VideoSplashKit

class langVC: VideoSplashViewController {
    @IBAction func ArabicButton(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(["ar"], forKey: "AppleLanguages")
        

    }
    
    @IBOutlet var Image: UIImageView!
    
    @IBAction func EnglishButton(sender: AnyObject) {
        
          NSUserDefaults.standardUserDefaults().setObject(["en"], forKey: "AppleLanguages")
        
//        let userDefaults =  NSUserDefaults.standardUserDefaults()
//        if sender.tag == 1
//        {
//            // english
//            userDefaults.setObject("EN", forKey: "AppleLanguages")
//        } else
//        {
//            //arbaic
//            userDefaults.setObject("AR", forKey: "AppleLanguages")
        //}
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()


        let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("heart", ofType: "mp4")!)
        
        self.videoFrame = view.frame
        self.fillMode = .ResizeAspectFill
        self.alwaysRepeat = true
        self.sound = true
        self.startTime = 0.0
        self.duration = 10.0
        self.alpha = 0.7
        self.backgroundColor = UIColor.whiteColor()
        self.contentURL = url
        self.restartForeground = true
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
