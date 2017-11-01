//
//  Provider+Convenience.swift
//  MMH
//
//  Created by Alex Aslett on 8/29/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
import CoreData

extension Provider {
    
    convenience init(name: String, address: String, state: String, zipCode: String, phone: String, isCurrent: Bool, notes: String, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.name = name
        self.address = address
        self.state = state
        self.zipCode = zipCode
        self.phone = phone
        self.isCurrent = isCurrent
        self.notes = notes
        
    }

}
