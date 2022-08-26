//
//  DetailController.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/08/26.
//

import UIKit

class DetailController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var restTextField : UITextField!
    @IBOutlet weak var repsTextField : UITextField!
    @IBOutlet weak var setsTextField : UITextField!
    @IBOutlet weak var nameTextField : UITextField!
    
    var update  = false
    var exercise: Exercise!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
}
