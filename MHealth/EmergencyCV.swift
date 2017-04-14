//

//  EmergencyCV.swift

//  MHealth

//

//  Created by trn14 on 3/5/17.

//  Copyright © 2017 PIFSS. All rights reserved.

//



import UIKit



class EmergencyCV: UIViewController , NetworkCaller {
    
    
    
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
        
        
        
        Label.text = "Emergency Case Canceled"
        
        
        
    }
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
        
        
        
    }
    
    
    
    func setDictResponse(resp: NSDictionary, reqId: Int) {
        
        
        
        print(resp)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(timerAction), userInfo: nil , repeats: true)
        
        // Painter
        
        let painter:AYPainter = AYPainter()
        painter.setTheme(AYTheme.loadThemeFromFile("BlueTheme"))
        painter.paint(self.view)
        
        // END Painter
        
        
        
    }
    
    func timerAction() {
        
        print("Time is now \(counter) ")
        
        
        
        if counter != 0 {
            
            counter -= 1
            
            
            
            Label.text = "\(counter)"
            
        }
            
        else{
            
            Label.text = "Sending Report .."
            
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
            
            let values = ["family":family , "hospital":hospital , "doctors":doctors]
            
            Networking().AMGetArrayData(Const.URLs.ReportURL, params: values, reqId: 0 , caller: self)
            
            timer.invalidate()
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
}