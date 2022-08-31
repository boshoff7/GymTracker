//
//  ExerciseTableController.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/08/31.
//

import UIKit
import CoreData

class ExerciseController: UITableViewController {
    
    // MARK: - Initializers
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var exerciseArray   = [Exercise]()
    var selectedSession : Session? {
        didSet {
            loadExercises()
        }
    }

    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table View Delegate and Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
        let item = exerciseArray[indexPath.row]

        cell.nameLabel.text = item.name
        cell.setsLabel.text = String(item.sets)
        cell.repsLabel.text = String(item.reps)
        cell.restLabel.text = String(item.rest)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(exerciseArray[indexPath.row])
            exerciseArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            CoreDataManager.functions.saveExercise()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailController
        if segue.identifier == "UpdateExercise" {
            vc.exercise = exerciseArray[(exerciseArray.count-1) - ((tableView.indexPathForSelectedRow)!.row)]
        }
    }

    
    // MARK: - IBActions
    @IBAction func addExerciseTapped(_ sender: UIBarButtonItem) {
        var titleTextField = UITextField()
        var setsTextField  = UITextField()
        var repsTextField  = UITextField()
        var restTextField  = UITextField()
        
        let alert  = UIAlertController(title: "Add New Exercise", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Exercise", style: .default) { action in
            let newExercise            = Exercise(context: self.context)
            newExercise.name           = titleTextField.text!
            newExercise.sets           = Int16(setsTextField.text!)!
            newExercise.reps           = Int16(repsTextField.text!)!
            newExercise.rest           = Int16(restTextField.text!)!
            newExercise.parentCategory = self.selectedSession
            self.exerciseArray.append(newExercise)
            CoreDataManager.functions.saveExercise()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Exercise"
            titleTextField             = alertTextField
            titleTextField.font        = UIFont(name: "Avenir", size: 19)
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Sets"
            setsTextField              = alertTextField
            setsTextField.font         = UIFont(name: "Avenir", size: 19)
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Reps"
            repsTextField              = alertTextField
            repsTextField.font         = UIFont(name: "Avenir", size: 19)
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Rest (Seconds)"
            restTextField              = alertTextField
            restTextField.font         = UIFont(name: "Avenir", size: 19)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    // MARK: - Core Data
    
    func loadExercises(with request: NSFetchRequest<Exercise> = Exercise.fetchRequest(), predicate: NSPredicate? = nil) {
        let sessionPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedSession!.name!)
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [sessionPredicate, additionalPredicate])
        } else {
            request.predicate = sessionPredicate
        }
        do {
            exerciseArray = try context.fetch(request)
        } catch {
            
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
