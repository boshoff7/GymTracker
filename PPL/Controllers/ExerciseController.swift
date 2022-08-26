//
//  ViewController.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/08/26.
//

import UIKit

class ExerciseController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Initializers
    var exerciseArray = [Exercise]()
    
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailController
        if segue.identifier == "UpdateExercise" {
            vc.update   = true
            vc.exercise = exerciseArray[(exerciseArray.count-1) - ((tableView.indexPathForSelectedRow)!.row)]
        }
    }
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        exerciseArray = CoreDataManager.functions.fetchItem()!
        self.tableView.reloadData()
    }
}

// MARK: - TableView Delegate and Datasource Methods

extension ExerciseController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let arrayIndexReverse = (exerciseArray.count - 1) - indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
        cell.layer.cornerRadius = 10
        cell.nameLabel.text = exerciseArray[arrayIndexReverse].name
        cell.setsLabel.text = String(exerciseArray[arrayIndexReverse].sets)
        cell.repsLabel.text = String(exerciseArray[arrayIndexReverse].reps)
        cell.restLabel.text = String(exerciseArray[arrayIndexReverse].rest)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let arrayIndexReverse = (exerciseArray.count - 1) - indexPath.section
            CoreDataManager.functions.deleteItem(exerciseObject: exerciseArray[arrayIndexReverse])
            exerciseArray = CoreDataManager.functions.fetchItem()!
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
}

