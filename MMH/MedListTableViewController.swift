//
//  MedListTableViewController.swift
//  MMH
//
//  Created by Alex Aslett on 8/29/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import CoreData

class MedListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        MedicationController.shared.fetchedResultsController.delegate = self
        tableView.backgroundColor = UIColor.specialGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

  

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = MedicationController.shared.fetchedResultsController.sections else { return 0 }
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = MedicationController.shared.fetchedResultsController.sections else { return 0 }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "medCell", for: indexPath)
        let med = MedicationController.shared.fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = med.medName
        cell.backgroundColor = .clear
        return cell
    }
 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = MedicationController.shared.fetchedResultsController.sections, let index = Int(sectionInfo[section].name) else { return nil }
        if index == 0 {
            return "Prior Meds"
        } else {
            return "Current Meds"
        }
    }
   


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let medication = MedicationController.shared.fetchedResultsController.object(at: indexPath)
            MedicationController.shared.remove(medication: medication)
            tableView.reloadData()
    //FIXME: Doing this for now to get around the deleting in sections issue
        }
    }
   

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditMeds" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? MedAddTableViewController else { return }
            let medication = MedicationController.shared.fetchedResultsController.object(at: indexPath)
            destinationVC.medication = medication
        }
    }
    

}

extension MedListTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update, .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    
}
