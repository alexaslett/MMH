//
//  MedAddViewController.swift
//  MMH
//
//  Created by Alex Aslett on 8/29/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class MedAddViewController: UIViewController {
    
    var medication: Medication?
    
    @IBOutlet weak var medNameTextField: UITextField!
    @IBOutlet weak var dosageTextField: UITextField!
    @IBOutlet weak var isCurrentSwitch: UISwitch!
    @IBOutlet weak var startDateField: UITextField!
    @IBOutlet weak var endDateField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    
    var medName: String?
    
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
            notesTextField.text = medication.notes
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(MedAddViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MedAddViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        if medication == nil {
            guard let medName1 = medNameTextField.text, medName1 != "", let dosage = dosageTextField.text, dosage != "", let notes = notesTextField.text else { return }
            MedicationController.shared.addMed(medName: medName1, dosage: dosage, isCurrent: isCurrentSwitch.isOn, startDate: nil, endDate: nil, notes: notes)
        } else {
            guard let medication = medication, let medName1 = medNameTextField.text, medName1 != "", let dosage = dosageTextField.text, dosage != "", let notes = notesTextField.text else { return }
            MedicationController.shared.update(medication: medication, newName: medName1, newDosage: dosage, newNotes: notes, newIsCurrent: isCurrentSwitch.isOn )
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

