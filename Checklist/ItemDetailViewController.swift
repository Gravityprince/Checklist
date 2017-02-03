//
//  ItemDetailViewController.swift
//  Checklist
//
//  Created by Paul Tader on 12/6/16.
//  Copyright © 2016 CircleTee. All rights reserved.
//

import Foundation
import UIKit

// This defines the ItemDetailViewControllerDelegate protocol. Note
// functions with out code.
protocol ItemDetailViewControllerDelegate: class {
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
  
  // The "delegate" variable is set by the calling controller, a ItemDetailViewControllerDelegate
  // and then used throughout the code here. This is the connection back (through the portal)
  weak var delegate: ItemDetailViewControllerDelegate?
  
  // A place to recieve the incoming ChecklistItem to edit.
  var itemToEdit: ChecklistItem?
  
  @IBAction func cancel(){
    delegate?.itemDetailViewControllerDidCancel(self)
  }
  
  @IBAction func done() {
    if let item = itemToEdit {
      item.text = textField.text!
      delegate?.itemDetailViewController(self, didFinishEditing: item)
    } else {
      let item = ChecklistItem()
      item.text = textField.text!
      item.checked = false
      delegate?.itemDetailViewController(self, didFinishAdding: item)
    }

  }
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  
  
  // Delegate send "nil" back when the table view send willSelectRowAt to
  // disable the row selection and the row turning grey.
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPAth: IndexPath) -> IndexPath? {
    return nil
  }
  
  override func viewWillAppear(_ animated: Bool) {
    textField.becomeFirstResponder() // popup the keyboard
    super.viewWillAppear(animated)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let item = itemToEdit {
      title = "Edit Item"  // "title" is a builtin.
      textField.text = item.text
      doneBarButton.isEnabled = true
    }
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
