//
//  Checklist.swift
//  Checklist
//
//  Created by Paul Tader on 12/28/16.
//  Copyright © 2016 CircleTee. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {
  var name = ""
  var items = [ChecklistItem]()
  var iconName: String
  
  required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "Name") as! String
    items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
    iconName = aDecoder.decodeObject(forKey: "IconName") as! String
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "Name")
    aCoder.encode(items, forKey: "Items")
    aCoder.encode(iconName, forKey: "IconName")
  }
  
  init(name: String) {
    self.name = name
    iconName = "No Icon"
    super.init()
  }
  
  func countUncheckedItems() -> Int {
    var count = 0
    for item in items where !item.checked {
      count += 1
    }
    return count
  }
}
