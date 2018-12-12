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
    
    
    

}
