//
//  GoalCell.swift
//  GoalPost
//
//  Created by Mark Lindamood on 10/26/17.
//  Copyright © 2017 udemy. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTermLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    
    func configureCell(description: String, type: GoalType, goalProgessAmt: Int) {
        self.goalDescriptionLbl.text = description
        self.goalTermLbl.text = type.rawValue
        self.goalProgressLbl.text = String(describing: goalProgessAmt)
    }
}

