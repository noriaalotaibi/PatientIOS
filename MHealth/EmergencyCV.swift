//

//  EmergencyCV.swift

//  MHealth

//

//  Created by trn14 on 3/5/17.

//  Copyright © 2017 PIFSS. All rights reserved.

//



import UIKit
import Whisper
import SwiftSpinner


class EmergencyCV: UIViewController , NetworkCaller, UIAlertViewDelegate {
    
    
    
    var counter = 11
    
    
    
    var timer = NSTimer()
    
    
    
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var FamilySwitch: UISwitch!
    
    @IBOutlet weak var DoctorsSwitch: UISwitch!
    
    @IBOutlet weak var HospitalSwitch: UISwitch!
    
    
    
    @IBAction func DoctorsSwitch(sender: AnyObject) {
        
        //        if DoctorsSwitch.on {
        
        //
        
        //        }
        
        //        else{
        
        //        }
        
    }
    
    @IBAction func HospitalSwitch(sender: AnyObject) {
        
        //        if HospitalSwitch.on {
        
        //
        
        //        }
        
        //        else{
        
        //        }
        
    }
    
    
    
    @IBAction func FamilySwitch(sender: AnyObject) {
        
        //        if FamilySwitch.on {
        
        //
        
        //        }
        
        //        else{
        
        //        }
        
    }
    
    
    
    @IBAction func CancelButton(sender: AnyObject) {
        
        
        
        timer.invalidate()
        var label = Langs.arabicTitleForString("Emergency Case Canceled")
        Label.text = label
       
        
        
    }
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        
        
        
    }
    
    
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        SwiftSpinner.hide()
        print(resp)
        Label.text = "Report sent"

        
    }
    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(timerAction), userInfo: nil , repeats: true)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        
        
        // Painter
//        
//        let painter:AYPainter = AYPainter()
//        painter.setTheme(AYTheme.loadThemeFromFile("BlueTheme"))
//        painter.paint(self.view)
        
        // END Painter
        
    }
    override func viewDidDisappear(animated: Bool) {
        timer.invalidate()
        counter = 10
        Label.text = ""

    }
    override func viewDidAppear(animated: Bool) {
        
        var title1=Langs.arabicTitleForString("No Internet Connection")
        var title2=Langs.arabicTitleForString("Confirmation")
        var title3=Langs.arabicTitleForString("OK")
        var title4=Langs.arabicTitleForString("Cancel")
        var message=Langs.arabicTitleForString("Send Emergency Report?")
        

        
        if (!Networking.isInternetAvailable()) {
      
            let message = Message(title: title1, textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        } else {
            startTimer()

        }
    }
    
    func timerAction() {
        
        print("Time is now \(counter) ")
        
        if counter != 0 {
            counter -= 1
            Label.text = NSLocalizedString("\(counter)", comment: "")
        }else{
            timer.invalidate()
            Label.text = Langs.arabicTitleForString("Sending Report ..")
            
            let patientId:Int = 0
            
            var family:Int = 0
            
            var hospital:Int = 0
            
            var doctors:Int = 0
            
            if FamilySwitch.state == UIControlState.Normal{
                
                family = 1}
            
            if HospitalSwitch.state == UIControlState.Normal{
                
                hospital = 1}
            
            if DoctorsSwitch.state == UIControlState.Normal{
                
                doctors = 1}
            
            let values = [NSLocalizedString( "family", comment: ""):family ,NSLocalizedString( "hospital", comment: "") :hospital , NSLocalizedString("doctors" , comment: ""):doctors]
            
            
            SwiftSpinner.show(NSLocalizedString("Connecting...", comment: ""))
            Networking().AMGetDictData(Const.URLs.ReportURL, params: values, reqId: 0 , caller: self)

        }
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
}