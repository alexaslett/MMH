//
//  ProviderController.swift
//  MMH
//
//  Created by Alex Aslett on 8/29/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
import CoreData


class ProviderController {
    
    static let shared = ProviderController()
    
    let fetchedResultsController1: NSFetchedResultsController<Provider>
    
    init() {
        let request2: NSFetchRequest<Provider> = Provider.fetchRequest()
        let currentSortDescriptor = NSSortDescriptor(key: "isCurrent", ascending: true)
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request2.sortDescriptors = [currentSortDescriptor, nameSortDescriptor]
        fetchedResultsController1 = NSFetchedResultsController(fetchRequest: request2, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isCurrent", cacheName: nil)
        
        do {
            try fetchedResultsController1.performFetch()

        } catch let error as NSError {
            print("Unable to perform fetch request \(error.localizedDescription)")
        }
    }
    
    
    //C
    func addProvider(name: String, isCurrent: Bool, address: String, state: String, zipCode: String, phone: String, notes: String){
        let _ = Provider(name: name, address: address, state: state, zipCode: zipCode, phone: phone, isCurrent: isCurrent, notes: notes)
        saveTopersistentStore1()
    }
    
    
    
    //R
    
    
    
    
    //U
    func updateProvider(provider: Provider, newName: String, newIsCurrent: Bool, newAddress: String, newState: String, newZipCode: String, newPhone: String, newNotes: String){
        provider.name = newName
        provider.isCurrent = newIsCurrent
        provider.address = newAddress
        provider.state = newState
        provider.zipCode = newZipCode
        provider.phone = newPhone
        provider.notes = newNotes
        saveTopersistentStore1()
    }
    
    
    
    
    //D
    func remove(provider: Provider){
        provider.managedObjectContext?.delete(provider)
        saveTopersistentStore1()
    }
    
    
    
    func saveTopersistentStore1() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error Saving to CoreData")
        }
    }
    
    
    
}
