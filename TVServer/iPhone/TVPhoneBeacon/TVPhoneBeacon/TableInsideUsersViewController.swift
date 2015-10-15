//
//  TableInsideUsersViewController.swift
//  TVPhoneBeacon
//
//  Created by Lucas Farah on 10/15/15.
//  Copyright © 2015 Lucas Farah. All rights reserved.
//

import UIKit

class TableInsideUsersViewController: UIViewController {

  @IBOutlet weak var table: UITableView!
  
  var arrUsersInside = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - UITableViewDataSource
extension TableInsideUsersViewController: UITableViewDataSource
{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return self.arrUsersInside.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell!
    if !(cell != nil)
    {
      cell = UITableViewCell(style:.Default, reuseIdentifier: "cell")
    }
    // setup cell without force unwrapping it
    cell.textLabel!.text = "Swift"
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    
  }
}
