import UIKit



class Reg1VC: UIViewController , NetworkCaller {

    struct current {
        static var newPatient:Patient = Patient()}
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var registrationStatus: UILabel!
     var gender:String=""
   
    @IBAction func registerGender(sender: AnyObject) {
        
        
        if sender.selectedSegmentIndex == 1 {
            
            self.gender = "f"
            
        }else{
            
            self.gender = "m"
        }
    }
    
    
    @IBAction func Register1Button(sender: AnyObject) {
        
      nextButton.enabled = false
        
        var email = emailTF.text
        var password = passwordTF.text
        var confirmPass = confirmPassTF.text
        
        
        
          
        current.newPatient.email=email!
        current.newPatient.password=password!
        current.newPatient.gender=gender
        
        let networkManager:Networking = Networking()
        let values = current.newPatient.toDictionary()
        //            networkManager.AMJSONDictionary(Const.URLs.Patients, httpMethod: "POST", jsonData: values, reqId: 1, caller: self)
        print(values)
  
        
        //            let nextScreen:RegisterPersonalInfoVC = self.storyboard?.instantiateViewControllerWithIdentifier("PatientInfo") as! RegisterPersonalInfoVC
        
        
        
        // self.presentViewController(nextScreen, animated: true, completion: {})
    }
    
    
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
    
    }

    func setDictResponse(resp: NSDictionary, reqId: Int) {
        //
        //       current.newPatient = Patient()
        //        current.newPatient.loadDictionary(resp)
        //        print(resp)
        //
        //        var patient = Patient()
        //        patient.loadDictionary(resp)
        
        
//        nextButton.enabled = true
//        
//        print(resp)
//        if resp.allKeys.count > 0 {
//            var alert = UIAlertView(title: "Invalid", message: "Can't register right now", delegate: self, cancelButtonTitle: "OK")
//            alert.show()
            // self.presentViewController(alert, animated: true, completion: nil)
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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