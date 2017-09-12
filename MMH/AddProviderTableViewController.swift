//
//  AddProviderTableViewController.swift
//  MMH
//
//  Created by Alex Aslett on 9/11/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class AddProviderTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    @IBOutlet weak var isCurrentSwitch: UISwitch!
    @IBOutlet weak var notesTextField: UITextView!
    
    
    var provider: Provider?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if provider != nil {
            guard let provider = provider else { return }
            nameTextField.text = provider.name
            phoneNumTextField.text = provider.phone
            addressTextField.text = provider.address
            stateTextField.text = provider.state
            zipCodeField.text = provider.zipCode
            isCurrentSwitch.isOn = provider.isCurrent
            notesTextField.text = provider.notes
        }
        
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background_1.jpg")!)
        
        //tableView.keyboardDismissMode = .onDrag
        
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if provider == nil {
            guard let name = nameTextField.text, name != "", let phone = phoneNumTextField.text, let address = addressTextField.text, let state = stateTextField.text, let zipCode = zipCodeField.text, let notes = notesTextField.text else { return }
            ProviderController.shared.addProvider(name: name, isCurrent: isCurrentSwitch.isOn, address: address, state: state, zipCode: zipCode, phone: phone, notes: notes)
        } else {
            guard let provider = provider, let name = nameTextField.text, name != "", let phone = phoneNumTextField.text, let address = addressTextField.text, let state = stateTextField.text, let zipCode = zipCodeField.text, let notes = notesTextField.text else { return }
            
            ProviderController.shared.updateProvider(provider: provider, newName: name, newIsCurrent: isCurrentSwitch.isOn, newAddress: address, newState: state, newZipCode: zipCode, newPhone: phone, newNotes: notes)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
   
    

    
}
