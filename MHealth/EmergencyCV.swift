//

//  EmergencyCV.swift

//  MHealth

//

//  Created by trn14 on 3/5/17.

//  Copyright © 2017 PIFSS. All rights reserved.

//



import UIKit
import Whisper



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
        
        
        
        print(resp)
        
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
    
    override func viewDidAppear(animated: Bool) {
        if (!Networking.isInternetAvailable()) {
            let message = Message(title: NSLocalizedString("No Internet Connection", comment: ""), textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        } else {
            let alert = UIAlertController(title: NSLocalizedString("Confirmation" , comment: ""), message: NSLocalizedString("Send Emergency Report?" , comment: ""), preferredStyle: .ActionSheet)
            
            
            
            let confirmAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                self.startTimer()
            }
            
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func timerAction() {
        
        print("Time is now \(counter) ")
        
        
        
        if counter != 0 {
            
            counter -= 1
            
            
            
            Label.text = NSLocalizedString("\(counter)", comment: "")
            
        }
            
        else{
            
            Label.text = NSLocalizedString( "Sending Report ..", comment: "")
            
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
            
            Networking().AMGetArrayData(Const.URLs.ReportURL, params: values, reqId: 0 , caller: self)
            
            timer.invalidate()
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
}