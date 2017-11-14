//
//  UndoStatus.swift
//  GoalPost
//
//  Created by Mark Lindamood on 11/14/17.
//  Copyright © 2017 udemy. All rights reserved.
//

import Foundation

enum UndoStatus: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
