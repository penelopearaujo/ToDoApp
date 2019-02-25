//
//  CompleteTodoViewController.swift
//  doit
//
//  Created by Penélope Araújo on 20/02/19.
//  Copyright © 2019 doit. All rights reserved.
//

import UIKit

class CompleteTodoViewController: UIViewController {
    
    var previousVC = TodoTableViewController()
    var selectedTodo: TaskCoreData?
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBAction func completeTapped(_ sender: Any) {
        
        if let createdContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let taskToDelete = selectedTodo {
                createdContext.delete(taskToDelete)
                navigationController?.popViewController(animated: true)
            }
        }
        
        //        var indexOfTaskToRemove = 0
        //        for task in previousVC.toDos {
        //            if task.name == selectedTodo.name {
        //                previousVC.toDos.remove(at: indexOfTaskToRemove)
        //                previousVC.tableView.reloadData()
        //                navigationController?.popViewController(animated: true)
        //                break
        //            }
        //            indexOfTaskToRemove = indexOfTaskToRemove + 1
        //        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTitleLabel.text = selectedTodo?.name
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
