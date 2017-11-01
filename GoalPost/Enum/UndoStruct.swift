//
//  UndoStruct.swift
//  GoalPost
//
//  Created by Mark Lindamood on 11/1/17.
//  Copyright © 2017 udemy. All rights reserved.
//

import Foundation

struct UndoHistory<Goal> {
    let initialValue: [Goal]
    let history:[[Goal]] = []
    
    init(_ initialValue: [Goal]){
        self.initialValue = initialValue
    }
    
    var currentValue: [Goal] {
        return history.last ?? initialValue
    }
}
