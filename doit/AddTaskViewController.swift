//
//  AddTaskViewController.swift
//  doit
//
//  Created by Penélope Araújo on 20/02/19.
//  Copyright © 2019 doit. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    //reference to the previous vc
    var previousVC = TodoTableViewController()

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var importantSwitch: UISwitch!
    
    @IBAction func addTapped(_ sender: Any) {
        /*
        let newToDo = Todo()
        
        newToDo.name = taskTextField.text!
        newToDo.isImportant = importantSwitch.isOn
        
        previousVC.toDos.append(newToDo)
        previousVC.tableView.reloadData()
        
        // go back to previous view controller
        navigationController?.popViewController(animated: true)
        */
        
        
        if let createdContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let newTask = TaskCoreData(context: createdContext)
            
            if let taskText = taskTextField.text {
                newTask.name = taskText
                newTask.isImportant = importantSwitch.isOn
            }
            
            try? createdContext.save() //saves the data to coredata
            navigationController?.popViewController(animated: true)

        }


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
