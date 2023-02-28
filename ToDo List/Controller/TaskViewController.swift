//
//  TaskViewController.swift
//  ToDo List
//
//  Created by Mohamed Hadwa on 28/02/2023.
//

import UIKit

class TaskViewController: UIViewController {

   
    // MARK: - IBOutlets.
    @IBOutlet weak var taskLabel : UILabel!
    
    // MARK: - Private Variables.
    var task :String?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        taskLabel.text = task
        
    }
    // MARK: - IBActions.
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        deleteTask()
    }
    
    // MARK: - Private Functions.
    func deleteTask (){
        
    }
    
    
    
}

// MARK: - <#UI.....#> Delegate & DataSource.

//extension <#UIviewController#> {
//    
//    
//}






