//
//  GoalCell.swift
//  GoalPost
//
//  Created by Mark Lindamood on 10/26/17.
//  Copyright © 2017 udemy. All rights reserved.
//

import UIKit
import CoreData

class GoalCell: UITableViewCell {
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTermLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    @IBOutlet weak var completionView: UIView!
    
    var goalIndex: Int32?
    var lastIndex: Int32?
    
    func configureCell(goal: Goal) {
        self.goalDescriptionLbl.text = goal.goalDescription
        self.goalTermLbl.text = goal.goalType
        self.goalProgressLbl.text = String(describing: goal.goalProgress)
        self.goalIndex = goal.goalIndex 
       
        if lastIndex == nil {
            lastIndex = 0
        } else {
            lastIndex = goalIndex
        }
        
        if goal.goalProgress == goal.goalCompletionValue {
            self.completionView.isHidden = false
        } else {
            self.completionView.isHidden = true
        }
    }
}

