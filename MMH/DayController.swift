//
//  DayController.swift
//  MMH
//
//  Created by Alex Aslett on 8/29/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
import CoreData

class DayController {
    
    static let shared = DayController()
    
    var days: [Day] {
        let request: NSFetchRequest<Day> = Day.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    /*
    let fetchedResultsController: NSFetchedResultsController<Day> = {
        let request: NSFetchRequest<Day> = Day.fetchRequest()
        let dateSortDescriptor = NSSortDescriptor(key: "dayDate", ascending: true)
        request.sortDescriptors = [dateSortDescriptor]
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    init() {
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Unable to perform fetch request \(error.localizedDescription)")
        }
    } */
    
    
    //C
    
    func addDay(dayDate: Date, moodName: String, moodState: String, hrSlept: Double, minExercised: Int64) {
        let _ = Day(dayDate: dayDate, hrSlept: hrSlept, minExercised: minExercised, moodName: moodName, moodState: moodState)
        saveTopersistentStore()
    }
    
    
    
    
    //R
    
    
    
    
    //U
    
    
    
    
    //D
    func deleteDay(day: Day){
        day.managedObjectContext?.delete(day)
        saveTopersistentStore()
    }
    
    
    
    func saveTopersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error Saving to CoreData")
        }
    }
    
    
    
}
