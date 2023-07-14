//
//  CategoriesTableViewController.swift
//  To Do List App
//
//  Created by Mohamed Elkomey on 08/07/2023.
//

import UIKit
import RealmSwift

class CategoriesTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories:Results<Category>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Category List"
        
        categories = realm.objects(Category.self)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func addCategoryPressed(_ sender: Any) {
        print("add category pressed")
        showAlert()
    }
    
    func showAlert(){
        var textField = UITextField()
        
        let alert =  UIAlertController(title: "Add Category", message: nil, preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add Category"
            textField = alertTextField
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            print("category added")
            //self.categories.append(newCategory)
            //print(self.categories)
            try! self.realm.write {
                self.realm.add(newCategory)
            }
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        cell.textLabel?.text = categories[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        performSegue(withIdentifier: "goToItemsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow!
        let itemsVC = segue.destination as! ItemsTableViewController
        let selectedCategory = categories[indexPath.row]
        itemsVC.category = selectedCategory
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //this will performed automatically when press delete
        let swipedCategory = categories[indexPath.row]
        
        try! realm.write{
            realm.delete(swipedCategory)
        }
        tableView.reloadData()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
