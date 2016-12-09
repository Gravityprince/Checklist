//
//  AddItemViewController.swift
//  Checklist
//
//  Created by Paul Tader on 12/6/16.
//  Copyright © 2016 CircleTee. All rights reserved.
//

import Foundation
import UIKit

// This defines the AddItemViewControllerDelegate protocol. Note
// functions with out code.
protocol AddItemViewControllerDelegate: class {
  func addItemViewControllerDidCancel(_ controller: AddItemViewController)
  func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
  weak var delegate: AddItemViewControllerDelegate?

  @IBAction func cancel(){
    delegate?.addItemViewControllerDidCancel(self)
  }
  
  @IBAction func done() {
    let item = ChecklistItem()
    item.text = textField.text!
    item.checked = false
    
    delegate?.addItemViewController(self, didFinishAdding: item)
  }
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  
  
  // Delegate send "nil" back when the table view send willSelectRowAt to
  // disable the row selection and the row turning grey.
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPAth: IndexPath) -> IndexPath? {
    return nil
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    
    // We want to use NSString's replacingCharacters method so we "convert" Swifts
    // String into a NSString.
    let oldText = textField.text! as NSString
    let newText = oldText.replacingCharacters(in: range, with: string) as NSString
    doneBarButton.isEnabled = (newText.length > 0)

    return true
  }

}
