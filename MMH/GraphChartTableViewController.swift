//
//  GraphChartTableViewController.swift
//  MMH
//
//  Created by Alex Aslett on 8/30/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import Charts

class GraphChartTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateGraph()
        updateExerciseGraph()
        updateMoodNumbers()
        self.tableView.backgroundColor = UIColor.specialGray
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateGraph()
        updateExerciseGraph()
        updateMoodNumbers()
        
        
    }
    
    @IBOutlet weak var happyNumLabel: UILabel!
    @IBOutlet weak var neutralNumLabel: UILabel!
    @IBOutlet weak var sadNumLabel: UILabel!
    
    
    
    @IBOutlet weak var chtChart: LineChartView!
    @IBOutlet weak var exerciseChart: LineChartView!
    
    
    func updateMoodNumbers(){
        var happyNum = 0
        var neutralNum = 0
        var sadNum = 0

        for i in 0..<DayController.shared.days.count {
            guard let moodtype = DayController.shared.days[i].moodState else { return }
            switch moodtype {
            case "Happy":
                happyNum += 1
            case "Neutral":
                neutralNum += 1
            case "Sad":
                sadNum += 1
            default:
                break
            }

        }
            happyNumLabel.text = "\(happyNum)"
            neutralNumLabel.text = "\(neutralNum)"
            sadNumLabel.text = "\(sadNum)"

    }
    
    
    
    func updateExerciseGraph(){
        var lineChartEntry1 = [ChartDataEntry]()

        for i in 0..<DayController.shared.days.count {
            let value = ChartDataEntry(x: Double(i), y: Double(DayController.shared.days[i].minExercised))
            lineChartEntry1.append(value)
        }
        let line1 = LineChartDataSet(values: lineChartEntry1, label: "Exercise")
        line1.colors = [NSUIColor.blue]
        let data = LineChartData()
        data.addDataSet(line1)

        exerciseChart.data = data
        exerciseChart.chartDescription?.text = "Exercise Chart"
    }
    
    
    
    
    func updateGraph() {
        var lineChartEntry = [ChartDataEntry]()

        for i in 0..<DayController.shared.days.count {
            let value = ChartDataEntry(x: Double(i), y: DayController.shared.days[i].hrSlept)
            lineChartEntry.append(value)
        }
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Sleep")
        line1.colors = [NSUIColor.blue]
        let data = LineChartData()
        data.addDataSet(line1)

        chtChart.data = data
        chtChart.chartDescription?.text = "Hours Slept"
    }
    
    
}
