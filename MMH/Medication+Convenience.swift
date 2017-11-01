//
//  Medication+Convenience.swift
//  MMH
//
//  Created by Alex Aslett on 8/29/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
import CoreData

extension Medication {
    
    convenience init(medName: String, dosage: String, isCurrent: Bool, startDate: Date? = nil, endDate: Date? = nil, notes: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.medName = medName
        self.dosage = dosage
        self.isCurrent = isCurrent
        self.startDate = startDate
        self.endDate = endDate
        self.notes = notes
        
    }
    
    
}
