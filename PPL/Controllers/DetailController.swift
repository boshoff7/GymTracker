//
//  DetailController.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/08/26.
//

import UIKit

class DetailController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var restTextField : UITextField!
    @IBOutlet weak var repsTextField : UITextField!
    @IBOutlet weak var setsTextField : UITextField!
    @IBOutlet weak var nameTextField : UITextField!
    
    
    // MARK: - Initializers
    var update  = false
    var exercise: Exercise!
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addDoneButton(textField1: nameTextField, textField2: setsTextField, textField3: repsTextField, textField4: restTextField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if update == true {
            nameTextField.text = exercise.name
            setsTextField.text = String(exercise.sets)
            repsTextField.text = String(exercise.reps)
            restTextField.text = String(exercise.rest)
            self.title = "Edit"
        } else {
            self.title = "Add new"
        }
    }

    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if nameTextField.text! != "" && setsTextField.text! != "" && repsTextField.text! != "" && restTextField.text! != "" {
            if update == true {
                CoreDataManager.functions.updateItem(name: nameTextField.text!, sets: setsTextField.text!, reps: repsTextField.text!, rest: restTextField.text!, exerciseObject: exercise)
            } else {
                CoreDataManager.functions.createItem(name: nameTextField.text!, sets: setsTextField.text!, reps: repsTextField.text!, rest: restTextField.text!)
            }
            self.navigationController?.popViewController(animated: true)
        }
        dismiss(animated: true)
    }
}
