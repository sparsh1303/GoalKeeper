//
//  GoalCell.swift
//  Application
//
//  Created by Himanshu Joshi on 26/05/19.
//  Copyright © 2019 Himanshu Joshi. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    
    func configureCell(goal: Goal) {
        self.goalDescriptionLbl.text = goal.goalDescription
        self.goalTypeLbl.text = goal.goalType
    }
    
}
