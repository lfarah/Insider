//
//  ViewController.swift
//  tv
//
//  Created by Lucas Farah on 9/28/15.
//  Copyright © 2015 Lucas Farah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var table: UITableView!
  
  var arrUsers = [NSDictionary]()

  
  func fetch()
  {
    print("timer")
    let url = NSURL(string: "https://frozen-island-1739.herokuapp.com")
    
    let request = NSURLRequest(URL: url!)
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
      
      do
      {
        self.arrUsers = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! [NSDictionary]
        print(self.arrUsers)
        self.table.reloadData()
      }
      catch
      {
        
      }
      
    }

  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
      
    let timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "fetch", userInfo: nil, repeats: true)

  }
}

extension ViewController: UITableViewDataSource
{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return arrUsers.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UserTableViewCell!
    if !(cell != nil)
    {
      cell = UserTableViewCell(style:.Default, reuseIdentifier: "cell")
    }
    // setup cell without force unwrapping it
    let user = arrUsers[indexPath.row]
    cell.lblName.text = user["name"] as! String
    
    if user["isActive"] as! Bool
    {
      cell.lblStatus.text = "IN"
      cell.lblStatus.textColor = UIColor.greenColor()
    }
    else
    {
      cell.lblStatus.text = "OUT"
      cell.lblStatus.textColor = UIColor.redColor()
    }
    
    let imgvName = user["picture"] as! String
    cell.imgvUser.image = UIImage(named: imgvName)
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    
  }
}

