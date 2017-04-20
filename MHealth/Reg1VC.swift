import UIKit
import Whisper
import SwiftSpinner

class Reg1VC: UIViewController , NetworkCaller , UITextFieldDelegate{

    struct current {
        static var newPatient:Patient = Patient()
    
    }
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var registrationStatus: UILabel!
     var gender:String="m"
   
    @IBAction func registerGender(sender: AnyObject) {
        
        
        if sender.selectedSegmentIndex == 1 {
            
            self.gender = "f"
            
        }else{
            
            self.gender = "m"
        }
    }
    
    
    @IBAction func Register1Button(sender: AnyObject) {
        
        
        var email = emailTF.text!
        var password = passwordTF.text
        var confirmPass = confirmPassTF.text
        var emailTitle = Langs.arabicTitleForString("Email")
         var passTitle = Langs.arabicTitleForString("Password")
        var emailMsg = Langs.arabicTitleForString("Please enter a valid email")
        var passMsg = Langs.arabicTitleForString("Password do not match")
        var passMsg2 = Langs.arabicTitleForString("Password is invalid, minimum of 8 characters")
        var cancelButton = Langs.arabicTitleForString("OK")
        
        
        if !(Validator().validateEmail(email)){
           
            var alert = UIAlertView(title: emailTitle, message: emailMsg, delegate: self, cancelButtonTitle: cancelButton)
            alert.show()
            
            return
            
        }

        if password != confirmPass{
            
            var alert = UIAlertView(title: passTitle , message: passMsg , delegate: self, cancelButtonTitle: cancelButton)
            alert.show()
            
            return
        }
        
        if !(Validator().validatePassword(password)) {
            var alert = UIAlertView(title: passTitle , message: passMsg2 , delegate: self, cancelButtonTitle: cancelButton)
            alert.show()
            
            return
        }
        
        
        current.newPatient.email=email
        current.newPatient.password=password!
        current.newPatient.gender=gender
        
        
        let networkManager:Networking = Networking()
        
        print("request values: ")
        
        //print(values)
  
            SwiftSpinner.show("Validating Username...")
            SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 22.0))
        let url:String = Const.URLs.Patients+"/email/\(email)"
        print("url: \(url)")
        networkManager.AMGetDictData(url, params: [:], reqId: 1, caller: self)
        //networkManager.AMJSONDictionary(url, httpMethod: "GET", jsonData: [:], reqId: 1, caller: self)
        
    }
    
    
    
    func setArrayResponse(resp: NSArray, reqId: Int) {
    
    }

    func setDictResponse(resp: NSDictionary, reqId: Int) {
        print("response: ")
        print(resp)
        
        SwiftSpinner.hide()
        
        if resp.valueForKey("Error") != nil {
            var cancelButton = Langs.arabicTitleForString("OK")
            
            var alert = UIAlertView(title: "Connection Error", message: "Please try again.", delegate: self, cancelButtonTitle: cancelButton)
            alert.show()
            return
        }
        if resp.valueForKey("patientId") != nil {
            // email exist
            var cancelButton = Langs.arabicTitleForString("OK")

            var alert = UIAlertView(title: "Email already exist", message: "Please try another email.", delegate: self, cancelButtonTitle: cancelButton)
            alert.show()
            
            return
            
        } else {
            let reply:RegisterPersonalInfoVC = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterPersonalInfo") as! RegisterPersonalInfoVC
            
            self.navigationController?.pushViewController(reply, animated: true)
        }
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailTF.delegate = self
        passwordTF.delegate = self
        confirmPassTF.delegate = self
        
        // Painter
        
              
        // END Painter
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if (!Networking.isInternetAvailable()) {
            var noNetwork = Langs.arabicTitleForString("No Internet Connection")
            let message = Message(title: noNetwork, textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), images: nil)
            Whisper(message, to: self.navigationController!, action: .Show)
            Silent(self.navigationController!, after: 3.0)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluateWithObject(enteredEmail)
        
    }

    
}