//
//  UndoTransferDelegate.swift
//  GoalPost
//
//  Created by Mark Lindamood on 11/14/17.
//  Copyright © 2017 udemy. All rights reserved.
//

import Foundation

protocol UndoTransferDelegate {
    func undoStatusDidChange(undoStatus: String)
}
