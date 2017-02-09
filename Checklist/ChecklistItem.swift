//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Paul Tader on 12/4/16.
//  Copyright © 2016 CircleTee. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
  var text = ""
  var checked = false
  var dueDate = Date()
  var shouldRemind = false
  var itemID: Int

  func toggleChecked() {
    checked = !checked
  }
  
  override init() {
    super.init()
  }
  // It's init? because there may not be enough info to decode an object.
  required init?(coder aDecoder: NSCoder){
    text = aDecoder.decodeObject(forKey: "Text") as! String
    checked = aDecoder.decodeBool(forKey: "Checked")
    dueDate = aDecoder.decodeObject(forKey: "DueDate") as! Date
    shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind")
    itemID = aDecoder.decodeInteger(forKey: "ItemID")
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(text, forKey: "Text")
    aCoder.encode(checked, forKey: "Checked")
    aCoder.encode(dueDate, forKey: "DueDate")
    aCoder.encode(shouldRemind, forKey: "ShouldRemind")
    aCoder.encode(itemID, forKey: "ItemID")
  }

}


