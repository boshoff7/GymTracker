//
//  ViewController.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/08/26.
//

import UIKit

class ExerciseController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var exerciseArray = [Exercise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate   = self
        tableView.dataSource = self
    }

    @IBAction func addExerciseButtonTapped(_ sender: Any) {
    }

}

// MARK: - TableView Delegate and Datasource Methods

extension ExerciseController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
        cell.layer.cornerRadius = 10
        return cell
    }
}

