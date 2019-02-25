//
//  TodoTableViewController.swift
//  doit
//
//  Created by Penélope Araújo on 20/02/19.
//  Copyright © 2019 doit. All rights reserved.
//

import UIKit


class TodoTableViewController: UITableViewController {
    
    var toDos: [TaskCoreData] = []
    var editViewController = AddTaskViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTasksFromCoreData()
    }
    
    func getTasksFromCoreData() {
        if let createdContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let coreDataTasks = try? createdContext.fetch(TaskCoreData.fetchRequest()) as? [TaskCoreData]{
                if let unwrappedCoreDataTasks = coreDataTasks {
                    toDos = unwrappedCoreDataTasks
                    // o array exibido na tela é o array extraído do coredata
                    tableView.reloadData() 
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let task = toDos[indexPath.row]
        
        if let taskName = task.name {
            
            if task.isImportant {
                cell.textLabel?.text = "‼️" + taskName
            }
            else {
                cell.textLabel?.text = task.name
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = toDos[indexPath.row]
        performSegue(withIdentifier: "moveToComplete", sender: task)
        
        
    }
    
    // implementa a opcao de deletar a task dando swipe na celula da table view
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            if let createdContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
               
                //delete item at indexPath (from Core Data)
                createdContext.delete(self.toDos[indexPath.row])
                
                // delete item at indexPath (from tableview)
                self.toDos.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        return [delete]
    }
    
    // organiza a referencia do proximo view controller pra conseguir transferir dados
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddTaskViewController {
            addVC.previousVC = self
        }
        if let completeVC = segue.destination as? CompleteTodoViewController {
            
            if let toDoNaoSeiMais = sender as? TaskCoreData {
                completeVC.selectedTodo = toDoNaoSeiMais
                completeVC.previousVC = self
            }
        }
    }
    
}
