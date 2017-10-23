//
//  MoodSelectionViewController.swift
//  MMH
//
//  Created by Alex Aslett on 8/31/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class MoodSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var moodState: String = MoodController.moodState.H.rawValue
    
    @IBOutlet weak var happyButton: UIButton!
    @IBOutlet weak var neutralButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var tableViewCells: UITableView!
    @IBOutlet weak var moodNameTextField: UITextField!
    var mood: Mood?
    
    @IBOutlet weak var moodTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            moodTable.backgroundColor = UIColor.specialGray
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        happyButton.setImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        happyButton.setImage(#imageLiteral(resourceName: "Happy"), for: .selected)
        neutralButton.setImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        neutralButton.setImage(#imageLiteral(resourceName: "Neutral"), for: .selected)
        sadButton.setImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        sadButton.setImage(#imageLiteral(resourceName: "Sad"), for: .selected)
        moodNameTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        moodNameTextField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func happyButtonTapped(_ sender: UIButton) {
        if sadButton.isSelected || neutralButton.isSelected {
            happyButton.isSelected = true
            sadButton.isSelected = false
            neutralButton.isSelected = false
            moodState = MoodController.moodState.H.rawValue
        } else {
            happyButton.isSelected = true
        }
    }
    @IBAction func neutralButtonTapped(_ sender: UIButton) {
        if sadButton.isSelected || happyButton.isSelected {
            happyButton.isSelected = false
            sadButton.isSelected = false
            neutralButton.isSelected = true
            moodState = MoodController.moodState.N.rawValue
        } else {
            neutralButton.isSelected = true
        }
    }
    
    @IBAction func sadButtonTapped(_ sender: UIButton) {
        if happyButton.isSelected || neutralButton.isSelected {
            happyButton.isSelected = false
            sadButton.isSelected = true
            neutralButton.isSelected = false
            moodState = MoodController.moodState.S.rawValue
        } else {
            sadButton.isSelected = true
        }
    }
    
    
    

    
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let moodName = moodNameTextField.text,
            moodName != "" else { return }
        mood = Mood(moodName: moodName, moodState: self.moodState)
        self.performSegue(withIdentifier: "backToDayView", sender: self)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
       if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoodController.shared.moods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moodCell", for: indexPath)
        let mood = MoodController.shared.moods[indexPath.row]
        cell.textLabel?.text = mood.moodName
        cell.detailTextLabel?.text = mood.moodState
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mood = MoodController.shared.moods[indexPath.row]
        self.performSegue(withIdentifier: "backToDayView", sender: self)
    }

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToDayView" {
            guard let controller = segue.destination as? DaySummaryTableViewController else { return }
            guard let sendMood = mood else { return }
            controller.mood = sendMood
        }
    }


}
