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
    var history:[[Goal]] = []
    
    init(_ initialValue: [Goal]){
        self.initialValue = initialValue
    }
    
    var currentValue: [Goal] {
        get { return history.last ?? initialValue }
        set { history.append(newValue) }
    }
    
    mutating func undo() {
        history.popLast()
    }
}
