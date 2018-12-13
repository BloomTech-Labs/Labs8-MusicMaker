//
//  TeacherTableViewCell.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 12/12/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import Charts

class TeacherTableViewCell: UITableViewCell {

    @IBOutlet weak var assignmentsPieChart: PieChartView! {
        didSet {
            assignmentsPieChart.isUserInteractionEnabled = false
        }
    }
    
    var teacher: Teacher?
    
    
    var pieChartDataEntry = [PieChartDataEntry]() {
        didSet {
            if pieChartDataEntry.count > 0 {
                if let teacher = teacher {
                    let chartDataSet = PieChartDataSet(values: pieChartDataEntry, label: nil)
                    chartDataSet.colors = [UIColor.blue1, UIColor.blue2, UIColor.blue3, UIColor.blue4, UIColor.blue5]
                    chartDataSet.sliceSpace = 2.0
                    let chartData = PieChartData(dataSet: chartDataSet)
                    assignmentsPieChart.data = chartData
                    let formatter = NumberFormatter()
                    formatter.minimumFractionDigits = 0
                    formatter.zeroSymbol = ""
                    assignmentsPieChart.data?.setValueFormatter(DefaultValueFormatter(formatter: formatter))
                    let myAttribute = [NSAttributedString.Key.font: UIFont(name: "Merriweather", size: 20.0)!, NSMutableAttributedString.Key.foregroundColor: UIColor.blue1]
                    let myAttrString = NSAttributedString(string: teacher.name ?? "N/A", attributes: myAttribute)
                    assignmentsPieChart.centerAttributedText = myAttrString
                    assignmentsPieChart.animate(yAxisDuration: 1.0)
                    assignmentsPieChart.drawEntryLabelsEnabled = false
                    assignmentsPieChart.legend.font = UIFont(name: "Roboto", size: 20)!
                    assignmentsPieChart.legend.horizontalAlignment = .center
                    assignmentsPieChart.legend.form = .circle
                    assignmentsPieChart.legend.formSize = 12
                    assignmentsPieChart.legend.textColor = UIColor.blue1
                }
            }
        }
    }
}
