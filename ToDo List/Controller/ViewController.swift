//
//  ViewController.swift
//  ToDo List
//
//  Created by Mohamed Hadwa on 28/02/2023.
//

import UIKit

class ViewController: UIViewController {


    // MARK: - IBOutlets.
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Variables.
    
    var tasks = [String]()
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "My Tasks"
        tableView.delegate = self
        tableView.dataSource = self
        // MARK: - setup.

        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        // MARK: - get all current saved tasks.
        updateTasks()
    }
    // MARK: - IBActions.
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        let entryVC = storyboard?.instantiateViewController(withIdentifier: "entry") as! EntryViewController
        entryVC.title = "New Task"
    
        entryVC.update = {
            DispatchQueue.main.async {
                self.updateTasks()

            }
             
        }
        navigationController?.pushViewController(entryVC, animated: true)
    }
    
    // MARK: - Private Functions.
    
    func updateTasks(){
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {return}
        
        for x in 0..<count{
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
            
        }
        tableView.reloadData()

    }
}

// MARK: - ViewController Delegate & DataSource.

extension ViewController :UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let taskVc = storyboard?.instantiateViewController(withIdentifier: "task")as! TaskViewController
        taskVc.title = "My Task"
        taskVc.task = tasks[indexPath.row]
           navigationController?.pushViewController(taskVc, animated: true)
    }
    
   
}

extension ViewController :UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        tasks.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") {  action, view, completionHendler in
            self.tasks.remove(at:indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
            self.tableView.reloadData()
            UserDefaults().set(self.tasks, forKey: "setup")
           // UserDefaults().removeObject(forKey: self.tasks[indexPath.row])
            print(self.tasks)
            
            completionHendler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    


}


