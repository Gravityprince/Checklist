//
//  ViewController.swift
//  Checklist
//
//  Created by Paul Tader on 11/29/16.
//  Copyright © 2016 CircleTee. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
  
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
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.text
  
  configureCheckmark(for: cell, at: indexPath)
  return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      let item = items[indexPath.row]
      item.checked = !item.checked
      configureCheckmark(for: cell, at: indexPath)
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
  
  func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) {
    let item = items[indexPath.row]
    
    if item.checked {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
    
  }
  
}
