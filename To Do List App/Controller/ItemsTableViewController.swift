//
//  ItemsTableViewController.swift
//  To Do List App
//
//  Created by Mohamed Elkomey on 08/07/2023.
//

import UIKit
import RealmSwift

class ItemsTableViewController: UITableViewController {
    
    var category:Category?{
        didSet{
            print(category?.name)
            items = category?.items.sorted(byKeyPath: "name")
        }
    }

    let realm = try! Realm()
    
    //var items = [Item]()
    var items:Results<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print path of db
        print(Realm.Configuration.defaultConfiguration.fileURL)
        title = category?.name
    }

    func showAlert(){
        var textField = UITextField()
        
        let alert =  UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add Item"
            textField = alertTextField
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            print("item added")
            let item = Item()
            item.name = textField.text!
            //self.items.append(item)
            //print(self.items)
            try! self.realm.write {
                //self.realm.add(item)
                self.category?.items.append(item)
            }
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func addItemsPressed(_ sender: UIBarButtonItem) {
        showAlert()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //this line reuse a group of cells again with accessories so we need to checkmark bt item itself
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)

        cell.textLabel?.text = items[indexPath.row].name
        if items[indexPath.row].isChecked{
           cell.accessoryType = .checkmark
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = items[indexPath.row]
        try! realm.write{
            item.isChecked = !item.isChecked
        }
        if item.isChecked{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        //items[indexPath.row].isChecked = !items[indexPath.row].isChecked
    }
    
    //to have a delete trailing swipe button
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //this will performed automatically when press delete
        let swipedItem = items[indexPath.row]
        
        try! realm.write{
            realm.delete(swipedItem)
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
