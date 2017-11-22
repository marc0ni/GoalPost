//
//  GoalsVC.swift
//  GoalPost
//
//  Created by Mark Lindamood on 10/26/17.
//  Copyright © 2017 udemy. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var undoBtn: UIButton!
    @IBOutlet weak var undoStack: UIStackView!
    
    var goals: [Goal] = []
    var deletedGoalIndex: Int32?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        undoStack.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    func fetchCoreDataObjects() {
        self.fetch{ (complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                    print("goals.count = \(goals.count)")
                } else {
                    tableView.isHidden = true
                    print("no goals yet")
                }
            }
        }
    }

    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return }
        presentDetail(createGoalVC)
    }
    
    @IBAction func undoBtnWasPressed(_ sender: UIButton) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.undoManager?.undo()
        fetchCoreDataObjects()
        tableView.reloadData()
        undoStack.isHidden = true
    }
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.undoStack.isHidden = false
            self.undoBtn.isEnabled = true
        }
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
        
        if goals[indexPath.row].goalCompletionValue == goals[indexPath.row].goalProgress {
            return [deleteAction]
        } else {
            return [deleteAction, addAction]
        }
    }
}

extension GoalsVC {
    func setProgress(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let chosenGoal = goals[indexPath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("Successfully set progress!")
        } catch {
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
    }
    
    /*func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        deletedGoalIndex = Int32(indexPath.row)
        managedContext.undoManager = UndoManager()
        managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
            self.undoStack.isHidden = false
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
    }*/
    
    private func removeGoal(atIndexPath indexPath: IndexPath) {
        undoManager?.registerUndo(withTarget: self, selector: Selector(("fetch")), object: "indexPath")
        undoManager?.setActionName("delete")
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
            self.undoStack.isHidden = false
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
        
    }
    
    /*private func insertGoal(atIndexPath indexPath: IndexPath){
        undoManager?.registerUndo(withTarget: self, selector: Selector(("removeGoal")), object: "indexPath")
        undoManager?.setActionName("insert")
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.insert(goals[indexPath.row])
        
        do {
            try managedContext.save()
            self.undoStack.isHidden = false
        } catch {
            debugPrint("Could not restore: \(error.localizedDescription)")
        }
    }*/
    
    func fetch(completion:(_ complete: Bool) -> ()) {
        undoManager?.registerUndo(withTarget: self, selector: Selector(("removeGoal")), object: "indexPath")
        undoManager?.setActionName("insert")
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest) 
            print("Successfully fetched data.")
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
}
