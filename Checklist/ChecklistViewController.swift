//
//  ViewController.swift
//  Checklist
//
//  Created by Paul Tader on 11/29/16.
//  Copyright © 2016 CircleTee. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
  var row0text = "Walk the dog"
  var row1text = "Brush teeth"
  var row2text = "Learn iOS development"
  var row3text = "Guitar practice"
  var row4text = "Learn Swift"
  
  var row0checked = false
  var row1checked = false
  var row2checked = false
  var row3checked = false
  var row4checked = false
  

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
    print("Running tableView(numberOfRowsInSection)")
    return 5
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("Running tableView(cellForRowAtIndex) for row: \(indexPath.row)")
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
      
  let label = cell.viewWithTag(1000) as! UILabel
    
  if indexPath.row == 0 {
    label.text = row0text
  } else if indexPath.row == 1 {
    label.text = row1text
  } else if indexPath.row == 2 {
    label.text = row2text
  } else if indexPath.row == 3 {
    label.text = row3text
  } else if indexPath.row == 4 {
    label.text = row4text
  }
    
  return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      
      var isChecked = false
      
      // Reverse the checkmark accessory...
      if indexPath.row == 0 {
        row0checked = !row0checked
        isChecked = row0checked
      } else if indexPath.row == 1 {
        row1checked = !row1checked
        isChecked = row1checked
      } else if indexPath.row == 2 {
        row2checked = !row2checked
        isChecked = row2checked
      } else if indexPath.row == 3 {
        row3checked = !row3checked
        isChecked = row3checked
      } else if indexPath.row == 4 {
        row4checked = !row4checked
        isChecked = row4checked
      }
      
      // ...and now set the accessory in the view
      if isChecked {
        cell.accessoryType = .checkmark
      } else {
        cell.accessoryType = .none
      }
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  
}
