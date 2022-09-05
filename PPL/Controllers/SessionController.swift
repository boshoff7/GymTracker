//
//  SessionTableController.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/08/31.
//

import UIKit
import CoreData

class SessionController: UITableViewController {
    
    // MARK: - Initializers
    var session = [Session]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSessions()
    }
    
    // MARK: - Table View Delegate and Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return session.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath) as! SessionsCell
        cell.sessionNameLabel.text = "Day \(String(indexPath.row + 1)) - \(session[indexPath.row].name!)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToExercises", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(session[indexPath.row])
            session.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveSession()
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            self!.context.delete(self!.session[indexPath.row])
            self!.session.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            self!.saveSession()
        }
        delete.backgroundColor = .systemRed
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completionHandler) in
            var titleTextField = UITextField()
            
            let alert  = UIAlertController(title: "Edit Session", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Update Session", style: .default) { action in
                let newExercise              = Exercise(context: self!.context)
                newExercise.name             = titleTextField.text!
                let newSession               = Session(context: self!.context)
                newSession.name              = titleTextField.text!
                self!.session[indexPath.row] = newSession
                self!.saveSession()
                DispatchQueue.main.async {
                    self!.tableView.reloadData()
                }
            }
            
            alert.addTextField { alertTextField in
                alertTextField.placeholder  = "Session Name"
                titleTextField              = alertTextField
                titleTextField.font         = UIFont(name: "Avenir", size: 19)
            }
            
            alert.addAction(action)
            self!.present(alert, animated: true)
        }
        edit.backgroundColor = UIColor(red:0.05, green:0.14, blue:0.37, alpha:1.0)
        
        let configuration = UISwipeActionsConfiguration(actions: [delete, edit])
        
        return configuration
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ExerciseController
        if let indexPath  = tableView.indexPathForSelectedRow {
            destinationVC.selectedSession = session[indexPath.row]
        }
    }
    
    // MARK: - Core Data
    func saveSession() {
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadSessions() {
        
        let request : NSFetchRequest<Session> = Session.fetchRequest()
        do{
            session = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func addSessionTapped(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert     = UIAlertController(title: "Add New Session", message: "", preferredStyle: .alert)
        let action    = UIAlertAction(title: "Add", style: .default) { (action) in
            if textField.text != "" {
                let newSession  = Session(context: self.context)
                newSession.name = textField.text!
                self.session.append(newSession)
                self.saveSession()
            } else {
                let alert  = UIAlertController(title: "No Text", message: "Please make sure you add a title for the new session", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .cancel)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField             = field
            textField.placeholder = "Add a new session"
            textField.font        = UIFont(name: "Avenir", size: 19)
        }
        present(alert, animated: true, completion: nil)
    }
}
