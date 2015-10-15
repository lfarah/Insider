//
//  StatusViewController.swift
//  TVPhoneBeacon
//
//  Created by Lucas Farah on 10/8/15.
//  Copyright © 2015 Lucas Farah. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import AMSmoothAlert
class StatusViewController: UIViewController,CLLocationManagerDelegate,ESTBeaconManagerDelegate {
  
  @IBOutlet weak var lblIsIn: UILabel!
  var audioPlayer = AVAudioPlayer()

  @IBOutlet weak var txtUser: UITextField!
  let beaconManager = ESTBeaconManager()

  let userID = "5613150c060f0bd03d702440"
  @IBOutlet weak var segLocation: UISegmentedControl!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    // 3. Set the beacon manager's delegate
    self.beaconManager.delegate = self
    self.beaconManager.requestAlwaysAuthorization()
    
    //create the beacon region
    let beaconRegion : CLBeaconRegion = CLBeaconRegion(
      proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!,
      major: 21960, minor: 29347, identifier: "monitored region")
    
    //Opt in to be notified upon entering and exiting region
    beaconRegion.notifyOnEntry = true
    beaconRegion.notifyOnExit = true
    
    //beacon manager asks permission from user
    beaconManager.startRangingBeaconsInRegion(beaconRegion)
    beaconManager.startMonitoringForRegion(beaconRegion)
  }
  func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
    
    if beacons.first?.proximity == .Far
    {
      print("FAR")
      self.fetch(false)
      
    }
    if beacons.first?.proximity == CLProximity.Immediate
    {
      print("IMMEDIATE")
      self.fetch(true)
      
    }
    if beacons.first?.proximity == .Near
    {
      print("NEAR")
      self.fetch(true)
      
    }
    if beacons.first?.proximity == .Unknown
    {
      print("UNKNOWN")
      
    }
  }
  func beaconManager(manager: AnyObject, didEnterRegion region: CLBeaconRegion)
  {
    print("enter")
    self.fetch(true)
  }
  
  
  func beaconManager(manager: AnyObject, didExitRegion region: CLBeaconRegion) {
    print("EXIT")
    let notification = UILocalNotification()
    notification.alertBody = "EXITED"
    UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    self.fetch(false)
  }

  
  func fetch(isIn: Bool)
  {
    if let user = NSUserDefaults.standardUserDefaults().objectForKey("user")
    {
      print(user)
      print("https://frozen-island-1739.herokuapp.com/updateUser?id=\(user)&isIn=\(isIn)")
      let url = NSURL(string: "https://frozen-island-1739.herokuapp.com/updateUser?id=\(user)&isIn=\(isIn)")
      
      let request = NSURLRequest(URL: url!)
      NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
      
      }
    }
    
    if isIn
    {
      self.lblIsIn.text = "IN"
    }
    else
    {
      self.lblIsIn.text = "OUT"
    }
  }

}

