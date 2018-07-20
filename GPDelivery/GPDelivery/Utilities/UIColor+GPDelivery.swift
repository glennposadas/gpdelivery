//
//  UIColor+GPDelivery.swift
//  GPDelivery
//
//  Created by Glenn Von C. Posadas on 20/07/2018.
//  Copyright © 2018 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

extension UIColor {
    static var darkBlue: UIColor = UIColor.colorWithRGBHex(0x2F4352)
    static var graySubtitle: UIColor = UIColor.colorWithRGBHex(0xB3B3B3)
    
    class func colorWithRGBHex(_ hex: Int, alpha: Float = 1.0) -> UIColor {
        let r = Float((hex >> 16) & 0xFF)
        let g = Float((hex >> 8) & 0xFF)
        let b = Float((hex) & 0xFF)
        
        return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue:CGFloat(b / 255.0), alpha: CGFloat(alpha))
    }
}
