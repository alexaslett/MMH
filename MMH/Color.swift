//
//  Color.swift
//  MMH
//
//  Created by Alex Aslett on 10/19/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var specialGray: UIColor {
        return UIColor(hex: "E9E9E9")
    }
    
    
    
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: 1)
    }
}
