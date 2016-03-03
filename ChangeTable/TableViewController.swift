//
//  TableViewController.swift
//  ChangeTable
//
//  Created by Guillermo Anaya on 3/2/16.
//

import UIKit



class TableViewController: UITableViewController {
  
  private let collectionSource = CollectionSource(source: [Data(name: "one row"), Data(name: "other row")])

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionSource.collectionSourceUpdater = self
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "ShowDetail" {
      guard let viewController = segue.destinationViewController as? ViewController, let box = sender as? Box<ModelDetail<CollectionSource<Data>>> else { return }
      viewController.detail = box.unbox
    }
  }


  // MARK: - Table view data source

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return collectionSource.source.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCellWithIdentifier("identifierCell", forIndexPath: indexPath)
  }
  
  override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    cell.textLabel?.text = collectionSource.source[indexPath.row].name
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let modelUpdater = ModelDetail(updater: collectionSource, model: collectionSource.source[indexPath.row], selectedIndexPath: indexPath)
    self.performSegueWithIdentifier("ShowDetail", sender: Box(modelUpdater))
  }

}

extension TableViewController: CollectionSourceUpdater {
  func modelAdd() {
    self.tableView.reloadData()
  }
  
  func modelUpdate(indexPath: NSIndexPath) {
    self.tableView.beginUpdates()
    self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
    self.tableView.endUpdates()
  }
  
  func modelDelete(indexPath: NSIndexPath) {
    self.tableView.reloadData()
  }
}
