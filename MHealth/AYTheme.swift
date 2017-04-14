//
//  Theme.swift
//  ThemeLoader
//
//  Created by Ahmed on 9/20/16.
//  Copyright © 2016 ITI. All rights reserved.
//

import UIKit

class AYTheme: NSObject {
    
    
    var mainColor:UIColor?
    var secondaryColor:UIColor?
    var extraColor:UIColor?
    var tfBackgroundColor:UIColor?
    var viewColor:UIColor?
    var labelColor:UIColor?
    
    var titleFont:UIFont?
    var font:UIFont?
    
    var buttonTitleNormalColor:UIColor?
    var buttonTitleClickedColor:UIColor?
    
    var backgroundbuttonColor:UIColor?
    
    var buttonNormalColor:UIColor?
    var buttonClickedColor:UIColor?
    
    var buttonTitleFont:UIFont?
    
    static func loadThemeFromFile(fileName:String)->AYTheme{
        let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "plist")!
        let themeValues:NSDictionary? = NSDictionary(contentsOfFile: filePath)
        let newTheme = AYTheme()
        if let values = themeValues{
            
            let mainColorHexValue = values.objectForKey("mainColor") as! String
            newTheme.mainColor = newTheme.colorHex(mainColorHexValue)
            
            let seconderyColorHextValue = values.objectForKey("secondaryColor") as! String
            newTheme.secondaryColor = newTheme.colorHex(seconderyColorHextValue)
            
            
            let extraColorHexValue = values.objectForKey("extraColor") as! String
            newTheme.extraColor = newTheme.colorHex(extraColorHexValue)
            
            let tfBackgroundColorHexValue = values.objectForKey("tfBackgroundColor") as! String
            newTheme.tfBackgroundColor = newTheme.colorHex(tfBackgroundColorHexValue)
            
            let viewColorHexValue = values.objectForKey("viewColor") as! String
            newTheme.viewColor = newTheme.colorHex(viewColorHexValue)
            
            let labelColorHexValue = values.objectForKey("labelColor") as! String
            newTheme.labelColor = newTheme.colorHex(labelColorHexValue)
            
            let titleFontName = values.objectForKey("titleFontName") as! String
            let titleFontSize = (values.objectForKey("titleFontSize") as! NSString).integerValue
            newTheme.titleFont = UIFont(name: titleFontName, size: CGFloat(titleFontSize))
            
            let fontName = values.objectForKey("fontName") as! String
            let fontSize = (values.objectForKey("fontSize") as! NSString).integerValue
            newTheme.font = UIFont(name: fontName, size: CGFloat(fontSize))
        
            
            newTheme.buttonNormalColor = newTheme.secondaryColor
            newTheme.buttonClickedColor = newTheme.mainColor
            newTheme.buttonTitleFont = newTheme.font
            
            newTheme.backgroundbuttonColor = newTheme.mainColor
            
            
            return newTheme
        }
        else {
            return detafultTheme()
        }
        
    }
    
    static func detafultTheme()->AYTheme{
        let defaultTheme:AYTheme = AYTheme()
        defaultTheme.mainColor = UIColor.orangeColor()
        defaultTheme.secondaryColor = UIColor.whiteColor()
        defaultTheme.extraColor = UIColor.whiteColor()
        defaultTheme.viewColor = UIColor.lightGrayColor()
        defaultTheme.tfBackgroundColor = UIColor.darkGrayColor()
        defaultTheme.labelColor = UIColor.whiteColor()
        
        defaultTheme.font = UIFont(name: "Noteworthy Bold", size: 12)
        defaultTheme.titleFont = UIFont(name: "Noteworthy Bold", size: 20)
        
        
        defaultTheme.buttonNormalColor = defaultTheme.secondaryColor
        defaultTheme.buttonClickedColor = defaultTheme.mainColor
        defaultTheme.buttonTitleFont = defaultTheme.font
        
        defaultTheme.backgroundbuttonColor = defaultTheme.mainColor
        
        return defaultTheme
    }
    
    static func mainTheme()->AYTheme{
        let defaultTheme:AYTheme = AYTheme()
        defaultTheme.mainColor = defaultTheme.colorHex("EE8500")
        defaultTheme.secondaryColor = defaultTheme.colorHex("5856d6")
        defaultTheme.extraColor = defaultTheme.colorHex("FFFFFF")
        defaultTheme.viewColor = UIColor.lightGrayColor()
        defaultTheme.tfBackgroundColor = UIColor.darkGrayColor()
        defaultTheme.labelColor = UIColor.whiteColor()
        
        defaultTheme.font = UIFont(name: "Noteworthy", size: 20)
        defaultTheme.titleFont = UIFont(name: "Noteworthy-Bold", size: 30)
        
        defaultTheme.buttonNormalColor = defaultTheme.secondaryColor
        defaultTheme.buttonClickedColor = defaultTheme.mainColor
        defaultTheme.buttonTitleFont = defaultTheme.font
        
        defaultTheme.backgroundbuttonColor = defaultTheme.mainColor
        
        return defaultTheme
    }
    
    
    func colorHex(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: NSScanner = NSScanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersInString: "#")
        // Scan hex value
        scanner.scanHexInt(&hexInt)
        return hexInt
    }
    
    
}
