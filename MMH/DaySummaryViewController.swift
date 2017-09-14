//
//  DaySummaryViewController.swift
//  MMH
//
//  Created by Alex Aslett on 8/28/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class DaySummaryViewController: UIViewController {
    
    var mood: Mood?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "background_1.jpg")!)
        
        scrollView.keyboardDismissMode = .onDrag
        
        updateMood()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        dateLabel.text = Date().stringValue()
        
        saveButton.layer.cornerRadius = 15.0
        saveButton.backgroundColor = UIColor(red: 0/255, green: 173/255, blue: 225/255, alpha: 1)
        
        exerciseTextField.keyboardType = .numberPad
        sleepTextField.keyboardType = .decimalPad
        
        NotificationCenter.default.addObserver(self, selector: #selector(DaySummaryViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DaySummaryViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
   
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.scrollView.frame.origin.y == 0{
                self.scrollView.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.scrollView.frame.origin.y != 0{
                self.scrollView.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateMood()
        dateLabel.text = Date().stringValue()
    }


    
    func updateMood(){
        if mood != nil {
            guard let mood = mood else { return }
            moodLabel.text = mood.moodName
        }
    }
    
    
    var sleepTimeTextField = UITextField()
    var wakeTimeTextField = UITextField()
    
    @IBOutlet weak var moodLabel: UILabel!
    
    @IBOutlet weak var sleepTextField: UITextField!
    @IBOutlet weak var exerciseTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var medsTakenSwitch: UISwitch!
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let mood = mood, let tempSleep = sleepTextField.text, let tempMinExercised = exerciseTextField.text, let sleep = Double(tempSleep), let minExcercised = Int64(tempMinExercised) else { return }
        DayController.shared.addDay(dayDate: Date(), moodName: mood.moodName, moodState: mood.moodState, hrSlept: sleep, minExercised: minExcercised, medsTaken: medsTakenSwitch.isOn)
        moodLabel.text = "-Mood-" //FIXME: This isn't working, because of the updateMood Function
        sleepTextField.text = ""
        exerciseTextField.text = ""
        medsTakenSwitch.isOn = false
        
        let daySummeryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DayListTableViewController")
        self.navigationController?.pushViewController(daySummeryVC, animated: true)
        
    }
    
    func compareDateHours() -> Double {
        guard let sleep = sleepTime, let wake = wakeTime else { return 0.0 }
        let secondBetween = Double(wake.timeIntervalSince(sleep))
        let secondsInHour = 3600.0
        let hours = secondBetween / secondsInHour
        return Double(round(100*hours)/100)
    }
    
    
    @IBAction func sleepButtonTapped(_ sender: Any) {
        presentSleepCalc()
    }
    
    var sleepTime: Date?
    var wakeTime: Date?
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var datePicker2: UIDatePicker!
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        sleepTimeTextField.text = datePicker.date.stringValue()
        sleepTime = datePicker.date
    }
    @IBAction func datePicker2ValueChanged(_ sender: Any) {
        wakeTimeTextField.text = datePicker2.date.stringValue()
        wakeTime = datePicker2.date
    }
    
    
    func presentSleepCalc() {
        let alertController = UIAlertController(title: "Calculate Sleep", message: "What time did you go to bed and wake up?", preferredStyle: .alert)
        
        
        // datePicker.datePickerMode = time
        datePicker.minuteInterval = 15
        datePicker2.minuteInterval = 15
        //        let dateFormatter1 = DateFormatter()
        //        dateFormatter1.dateFormat = "HH:mm"
        //
        //        if let date = dateFormatter1.date(from: "07:00") {
        //            datePicker.date = date
        //        }
        //
        //
        //
        //        let datePickerSleep = UIDatePicker()
        //        datePickerSleep.datePickerMode = .time
        //        datePickerSleep.minuteInterval = 15
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "HH:mm"
        //
        //        if let date = dateFormatter.date(from: "22:00") {
        //            datePickerSleep.date = date
        //        }
        
        
        
        alertController.addTextField { (sleepTime) in
            sleepTime.inputView = self.datePicker
            sleepTime.placeholder = "When you went to Sleep.."
            self.sleepTimeTextField = sleepTime
            
        }
        alertController.addTextField { (wakeTime) in
            wakeTime.inputView = self.datePicker2
            wakeTime.placeholder = "When you woke up.."
            self.wakeTimeTextField = wakeTime
        }
        
        let okButton = UIAlertAction(title: "OK", style: .default) { (_) in
            self.sleepTextField.text = "\(self.compareDateHours())"
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okButton)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func UnwindToDayVC(segue:UIStoryboardSegue) {
        updateMood()
    }
    
    
    
}
