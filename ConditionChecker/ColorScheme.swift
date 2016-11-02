//
//  ColorScheme.swift
//  ConditionChecker
//
//  Created by Braden Gray on 10/30/16.
//  Copyright © 2016 Graycode. All rights reserved.
//

import UIKit

class ColorScheme {
    class func blueColor()->UIColor {
        return UIColor.init(colorLiteralRed: 0.19, green: 0.56, blue: 0.7, alpha: 1.0)
    }
    
    class func redColor()->UIColor {
        return UIColor.init(colorLiteralRed: 0.91, green: 0.29, blue: 0.19, alpha: 1.0)
    }
    
    class func purpleColor()->UIColor {
        return UIColor.init(colorLiteralRed: 0.70, green: 0.26, blue: 1.0, alpha: 1.0)
    }
    
    class func greenColor()->UIColor {
        return UIColor.init(colorLiteralRed: 0.29, green: 0.91, blue: 0.24, alpha: 1.0)
    }
    
    class func navyColor()->UIColor {
        return UIColor.init(colorLiteralRed: 0.09, green: 0.18, blue: 0.48, alpha: 1.0)
    }
    
    class func grayColor()->UIColor {
        return UIColor.init(colorLiteralRed: 0.71, green: 0.71, blue: 0.71, alpha: 1.0)
    }
}
