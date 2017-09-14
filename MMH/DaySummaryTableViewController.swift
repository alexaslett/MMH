//
//  DaySummaryTableViewController.swift
//  MMH
//
//  Created by Alex Aslett on 9/14/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class DaySummaryTableViewController: UITableViewController {
    
    var mood: Mood?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background_1.jpg")!)

        updateMood()
        
        dateLabel.text = Date().stringValue()
        
        saveButton.layer.cornerRadius = 15.0
        saveButton.backgroundColor = UIColor(red: 0/255, green: 173/255, blue: 225/255, alpha: 1)
        
        exerciseTextField.keyboardType = .numberPad
        sleepTextField.keyboardType = .decimalPad
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateMood()
        dateLabel.text = Date().stringValue()
    }

    var sleepTime: Date?
    var wakeTime: Date?
    var sleepTimeTextField = UITextField()
    var wakeTimeTextField = UITextField()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var sleepTextField: UITextField!
    @IBOutlet weak var exerciseTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var medsTakenSwitch: UISwitch!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var datePicker2: UIDatePicker!
    
    
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
    
    
    @IBAction func sleepCalcButtonTapped(_ sender: Any) {
        presentSleepCalc()
    }
    @IBAction func datePickerValueChanged(_ sender: Any) {
        sleepTimeTextField.text = datePicker.date.stringValue()
        sleepTime = datePicker.date
    }
    @IBAction func datePicker2ValueChanged(_ sender: Any) {
        wakeTimeTextField.text = datePicker2.date.stringValue()
        wakeTime = datePicker2.date
    }
    
    
    func compareDateHours() -> Double {
        guard let sleep = sleepTime, let wake = wakeTime else { return 0.0 }
        let secondBetween = Double(wake.timeIntervalSince(sleep))
        let secondsInHour = 3600.0
        let hours = secondBetween / secondsInHour
        return Double(round(100*hours)/100)
    }

    func updateMood(){
        if mood != nil {
            guard let mood = mood else { return }
            moodLabel.text = mood.moodName
        }
    }
    
    func presentSleepCalc() {
        let alertController = UIAlertController(title: "Calculate Sleep", message: "What time did you go to bed and wake up?", preferredStyle: .alert)
        
        datePicker.minuteInterval = 15
        datePicker2.minuteInterval = 15
        
        
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

    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
