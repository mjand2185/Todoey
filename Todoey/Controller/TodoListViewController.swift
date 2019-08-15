//
//  ViewController.swift
//  Todoey
//
//  Created by Marc Anderson on 30/07/2019.
//  Copyright © 2019 Marc Anderson. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let defaults = UserDefaults.standard

    var itemArray = [Item]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
            let newItem = Item()
            newItem.title = "fine mike"
            itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "buy Chocolate"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "destroy Demogorgon"
        itemArray.append(newItem3)
            

        if let items = defaults.array(forKey: "TodoListArray") as? [Item ] {
            itemArray = items
        }
    }

    //MARK - TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
    
    
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
//       if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//
//        }else {
//        itemArray[indexPath.row].done = false
//        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        

    
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController.init(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: "Add New Item", style: .default) { (action) in
            //What will happen when the user clicks the add item button on oour UIAlert
        
            let newItem = Item()
            newItem.title = textField.text!
            
        self.itemArray.append(newItem)
            
        self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
        self.tableView.reloadData()
            
    
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


