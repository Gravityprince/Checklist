//
//  AllListsViewController.swift
//  Checklist
//
//  Created by Paul Tader on 12/28/16.
//  Copyright © 2016 CircleTee. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController,
      ListDetailViewControllerDelegate, UINavigationControllerDelegate {

  var dataModel: DataModel!
  
  
  override func viewWillAppear(_ animated: Bool){
    super.viewWillAppear(animated)
    print("-- Running AllListViewController(viewWillAppear) to reloadData()")
    // Added to reload the to-do count for each cell
    tableView.reloadData()
  }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  // navigationController(willShow gets called before viewDidAppear
  func navigationController(_ navigationController: UINavigationController,
                            willShow viewController: UIViewController,
                            animated: Bool) {
    // Was the back button tapped?
    print("-- running AllListViewController(willShow),")
    if viewController === self {
      dataModel.indexOfSelectedChecklist = -1
      print("-- ...and setting dataModel.indexOfSelectedChecklist to \(dataModel.indexOfSelectedChecklist)")
    }
  }
  
  override func viewDidAppear(_ animated: Bool){
    super.viewDidAppear(animated)
    // Tell the navigation controller, I'm the delegate
    navigationController?.delegate = self
    
    let index = dataModel.indexOfSelectedChecklist
    if index >= 0 && index < dataModel.lists.count {
      print("-- Looks like we were in a checklist before quiting...")
      let checklist = dataModel.lists[index]
      performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataModel.lists.count
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = makeCell(for: tableView)
      
      let checklist = dataModel.lists[indexPath.row]
      cell.textLabel!.text = checklist.name
      cell.accessoryType = .detailDisclosureButton
      
      let totalItems = checklist.items.count
      let remainingItems = checklist.countUncheckedItems()
      
    if totalItems == 0 {
          cell.detailTextLabel!.text = "(No Items)"
      } else if remainingItems == 0 {
          cell.detailTextLabel!.text = "Done!"
      } else {
          cell.detailTextLabel!.text = "\(checklist.countUncheckedItems()) Remaining"
      }
      return cell
  }

  // Separate the cell generation code away from tabelView(cellForRowAt). Keeps it simple cleaner.
  func makeCell(for tableView: UITableView) -> UITableViewCell {
    let cellIdentifier = "Cell"
    if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
      return cell
    } else {
      return UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
    }
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //sender parameter
    dataModel.indexOfSelectedChecklist = indexPath.row
    print("-- Storing indexPath.row: \(indexPath.row) in UserDefaults")
    let checklist = dataModel.lists[indexPath.row]
    performSegue(withIdentifier: "ShowChecklist", sender: checklist)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("-- Running AllListViewController.prepare:for segue")
    if segue.identifier == "ShowChecklist" {
      let controller = segue.destination as! ChecklistViewController
      controller.checklist = sender as! Checklist
      print("-- Segueing with \(controller.checklist.name)")
    } else if segue.identifier == "AddChecklist" {
      print("-- Adding a new checklist")
      let navigationController = segue.destination as! UINavigationController
      let controller = navigationController.topViewController as! ListDetailViewController
      controller.delegate = self
      controller.checklistToEdit = nil
      
    }
  }
  // ListDetailViewControllerDidCancel protocol methods
  func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
    dismiss(animated: true, completion: nil)
  }
  
  func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist){
    dataModel.lists.append(checklist)
    dataModel.sortChecklists()
    tableView.reloadData()
    dismiss(animated: true, completion: nil)
  }
  
  func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist){
    dataModel.sortChecklists()
    tableView.reloadData()
    dismiss(animated: true, completion: nil)
  }
  
  // Instead of a segue, we load the view controller by hand from the Storyboard.
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    print("--Running tableView:accessoryButtonTappedForRowWith")
    let navigationController = storyboard!.instantiateViewController(withIdentifier: "ListDetailNavigationController") as! UINavigationController
    let controller = navigationController.topViewController as! ListDetailViewController
    controller.delegate = self
    let checklist = dataModel.lists[indexPath.row]
    controller.checklistToEdit = checklist
    present(navigationController, animated: true, completion: nil)
  }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                          forRowAt indexPath: IndexPath) {
    dataModel.lists.remove(at: indexPath.row)
    
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }



}
