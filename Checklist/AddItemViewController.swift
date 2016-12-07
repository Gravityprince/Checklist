//
//  AddItemViewController.swift
//  Checklist
//
//  Created by Paul Tader on 12/6/16.
//  Copyright © 2016 CircleTee. All rights reserved.
//

import Foundation
import UIKit

class AddItemViewController: UITableViewController {
  
  @IBAction func cancel(){
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func done() {
    dismiss(animated: true, completion: nil)
  }
  
  // Delegate send "nil" back when the table view send willSelectRowAt to
  // disable the row selection and the row turning grey.
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPAth: IndexPath) -> IndexPath? {
    return nil
  }
  

}
