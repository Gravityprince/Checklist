//
//  ListDetailViewController.swift
//  Checklist
//
//  Created by Paul Tader on 1/5/17.
//  Copyright © 2017 CircleTee. All rights reserved.
//

import UIKit

// This defines the ListDetailViewControllerDelegate protocol.

protocol ListDetailViewControllerDelegate: class {
  func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
  func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding item: Checklist)
  func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing item: Checklist)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  
  weak var delegate: ListDetailViewControllerDelegate?
  var checklistToEdit: Checklist?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let checklist = checklistToEdit {
      title = "Edit Checklist"  // "title" is a builtin.
      textField.text = checklist.name
      doneBarButton.isEnabled = true
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder() // popup the keyboard
  }
  
  @IBAction func cancel(){
    delegate?.listDetailViewControllerDidCancel(self)
  }
  
  @IBAction func done() {
    if let checklist = checklistToEdit {
      checklist.name = textField.text!
      delegate?.listDetailViewController(self, didFinishEditing: checklist)
    } else {
      let checklist = Checklist(name: textField.text!)
      delegate?.listDetailViewController(self, didFinishAdding: checklist)
    }
    
  }
  
  // Make sure the user cannot select the table cell with the text field
  override func tableView(_ tableView: UITableView, willSelectRowAt index: IndexPath) -> IndexPath? {
    return nil
  }
  
  // text field delegate method that enables/disables the Done button
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


