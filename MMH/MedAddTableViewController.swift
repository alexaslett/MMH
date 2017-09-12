//
//  MedAddTableViewController.swift
//  MMH
//
//  Created by Alex Aslett on 9/12/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class MedAddTableViewController: UITableViewController {
    
    @IBOutlet var startDatePicker: UIDatePicker!
    
    @IBOutlet var endDatePicker: UIDatePicker!
    
    @IBOutlet weak var medNameTextField: UITextField!
    @IBOutlet weak var dosageTextField: UITextField!
    @IBOutlet weak var isCurrentSwitch: UISwitch!
    @IBOutlet weak var startDateField: UITextField!
    @IBOutlet weak var endDateField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    
    var medName: String?
    
    var medication: Medication?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if medication == nil {
            guard let medName = medName else { return }
            medNameTextField.text = medName
        } else {
            guard let medication = medication else { return }
            medNameTextField.text = medication.medName
            dosageTextField.text = medication.dosage
            isCurrentSwitch.isOn = medication.isCurrent
            startDateField.text = medication.startDate?.stringValue()
            endDateField.text = medication.endDate?.stringValue()
            notesTextField.text = medication.notes
        }
        
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background_1.jpg")!)
        
        startDatePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date
        
        startDateField.inputView = startDatePicker
        endDateField.inputView = endDatePicker
        
        
    }
    
    @IBAction func startDatePickerChanged(_ sender: Any) {
        startDateField.text = startDatePicker.date.stringValue()
        
    }
    
    @IBAction func endDatePickerChanged(_ sender: Any) {
        endDateField.text = endDatePicker.date.stringValue()
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if medication == nil {
            guard let medName1 = medNameTextField.text, medName1 != "", let dosage = dosageTextField.text, dosage != "", let notes = notesTextField.text else { return }
            MedicationController.shared.addMed(medName: medName1, dosage: dosage, isCurrent: isCurrentSwitch.isOn, startDate: startDatePicker.date, endDate: endDatePicker.date, notes: notes)
        } else {
            guard let medication = medication, let medName1 = medNameTextField.text, medName1 != "", let dosage = dosageTextField.text, dosage != "", let notes = notesTextField.text else { return }
            MedicationController.shared.update(medication: medication, newName: medName1, newDosage: dosage, newNotes: notes, newIsCurrent: isCurrentSwitch.isOn, newStartDate: startDatePicker.date, newEndDate: endDatePicker.date)
        }
        self.poptoSpecificVC(viewController: MedListTableViewController.self)
    }
    
    func poptoSpecificVC(viewController : Swift.AnyClass){
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController.isKind(of: viewController) {
                self.navigationController!.popToViewController(aViewController, animated: true)
                break;
            }
        }
    }
    
    
}
