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
  
  required init?(coder aDecoder: NSCoder){
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(text, forKey: "Text")
    aCoder.encode(checked, forKey: "Checked")
  }

}


