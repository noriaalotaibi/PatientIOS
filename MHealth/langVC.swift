//
//  langVC.swift
//  MHealth
//
//  Created by trn14 on 3/5/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
import Whisper


class langVC: UIViewController {
    
    var title1 = Langs.arabicTitleForString("Language")
    var message = Langs.arabicTitleForString("Language has been changed into Arabic")
    var okButton = Langs.arabicTitleForString("OK")
    @IBAction func ArabicButton(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(["ar"], forKey: "AppleLanguages")
        NSUserDefaults.standardUserDefaults().setObject("ar", forKey: Const.UserDefaultsKeys.langKey)
        var alert = UIAlertView(title: title1, message: message, delegate: self, cancelButtonTitle:okButton)
        alert.show()

    }
    
    @IBOutlet var Image: UIImageView!
    
    @IBAction func EnglishButton(sender: AnyObject) {
        
        var title2 = Langs.arabicTitleForString("Language")
        var message2 = Langs.arabicTitleForString("Language has been changed into English")
        var okButton2 = Langs.arabicTitleForString("OK")
        
          NSUserDefaults.standardUserDefaults().setObject(["en"], forKey: "AppleLanguages")
        NSUserDefaults.standardUserDefaults().setObject("en", forKey: Const.UserDefaultsKeys.langKey)

        var alert = UIAlertView(title:title2, message: message2, delegate: self, cancelButtonTitle:okButton2 )
        alert.show()
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

        // Painter
        
//        let painter:AYPainter = AYPainter()
//        painter.setTheme(AYTheme.loadThemeFromFile("BlueTheme"))
//        painter.paint(self.view)
        
        // END Painter
    
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        var connTitle=Langs.arabicTitleForString("No Internet Connection")
        if (!Networking.isInternetAvailable()) {
            let message = Message(title: connTitle, textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        }
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
