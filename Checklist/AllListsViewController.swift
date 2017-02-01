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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  // navigationController(willShow gets called before viewDidAppear
  func navigationController(_ navigationController: UINavigationController,
                            willShow viewController: UIViewController,
                            animated: Bool) {
    // Was the back button tapped?
    print("-- running navigationController(willShow)")
    if viewController === self {
      dataModel.indexOfSelectedChecklist = -1
      print("-- dataModel.indexOfSelectedChecklist is now set to \(dataModel.indexOfSelectedChecklist)")
    }
  }
  
  override func viewDidAppear(_ animated: Bool){
    super.viewDidAppear(animated)
    print("-- Running viewDidAppear")
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
      cell.detailTextLabel!.text = "\(checklist.countUncheckedItems()) Remaining"
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
    print("-- Running AllListViewController.tableView:didSelectRowAt")
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
    let newRowIndex = dataModel.lists.count
    dataModel.lists.append(checklist)
    
    //Tell the tableView we have a new row. It must be passed in as
    // an array. So, we make an array with one item.
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    
    dismiss(animated: true, completion: nil)
  }
  
  func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist){
    if let index = dataModel.lists.index(of: checklist) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        cell.textLabel!.text = checklist.name
      }
    }
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
