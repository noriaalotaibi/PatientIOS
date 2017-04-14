//
//  Painter.swift
//  ThemeLoader
//
//  Created by Ahmed on 9/20/16.
//  Copyright © 2016 ITI. All rights reserved.
//

import UIKit


extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), color.CGColor)
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, forState: forState)
    }
}

class AYPainter: NSObject {
    
    internal var _theme:AYTheme?
    
    func setTheme(theme:AYTheme){
        self._theme = theme
    }
    
    func paint(view:UIView){
        self.paintMainView(view)
        self.viewAnalyser(view)
    }
    
    func paintMainView(view:UIView){
        view.backgroundColor = _theme?.viewColor
    }
    
    func paintButton(button:UIButton){
        
        button.setBackgroundColor((_theme?.backgroundbuttonColor)!, forState: .Normal)
        button.setBackgroundColor((_theme?.secondaryColor)!, forState: .Highlighted)
        
        
        button.setTitleColor((_theme?.buttonTitleNormalColor), forState: .Normal)
        button.setTitleColor((_theme?.buttonTitleClickedColor), forState: .Highlighted)
        
        button.titleLabel?.font = _theme?.buttonTitleFont
        
        
    }
    
    func paintLabel(label:UILabel){
        label.font = _theme?.font
        label.textColor = _theme?.labelColor
    }
    
    func paintTF(tf:UITextField){
        tf.font = _theme?.font
        tf.textColor = _theme?.mainColor
        tf.backgroundColor = _theme?.tfBackgroundColor
    }
    
    func paintBodyLabel(label:UILabel){
        
    }
    
    func paintTitleLabel(title:UILabel){
        
    }
    
    func paintNavigationBar(navBar:UINavigationBar){
        navBar.tintColor = _theme?.mainColor
        //navBar.items
    }
    func painSegmentedController(segmController:UISegmentedControl){
        segmController.tintColor = _theme?.mainColor
        let attr = NSDictionary(object: (_theme?.font)!, forKey: NSFontAttributeName)
        UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject] , forState: .Normal)
    }
    func paintSwitch(switchControl:UISwitch){
        switchControl.tintColor = _theme?.mainColor
        switchControl.onTintColor = _theme?.mainColor
    }
    func paintPickerView(picker:UIPickerView){
        var currentView:UIView?
        var label:UILabel = UILabel()
        for i in 0..<picker.numberOfRowsInComponent(0){
            currentView = picker.viewForRow(i, forComponent: 0)
            guard let realView = currentView else {
                continue
            }
            label = realView as! UILabel
            label.font = _theme?.font
            label.textColor = _theme?.mainColor
            picker.viewForRow(i, forComponent: 0)
        }
        picker.reloadComponent(0)
    }
    
    func paintTableCell(cell:UITableViewCell){
        self.paint(cell)
    }
    func paintNavBar(navBar:UINavigationBar){
        navBar.barTintColor = _theme?.mainColor
        let attr = NSMutableDictionary()
        attr.setObject((_theme?.titleFont)!, forKey: NSFontAttributeName)
        navBar.titleTextAttributes = attr as? [String : AnyObject]
        navBar.tintColor = UIColor.whiteColor()
        navBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    func viewAnalyser(view:UIView){
        let views:[UIView] = view.subviews
        for view in views{
            print(view.classForCoder)
            if view.tag == -1 {
                continue
            }
            if view.classForCoder == UIButton.classForCoder(){
                self.paintButton(view as! UIButton)
            }
            else if view.classForCoder == UILabel.classForCoder(){
                self.paintLabel(view as! UILabel)
            }
            else if view.classForCoder == UITextField.classForCoder(){
                self.paintTF(view as! UITextField)
            }
            else if view.classForCoder == UITextView.classForCoder(){
                
            }
            else if view.classForCoder == UIImage.classForCoder(){
                
            }
            else if view.classForCoder == UINavigationBar.classForCoder(){
                self.paintNavBar(view as! UINavigationBar)
            }
            else if view.classForCoder == UISegmentedControl.classForCoder(){
                self.painSegmentedController(view as! UISegmentedControl)
            }
            else if view.classForCoder == UISwitch.classForCoder(){
                self.paintSwitch(view as! UISwitch)
            }
            else if view.classForCoder == UIPickerView.classForCoder(){
                self.paintPickerView(view as! UIPickerView)
            }
        }
    }
    
    func printAllFonts(){
        for family: String in UIFont.familyNames()
        {
            print("\(family)")
            for names: String in UIFont.fontNamesForFamilyName(family)
            {
                print("== \(names)")
            }
        }
    }
    
    
}
