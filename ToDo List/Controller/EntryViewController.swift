//
//  EntryViewController.swift
//  ToDo List
//
//  Created by Mohamed Hadwa on 28/02/2023.
//

import UIKit

class EntryViewController: UIViewController {

    
    // MARK: - IBOutlets.
    
    @IBOutlet weak var entryTextView: UITextView!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    // MARK: - Private Variables.
    var update : (()->Void)?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        entryTextView.delegate = self
        
        saveBtn.layer.cornerRadius = 10
        entryTextView.layer.borderColor  = UIColor.lightGray.cgColor
        entryTextView.layer.borderWidth = 1
        entryTextView.layer.cornerRadius = 15
        
   
        
    }
    // MARK: - IBActions.
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        saveTasks()
    }
    
    
    // MARK: - Private Functions.
 @objc   func saveTasks() {
     guard let text = entryTextView.text , !text.isEmpty else{return}
     
     guard let count = UserDefaults().value(forKey: "count") as? Int else{return}
      let newCount = count + 1
     UserDefaults().set(newCount, forKey: "count")
     UserDefaults().set(text, forKey: "task_\(newCount)")
     update?()
     navigationController?.popViewController(animated: true)
 
    }

    
}

// MARK: - EntryViewController Delegate & DataSource.

extension EntryViewController : UITextFieldDelegate ,UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       // saveTasks()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    
}

