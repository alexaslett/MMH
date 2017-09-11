//
//  Day+Convenience.swift
//  MMH
//
//  Created by Alex Aslett on 8/29/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
import CoreData

extension Day {
    
    convenience init(dayDate: Date = Date(), hrSlept: Double, minExercised: Int64, moodName: String, moodState: String, medsTaken: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.dayDate = dayDate as NSDate
        self.hrSlept = hrSlept
        self.minExercised = minExercised
        self.moodName = moodName
        self.moodState = moodState
        self.medsTaken = medsTaken
    }
    
    
}
