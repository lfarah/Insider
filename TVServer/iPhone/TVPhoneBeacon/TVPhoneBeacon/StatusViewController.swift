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

class StatusViewController: UIViewController,CLLocationManagerDelegate {

  @IBOutlet weak var lblIsIn: UILabel!
  //
  //  ViewController.swift
  //  TVPhoneBeacon
  //
  //  Created by Lucas Farah on 10/6/15.
  //  Copyright © 2015 Lucas Farah. All rights reserved.
  //
  

  
  
    @IBOutlet weak var txtUser: UITextField!
    
    let userID = "5613150c060f0bd03d702440"
    @IBOutlet weak var segLocation: UISegmentedControl!
    override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
      self.start()
  }
  
  func image()
  {
    let image = UIImage(named: "profile-circle.png")
    if let data = UIImagePNGRepresentation(image!) as NSData?
    {
      Alamofire.request(.POST, "http://0.0.0.0:5000/upload", parameters: ["file": data])
        .responseJSON { response in
          print(response.request)  // original URL request
          print(response.response) // URL response
          print(response.data)     // server data
          print(response.result)   // result of response serialization
          
          if let JSON = response.result.value {
            print("JSON: \(JSON)")
          }
      }
    }
  }
    
    @IBAction func segLocation(sender: AnyObject)
    {
      switch segLocation.selectedSegmentIndex
      {
      case 0:
        print("IN")
        self.fetch(true)
        
        break
      case 1:
        //do something else
        self.fetch(false)
        
        break
      default:
        break
      }
    }
    
    
    
    @IBAction func butSave(sender: AnyObject)
    {
      let text = self.txtUser.text
      NSUserDefaults.standardUserDefaults().setObject(text, forKey: "user")
      
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
    
    //
    //  ViewController.swift
    //  magicPay
    //
    //  Created by Lucas Farah on 8/22/15.
    //  Copyright (c) 2015 Lucas Farah. All rights reserved.
    //
    
    var myBeaconRegion:CLBeaconRegion = CLBeaconRegion()
    var locationManager:CLLocationManager = CLLocationManager()
    
    
    func start() {
      locationManager = CLLocationManager()
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
      locationManager.requestAlwaysAuthorization()
      locationManager.startUpdatingLocation()
      
      
      let uuid = NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")
      
      self.myBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "com.GreatAmerica")
      
      self.locationManager.startMonitoringForRegion(self.myBeaconRegion)
      
      self.locationManager.startRangingBeaconsInRegion(self.myBeaconRegion)
      
    }
    //MARK: LocationManager Delegate
    func locationManager(manager: CLLocationManager, rangingBeaconsDidFailForRegion region: CLBeaconRegion, withError error: NSError) {
      print(error.description)
    }
    //  func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
    //    print("locat")
    //  }
    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError)
    {
      print("Failed")
    }
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
      print("Beacon Found")
      
      print(region.identifier)
    }
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
      //    println("Beacon Found")
      //    println(beacons.first)
      
      if (beacons.first != nil)
      {
        let nearestBeacon = beacons.first
        var message = ""
        
        switch nearestBeacon!.proximity {
        case CLProximity.Far:
          message = "Proximity: Far"
          self.fetch(false)
          
        case CLProximity.Near:
          message = "Proximity: Near"
          self.fetch(true)
        case CLProximity.Immediate:
          message = "Proximity: Immediate"
          self.fetch(true)
          
          self.beaconDidApprox(beacon: nearestBeacon!, forRegion: region)
        case CLProximity.Unknown:
          return
        }
        //      println(message)
      }
    }
    
    func beaconDidApprox(beacon beacon:CLBeacon, forRegion region: CLRegion)
    {
      print(region.identifier)
      //    let session = DGTSession.userID
    }
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
      print("Exited Beacon")
      self.fetch(false)
    }
}

