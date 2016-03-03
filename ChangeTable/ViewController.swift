//
//  ViewController.swift
//  ChangeTable
//
//  Created by Guillermo Anaya on 3/2/16.
//

import UIKit

class ViewController: UIViewController {
  
  var detail: ModelDetail<CollectionSource<Data>>!

  @IBOutlet weak var dataDetail: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataDetail.text = detail.model?.name
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func tapMutate(sender: UIButton) {
    guard let indexPath = detail.selectedIndexPath else { return }
    let newdata = Data(name: "Update Data")
    dataDetail.text = newdata.name
    detail.updater.updateWith(UpdateType.Update(newdata, indexPath: indexPath))
  }
  
  @IBAction func tapAdd(sender: AnyObject) {
    detail.updater.updateWith(UpdateType.New(Data(name: "New Row")))
  }
  
  @IBAction func tapRemove(sender: AnyObject) {
    guard let indexPath = detail.selectedIndexPath else { return }
    detail.updater.updateWith(UpdateType.Delete(indexPath: indexPath))
  }
}

