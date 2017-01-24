//
//  Checklist.swift
//  Checklist
//
//  Created by Paul Tader on 12/28/16.
//  Copyright © 2016 CircleTee. All rights reserved.
//

import UIKit

class Checklist: NSObject {
  var name = ""
  var items = [ChecklistItem]()
  
  init(name: String) {
    self.name = name
    super.init()
  }
}
