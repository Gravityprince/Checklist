//
//  DataModel.swift
//  Checklist
//
//  Created by Paul Tader on 1/26/17.
//  Copyright © 2017 CircleTee. All rights reserved.
//

import Foundation

class DataModel {
  var lists = [Checklist]()
  
  init() {
    loadChecklists()
    registerDefaults()
  }
  
  // After a fresh install, UserDefaults will be 0 because it can't find a value.
  // That will crash the app. Lets setup a default value.
  func registerDefaults() {
    let dictionary: [String: Any] = ["ChecklistIndex": -1 ]
    UserDefaults.standard.register(defaults: dictionary)
  }
  
  var indexOfSelectedChecklist: Int {
    get {
      return UserDefaults.standard.integer(forKey: "ChecklistIndex")
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
    }
  }
  
  func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    print("-- The Document directory is \(paths)")
    return paths[0]
  }
  
  func dataFilePath() -> URL {
    return documentsDirectory().appendingPathComponent("Checklists.plist")
  }
  
  func loadChecklists() {
    let path = dataFilePath()
    print("-- The Checklist array has \(lists.count) items.")
    if let data = try? Data(contentsOf: path) {
      let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
      lists = unarchiver.decodeObject(forKey: "Checklists") as! [Checklist]
      unarchiver.finishDecoding()
      print("-- Read \(lists.count) items from storage and added them to the lists array.")
    }
  }
  
  func saveChecklists() {
    print("-- DataModel is saving the Checklists")
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWith: data)
    archiver.encode(lists, forKey: "Checklists")
    archiver.finishEncoding()
    data.write(to: dataFilePath(), atomically: true)
  }

}
