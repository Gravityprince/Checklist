//
//  ViewController.swift
//  Checklist
//
//  Created by Paul Tader on 11/29/16.
//  Copyright © 2016 CircleTee. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
  
  var items: [ChecklistItem]
  
  required init?(coder aDecoder: NSCoder){
    items = [ChecklistItem]()
    
    let row0item = ChecklistItem()
    row0item.text = "Walk the Dog"
    row0item.checked = false
    items.append(row0item)
    
    let row1item = ChecklistItem()
    row1item.text = "Brush my teeth"
    row1item.checked = false
    items.append(row1item)

    let row2item = ChecklistItem()
    row2item.text = "Learn iOS development"
    row2item.checked = true
    items.append(row2item)
    
    let row3item = ChecklistItem()
    row3item.text = "Soccer practice"
    row3item.checked = false
    items.append(row3item)
    
    let row4item = ChecklistItem()
    row4item.text = "Eat ice cream"
    row4item.checked = true
    items.append(row4item)
    
    let row5item = ChecklistItem()
    row5item.text = "Learn Swift programming"
    row5item.checked = true
    items.append(row5item)

    
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // The tableView object from the tableViewController (added to the storyboard) calls these functions.
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    let item = items[indexPath.row]
    configureText(for: cell, with: item)
    configureCheckmark(for: cell, with: item)
  return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      let item = items[indexPath.row]
      item.toggleChecked()
      configureCheckmark(for: cell, with: item)
    }
      tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                          forRowAt indexPath: IndexPath){
    items.remove(at: indexPath.row)
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }
  
  func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
    let label = cell.viewWithTag(1001) as! UILabel
    
      if item.checked {
        label.text = "√"
      } else {
        label.text = ""
      }
    }
  
  func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.text
  }
  
  // addItemViewControllerDidCancel protocol methods
  func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
    dismiss(animated: true, completion: nil)
  }
  
  func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem){
    let newRowIndex = items.count
    items.append(item)
    
    //Tell the tableView we have a new row. It must be passed in as
    // an array. So, we make an array with one item.
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    
    dismiss(animated: true, completion: nil)
  }
  
  func addItemViewController(_ controller: AddItemViewController, didFinishEditing item: ChecklistItem){
    if let index = items.index(of: item) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        configureText(for: cell, with: item)
      }
    }
    dismiss(animated: true, completion: nil)
  }
  
  // Gotta tell the View we are going to segue to who we are and that we're the delegate.
  override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    if segue.identifier == "AddItem"{
      let navigationController = segue.destination as! UINavigationController
      let controller = navigationController.topViewController as! AddItemViewController
      controller.delegate = self
    } else if segue.identifier == "EditItem" {
      let navigationController = segue.destination as! UINavigationController
      let controller = navigationController.topViewController as! AddItemViewController
      controller.delegate = self
      
      // We need the row number in oder to send it to the editItem
      if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
        controller.itemToEdit = items[indexPath.row]
      }
    }
  }

  
  
  
}
