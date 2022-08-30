//
//  ViewController.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/08/26.
//

import UIKit

class ExerciseController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Initializers
    var exercise      : Exercise!
    var exerciseArray = [Exercise]()
    let context       = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var update        = false
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        exerciseArray = ExerciseCoreDataManager.functions.fetchItem()!
        self.tableView.reloadData()
    }
    
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailController
        if segue.identifier == "UpdateExercise" {
            vc.exercise = exerciseArray[(exerciseArray.count-1) - ((tableView.indexPathForSelectedRow)!.row)]
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func addExerciseTapped(_ sender: Any) {
        var textField  = UITextField()
        var textField1 = UITextField()
        var textField2 = UITextField()
        var textField3 = UITextField()
        
        let alert = UIAlertController(title: "Add New Exercise", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newExercise  = Exercise(context: self.context)
            newExercise.name = textField.text!
            newExercise.sets = Int16(textField1.text!)!
            newExercise.reps = Int16(textField2.text!)!
            newExercise.rest = Int16(textField3.text!)!
            
            self.exerciseArray.append(newExercise)
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField             = field
            textField.placeholder = "Exercise name"
            textField.font        = UIFont(name: "Avenir", size: 19)
        }
        
        alert.addTextField { (field) in
            textField1              = field
            textField1.placeholder  = "Sets"
            textField1.keyboardType = .numberPad
            textField1.font         = UIFont(name: "Avenir", size: 19)
        }
        
        alert.addTextField { (field) in
            textField2              = field
            textField2.placeholder  = "Reps"
            textField2.keyboardType = .numberPad
            textField2.font         = UIFont(name: "Avenir", size: 19)
        }
        
        alert.addTextField { (field) in
            textField3              = field
            textField3.placeholder  = "Rest (seconds)"
            textField3.keyboardType = .numberPad
            textField3.font         = UIFont(name: "Avenir", size: 19)
        }
        present(alert, animated: true, completion: nil)
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
            ExerciseCoreDataManager.functions.deleteItem(exerciseObject: exerciseArray[arrayIndexReverse])
            exerciseArray = ExerciseCoreDataManager.functions.fetchItem()!
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
}

