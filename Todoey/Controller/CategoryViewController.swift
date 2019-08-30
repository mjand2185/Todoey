//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Marc Anderson on 21/08/2019.
//  Copyright © 2019 Marc Anderson. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
loadCategory()
        
    }
    //MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    
    //MARK - Data Manipulation Methods
    
    func saveCategories(){
    
//    let encoder = PropertyListEncoder()
    do {
    try context.save()
    } catch {
    print("error saving category \(error)")
    
    }
    self.tableView.reloadData()
    
}
    
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error Loading Categories \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    
    //MARK - Add new categories
  
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController.init(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Add New Category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)

            self.saveCategories()
            
    }
    
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

    
        }

