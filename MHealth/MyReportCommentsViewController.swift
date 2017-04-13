//
//  MyReportCommentsViewController.swift
//  MHealth
//
//  Created by Shamlan Al-Roumi on 4/12/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit
//import Whisper

class MyReportCommentsViewController: UIViewController, UITextViewDelegate  {

    @IBOutlet weak var patientCommentBox: UITextView!
    
    @IBOutlet weak var RecommendationBox: UITextView!
    
    var currentReport:PatientReportDH?
    var reportIndex:Int?
    
    var parentVC: MyReportViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        patientCommentBox.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.5).CGColor
        patientCommentBox.layer.borderWidth = 0.8
        //The rounded corner part, where you specify your view's corner radius:
        patientCommentBox.layer.cornerRadius = 5;
        patientCommentBox.clipsToBounds = true;
        
        RecommendationBox.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.5).CGColor
        RecommendationBox.layer.borderWidth = 0.8
        //The rounded corner part, where you specify your view's corner radius:
        RecommendationBox.layer.cornerRadius = 5;
        RecommendationBox.clipsToBounds = true;
        
        self.patientCommentBox.text = self.currentReport?.comments
        self.RecommendationBox.text = self.currentReport?.drcomment
        RecommendationBox.delegate = self
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
