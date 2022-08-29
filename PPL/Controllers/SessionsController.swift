//
//  SessionsController.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/08/29.
//

import UIKit

class SessionsController: UIViewController {

    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    
    // MARK: - IBActions
    @IBAction func addSessionTapped(_ sender: Any) {
    }
}


// MARK: - TableView Delegate and Datasource Methods
extension SessionsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionsCell", for: indexPath) as! SessionsCell
        return cell
    }
}
