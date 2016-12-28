//
//  AllListsViewController.swift
//  Checklist
//
//  Created by Paul Tader on 12/28/16.
//  Copyright © 2016 CircleTee. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = makeCell(for: tableView)
      cell.textLabel!.text = "List \(indexPath.row)"
      return cell
    }
  
  // Separate the cell generation code away from tabelView(cellForRowAt). Keeps it simple cleaner.
  func makeCell(for tableView: UITableView) -> UITableViewCell {
    let cellIdentifier = "Cell"
    if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
      return cell
    } else {
      return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
    }
  }
  

}
