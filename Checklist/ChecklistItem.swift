//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Paul Tader on 12/4/16.
//  Copyright © 2016 CircleTee. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
  var text = ""
  var checked = false

  func toggleChecked() {
    checked = !checked
  }

}


