//
//  IconPickerViewController.swift
//  Checklist
//
//  Created by Paul Tader on 2/6/17.
//  Copyright © 2017 CircleTee. All rights reserved.
//

import UIKit

protocol IconPickerViewControllerDelegate: class {
  func iconPicker(_ picker: IconPickerViewController, didPick iconName: String)
}

  class IconPickerViewController: UITableViewController {
    weak var delegate: IconPickerViewControllerDelegate?
    
    let icons = [
    "No Icon",
    "Appointments",
    "Birthdays",
    "Chores",
    "Drinks",
    "Folder",
    "Groceries",
    "Inbox",
    "Photos",
    "Trips"]
    
    // Because we are a UITableView Controller we have to implement the data
    // source methods.
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
      return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)

      let iconName = icons[indexPath.row]
      cell.textLabel!.text = iconName
      cell.imageView!.image = UIImage(named: iconName)
      
      return cell
  }
    
    // Call the delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if let delegate = delegate {
        let iconName = icons[indexPath.row]
        delegate.iconPicker(self, didPick: iconName)
      }
    }
}

