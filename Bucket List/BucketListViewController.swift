//
//  ViewController.swift
//  Bucket List
//
//  Created by Mac on 08/05/1443 AH.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController , AddItemTableViewControllerDelegate {
   
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var items = [MyListItems]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllItems()
    }
    
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "EditItemSeque", sender: sender)
    }
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].name
        
        return cell
    }
    
    func fetchAllItems(){
        
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyListItems")
        do {
            let results = try managedObjectContext.fetch(itemRequest)
            items = results as! [MyListItems]
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // performSegue(withIdentifier: "EditItemSeque", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSeque", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        
        do {
            try managedObjectContext.save()
           
        }catch{
            print(error.localizedDescription)
        }
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        
        if sender is UIBarButtonItem {
            
            let navigationController = segue.destination as! UINavigationController
            let addItemTableController = navigationController.topViewController as! AddItemTableViewController
            addItemTableController.delegate = self
            
        } else if sender is IndexPath  {
           
            let navigationController = segue.destination as! UINavigationController
            let addItemTableController = navigationController.topViewController as! AddItemTableViewController
            addItemTableController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row].name
            addItemTableController.itemEdit = item
            addItemTableController.indexPath = indexPath
            
        }
        
        
    }
    
    func cancleButtonPressed(by controller: AddItemTableViewController) {
       dismiss(animated: true, completion: nil)
    }
    
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
    

        if let editIndexPath = indexPath {
            
           let item = items[editIndexPath.row]
           item.name = text
            
        } else {
            
            let thing = NSEntityDescription.insertNewObject(forEntityName: "MyListItems", into: managedObjectContext) as! MyListItems
            thing.name = text
            items.append(thing)
            
        }
        
        if managedObjectContext.hasChanges{
            do {
                try managedObjectContext.save()
               
            }catch{
                print(error.localizedDescription)
            }
        }
    
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

    
}

