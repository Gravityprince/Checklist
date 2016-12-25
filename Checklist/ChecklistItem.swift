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
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(text, forKey: "Text")
    aCoder.encode(checked, forKey: "Checked")
  }

}


