//
//  MedicationController.swift
//  MMH
//
//  Created by Alex Aslett on 8/29/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
import CoreData

class MedicationController {
    
    static let shared = MedicationController()
    
    let fetchedResultsController: NSFetchedResultsController<Medication>
    
    init() {
        let request: NSFetchRequest<Medication> = Medication.fetchRequest()
        let currentSortDescriptor = NSSortDescriptor(key: "isCurrent", ascending: true)
        let nameSortDescriptor = NSSortDescriptor(key: "medName", ascending: true)
        request.sortDescriptors = [currentSortDescriptor, nameSortDescriptor]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isCurrent", cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Unable to perform fetch request \(error.localizedDescription)")
        }
    }
    
    
    //C
    func addMed(medName: String, dosage: String, isCurrent: Bool, startDate: Date?, endDate: Date?, notes: String){
        let _ = Medication(medName: medName, dosage: dosage, isCurrent: isCurrent, startDate: startDate, endDate: endDate, notes: notes)
        saveTopersistentStore()
        
    }
    
    
    
    
    //R
    
    
    
    
    //U
    //FIXME: Need to add support for the dates changing as well
    func update(medication: Medication, newName: String, newDosage: String, newNotes: String, newIsCurrent: Bool){
        medication.medName = newName
        medication.dosage = newDosage
        medication.notes = newNotes
        medication.isCurrent = newIsCurrent
        saveTopersistentStore()
    }
    
    
    
    //D
    func remove(medication: Medication){
        medication.managedObjectContext?.delete(medication)
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
