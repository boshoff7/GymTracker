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
    
    
    // MARK: - Segue
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationVC = segue.destination as! DetailController
//        if let indexPath  = tableView.indexPathForSelectedRow {
//            destinationVC.selectedExercise = exerciseArray[indexPath.row]
//        }
//    }
    
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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trash = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            self!.context.delete(self!.exerciseArray[indexPath.row])
            self!.exerciseArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            CoreDataManager.functions.saveExercise()
        }
        trash.backgroundColor = .systemRed
        
        let edit = UIContextualAction(style: .normal,
                                      title: "Edit") { [weak self] (action, view, completionHandler) in
            var titleTextField = UITextField()
            var setsTextField  = UITextField()
            var repsTextField  = UITextField()
            var restTextField  = UITextField()
            
            let alert  = UIAlertController(title: "Edit Exercise", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Update Exercise", style: .default) { action in
                let newExercise            = Exercise(context: self!.context)
                newExercise.name           = titleTextField.text!
                newExercise.sets           = Int16(setsTextField.text!)!
                newExercise.reps           = Int16(repsTextField.text!)!
                newExercise.rest           = Int16(restTextField.text!)!
                newExercise.parentCategory = self!.selectedSession
                self!.exerciseArray[indexPath.row] = newExercise
                CoreDataManager.functions.saveExercise()
                DispatchQueue.main.async {
                    self!.tableView.reloadData()
                }
            }
            
            alert.addTextField { alertTextField in
                alertTextField.placeholder  = "Exercise"
                titleTextField              = alertTextField
                titleTextField.font         = UIFont(name: "Avenir", size: 19)
            }
            
            alert.addTextField { alertTextField in
                alertTextField.placeholder  = "Sets"
                setsTextField               = alertTextField
                setsTextField.font          = UIFont(name: "Avenir", size: 19)
                setsTextField.keyboardType  = .numberPad
            }
            
            alert.addTextField { alertTextField in
                alertTextField.placeholder  = "Reps"
                repsTextField               = alertTextField
                repsTextField.font          = UIFont(name: "Avenir", size: 19)
                repsTextField.keyboardType  = .numberPad
            }
            
            alert.addTextField { alertTextField in
                alertTextField.placeholder  = "Rest (Seconds)"
                restTextField               = alertTextField
                restTextField.font          = UIFont(name: "Avenir", size: 19)
                restTextField.keyboardType  = .numberPad
            }
            alert.addAction(action)
            self!.present(alert, animated: true)
        }
        edit.backgroundColor = UIColor(red:0.05, green:0.14, blue:0.37, alpha:1.0)
        
        let configuration = UISwipeActionsConfiguration(actions: [trash, edit])
        
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
            alertTextField.placeholder  = "Exercise"
            titleTextField              = alertTextField
            titleTextField.font         = UIFont(name: "Avenir", size: 19)
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder  = "Sets"
            setsTextField               = alertTextField
            setsTextField.font          = UIFont(name: "Avenir", size: 19)
            setsTextField.keyboardType  = .numberPad
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder  = "Reps"
            repsTextField               = alertTextField
            repsTextField.font          = UIFont(name: "Avenir", size: 19)
            repsTextField.keyboardType  = .numberPad
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder  = "Rest (Seconds)"
            restTextField               = alertTextField
            restTextField.font          = UIFont(name: "Avenir", size: 19)
            restTextField.keyboardType  = .numberPad
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
