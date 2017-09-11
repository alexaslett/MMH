//
//  DateHelpers.swift
//  MMH
//
//  Created by Alex Aslett on 8/30/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation

extension NSDate {
    
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
//        formatter.timeStyle = .short
        
        return formatter.string(from: self as Date)
    }
    
}

extension Date {
    
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
//        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
    
}
