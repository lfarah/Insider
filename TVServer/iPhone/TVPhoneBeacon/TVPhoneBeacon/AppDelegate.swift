//
//  AppDelegate.swift
//  TVPhoneBeacon
//
//  Created by Lucas Farah on 10/6/15.
//  Copyright © 2015 Lucas Farah. All rights reserved.
//

import UIKit
import CoreLocation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    
//    if let user = NSUserDefaults.standardUserDefaults().objectForKey("user")
//    {
//    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//    
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    
//    let initialViewController = storyboard.instantiateViewControllerWithIdentifier("StatusViewController") as! UIViewController
//    
//    self.window?.rootViewController = initialViewController
//    self.window?.makeKeyAndVisible()
//    }
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    self.start()
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
    self.myBeaconRegion.notifyEntryStateOnDisplay = true

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

