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
  var arrUsersInside = [NSDictionary]()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.fetch()
    
    _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "fetch", userInfo: nil, repeats: true)
  }
  
  func fetch()
  {
    print("timer")
    let url = NSURL(string: "https://frozen-island-1739.herokuapp.com")
    
    let request = NSURLRequest(URL: url!)
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
      
      do
      {
        var arr = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! [NSDictionary]
        
        for user in arr
        {
          if !(user["isActive"] as! Bool)
          {
            arr.removeAtIndex(arr.indexOf(user)!)
          }
        }
        
        self.arrUsersInside = arr
        
        for user in self.arrUsersInside
        {
          if !(user["isActive"] as! Bool)
          {
            self.arrUsersInside.removeAtIndex(self.arrUsersInside.indexOf(user)!)
          }
        }
        self.table?.reloadData()

      }
      catch
      {
        
      }
      
    }
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
