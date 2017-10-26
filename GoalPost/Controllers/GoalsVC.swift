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
    
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        tableView.reloadData()
    }
    
    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return }
        print("goals.count = \(goals.count)")
        presentDetail(createGoalVC)
    }
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of Rows = \(goals.count)")
        return goals.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
        if (tableView.dequeueReusableCell(withIdentifier: "goalCell") != nil) {
            print("dequeued goalCell")
        } else {
            print("returned UITableViewCell")
        }
        let goal = goals[indexPath.row]
        cell.configureCell(description: goal.goalDescription!, type: GoalType(rawValue: goal.goalType!)!, goalProgessAmt: Int(goal.goalProgress))
        print("cell returned")
        return cell
    }
}

extension GoalsVC {
    func fetch(completion:(_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest) as! [Goal]
            print("Successfully fetched data.")
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
}
