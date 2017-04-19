//
//  Langs.swift
//  MHealth
//
//  Created by Abrar Al-Failakawi on 4/19/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class Langs: NSObject {

    static func arabicTitleForString(key:String) ->String{
        let filePath = NSBundle.mainBundle().pathForResource("arabic", ofType: "plist")
        let stringValues = NSDictionary(contentsOfFile: filePath!)
        let value = stringValues?.valueForKey(key) as! String
        return value
    }
}
