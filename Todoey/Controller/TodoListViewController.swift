//
//  ViewController.swift
//  Todoey
//
//  Created by Marc Anderson on 30/07/2019.
//  Copyright © 2019 Marc Anderson. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        loadItems()
            
loadItems()
        
    }

    //MARK - TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
}
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let items = itemArray[indexPath.row]
        
        cell.textLabel?.text = items.title
        
        cell.accessoryType = items.done ? .checkmark : .none
        
        
    
    
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        

        saveItems()
        
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
            
        self.saveItems()
            
    
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK - Model Manipulation Methods
    
    func saveItems(){
    
    let encoder = PropertyListEncoder()
    
    do {
    let data = try encoder.encode(itemArray)
    
    try data.write(to: dataFilePath!)
    } catch {
    print("error encoding item array \(error)")
    
    }
    self.tableView.reloadData()
    
}
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("error decoding item array \(error)")
        }
    }


}
}
