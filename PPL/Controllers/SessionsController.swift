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
    
    
    // MARK: - Initializers
    var session = [Session]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        session = SessionCoreDataManager.functions.fetchSession()!
        self.tableView.reloadData()
    }
    
    
    // MARK: - IBActions
    @IBAction func addSessionTapped(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert     = UIAlertController(title: "Add New Session", message: "", preferredStyle: .alert)
        let action    = UIAlertAction(title: "Add Session", style: .default) { (action) in
            let newSession  = Session(context: self.context)
            newSession.name = textField.text
            SessionCoreDataManager.functions.createSession(name: newSession.name!)
            self.session.append(newSession)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new session"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}


// MARK: - TableView Delegate and Datasource Methods
extension SessionsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return session.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let arrayIndexReverse = (session.count - 1) - indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionsCell", for: indexPath) as! SessionsCell
        cell.layer.cornerRadius    = 10
        cell.sessionNameLabel.text = session[arrayIndexReverse].name
        cell.dayLabel.text         = String((session.count) - indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let arrayIndexReverse = (session.count - 1) - indexPath.section
            SessionCoreDataManager.functions.deleteSession(sessionObject: session[arrayIndexReverse])
            session = SessionCoreDataManager.functions.fetchSession()!
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
}
