//
//  ViewController.swift
//  Checklist
//
//  Created by Paul Tader on 11/29/16.
//  Copyright © 2016 CircleTee. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

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
    return 100
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("Running tableView(cellForRowAtIndex) for row: \(indexPath.row)")
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
  
  let label = cell.viewWithTag(1000) as! UILabel
  
  if indexPath.row % 5 == 0 {
    label.text = "Walk the dog"
  } else if indexPath.row % 5 == 1 {
    label.text = "Brush my teeth"
  } else if indexPath.row % 5 == 2 {
    label.text = "Learn iOS development"
  } else if indexPath.row % 5 == 3 {
    label.text = "Soccor practice"
  } else if indexPath.row % 5 == 4 {
    label.text = "Eat ice cream"
  }
  return cell
  }

}
