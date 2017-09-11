//
//  GraphChartViewController.swift
//  MMH
//
//  Created by Alex Aslett on 8/30/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import Charts

class GraphChartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateGraph()
        updateExerciseGraph()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_1.jpg")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateGraph()
        updateExerciseGraph()
    }


    @IBOutlet weak var chtChart: LineChartView!
    @IBOutlet weak var exerciseChart: LineChartView!
   
    func updateExerciseGraph(){
        var lineChartEntry1 = [ChartDataEntry]()
        
        for i in 0..<DayController.shared.fetchedResultsController.fetchedObjects!.count {
            let value = ChartDataEntry(x: Double(i), y: Double(DayController.shared.fetchedResultsController.fetchedObjects![i].minExercised))
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
        
        for i in 0..<DayController.shared.fetchedResultsController.fetchedObjects!.count {
            let value = ChartDataEntry(x: Double(i), y: DayController.shared.fetchedResultsController.fetchedObjects![i].hrSlept)
            lineChartEntry.append(value)
        }
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Sleep")
        line1.colors = [NSUIColor.blue]
        let data = LineChartData()
        data.addDataSet(line1)
        
        chtChart.data = data
        chtChart.chartDescription?.text = "Hours Slept"
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
