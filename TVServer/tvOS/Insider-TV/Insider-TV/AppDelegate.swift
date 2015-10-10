//
//  AppDelegate.swift
//  Insider-TV
//
//  Created by Troy Do on 10/8/15.
//  Copyright © 2015 Troy Do. All rights reserved.
//

import UIKit

@UIApplicationMain
@objc(AppDelegate)
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var viewController: ViewController!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        viewController = ViewController(collectionViewLayout: CircleLayout())
        
        self.window!.rootViewController = self.viewController
        
        self.window!.makeKeyAndVisible()
        return true
    }
    
    
}

