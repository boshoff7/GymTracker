//
//  DetailController.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/08/26.
//

import UIKit
import CoreData

class DetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
        
    
    // MARK: - Initializers
    var update           = false
    var exercise         : Exercise!
    var setsArray        = [WSR]()
    let context          = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedExercise : Exercise? {
        didSet {
            loadWSR()
        }
    }

    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate   = self
        tableView.dataSource = self
        self.hideKeyboardWhenTappedAround()
//        addDoneButton(textField1: nameTextField, textField2: setsTextField, textField3: repsTextField, textField4: restTextField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WSRCell", for: indexPath) as! WSRCell
        cell.setLabel.text = "Set \(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trash = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
//            self!.context.delete(self!.exerciseArray[indexPath.row])
            self!.setsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
          
        }
        trash.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [trash])
        
        return configuration
    }
    
    
    // MARK: - IBActions

    @IBAction func addSetPressed(_ sender: Any) {
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
    }
    
    @IBAction func deleteRowButton(_ sender: Any) {
   
    }
    
    
    // MARK: - Core Data
    func saveWSR() {
        do {
            try context.save()
        } catch {
        }
    }
    
    func loadWSR(with request: NSFetchRequest<WSR> = WSR.fetchRequest(), predicate: NSPredicate? = nil) {
        let sessionPredicate = NSPredicate(format: "wsrCategory.name MATCHES %@", selectedExercise!.name!)
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [sessionPredicate, additionalPredicate])
        } else {
            request.predicate = sessionPredicate
        }
        do {
            setsArray = try context.fetch(request)
        } catch {
            
        }
    }
}


//        if nameTextField.text! != "" && setsTextField.text! != "" && repsTextField.text! != "" && restTextField.text! != "" {
//            if update == true {
//                ExerciseCoreDataManager.functions.updateItem(name: nameTextField.text!, sets: setsTextField.text!, reps: repsTextField.text!, rest: restTextField.text!, exerciseObject: exercise)
//            } else {
//                ExerciseCoreDataManager.functions.createItem(name: nameTextField.text!, sets: setsTextField.text!, reps: repsTextField.text!, rest: restTextField.text!)
//            }
//            self.navigationController?.popViewController(animated: true)
//        }
//        dismiss(animated: true)
