//
//  ViewController.swift
//  Insider-TV
//
//  Created by Troy Do on 10/8/15.
//  Copyright © 2015 Troy Do. All rights reserved.
//

import UIKit
import AVFoundation

private let cellIdentifier = "MY_CELL"

@objc(ViewController)


class ViewController: UICollectionViewController {
  var cellCount: Int = Int()
  var audioPlayer = AVAudioPlayer()
  
  
  var arrUsers = [NSDictionary]()
  
  func playSound(name:String)
  {
//    if self.arrUsers.count != arr.count
//    {
//      var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cat_meow2", ofType: "wav")!)
//      print(alertSound)
//      
//      // Removed deprecated use of AVAudioSessionDelegate protocol
//      do
//      {
//        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//        try AVAudioSession.sharedInstance().setActive(true)
//      }
//      catch
//      {
//        
//      }
//      
//      do
//      {
//        self.audioPlayer = try AVAudioPlayer(contentsOfURL: alertSound)
//      }
//      catch
//      {
//        
//      }
//      self.audioPlayer.prepareToPlay()
//      self.audioPlayer.play()
//    }
    var mySpeechSynthesizer:AVSpeechSynthesizer = AVSpeechSynthesizer()
    var myString:String = "Welcome, \(name)"
    var mySpeechUtterance:AVSpeechUtterance = AVSpeechUtterance(string:myString)
    
    print("\(mySpeechUtterance.speechString)")
    print("My string - \(myString)")
    
    mySpeechSynthesizer .speakUtterance(mySpeechUtterance)

  }
  func fetch()
  {
//    self.playSound()
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
        print(arr.count)
        print(self.arrUsers.count)
        
        if arr.count != self.arrUsers.count
        {
          for user in arr
          {
            if !(self.arrUsers.contains(user))
            {
              self.playSound(user["name"] as! String)

            }
          }
        }
        
        
        self.arrUsers = arr
        
        var i = 0
        for user in self.arrUsers
        {
          if !(user["isActive"] as! Bool)
          {
            self.arrUsers.removeAtIndex(self.arrUsers.indexOf(user)!)
            i += 1
          }
        }
        

        
      }
      catch
      {
        
      }
      
      self.cellCount = self.arrUsers.count
      self.collectionView?.reloadData()
      print(self.arrUsers)
      
    }
    
    
    
  }
  
  let arr = ["profile-picture-round-e1410459370598.png","Profile+Photo+-+Circle.jpg","TomAndersCircleProfile.png","profile-circle.png","Profile+Photo+-+Circle.jpg","profile-picture-round-e1410459370598.png","Profile+Photo+-+Circle.jpg","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png","profile-picture-round-e1410459370598.png","Profile+Photo+-+Circle.jpg","TomAndersCircleProfile.png","profile-circle.png","Profile+Photo+-+Circle.jpg","profile-picture-round-e1410459370598.png","Profile+Photo+-+Circle.jpg","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png","profile-picture-round-e1410459370598.png","Profile+Photo+-+Circle.jpg","TomAndersCircleProfile.png","profile-circle.png","Profile+Photo+-+Circle.jpg","profile-picture-round-e1410459370598.png","Profile+Photo+-+Circle.jpg","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png","profile-picture-round-e1410459370598.png","Profile+Photo+-+Circle.jpg","TomAndersCircleProfile.png","profile-circle.png","Profile+Photo+-+Circle.jpg","profile-picture-round-e1410459370598.png","Profile+Photo+-+Circle.jpg","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png","profile-picture-round-e1410459370598.png","Profile+Photo+-+Circle.jpg","TomAndersCircleProfile.png","profile-circle.png","Profile+Photo+-+Circle.jpg","profile-picture-round-e1410459370598.png","Profile+Photo+-+Circle.jpg","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png","profile-picture-round-e1410459370598.png","Profile+Photo+-+Circle.jpg","TomAndersCircleProfile.png","profile-circle.png","Profile+Photo+-+Circle.jpg","profile-picture-round-e1410459370598.png","Profile+Photo+-+Circle.jpg","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png","TomAndersCircleProfile.png"]
  override func viewDidLoad() {
    super.viewDidLoad()
    self.cellCount = 5
    let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleTapGesture:")
    self.collectionView!.addGestureRecognizer(tapRecognizer)
    self.collectionView!.registerClass(Cell.self, forCellWithReuseIdentifier: cellIdentifier)
    self.collectionView!.reloadData()
    self.collectionView!.backgroundColor = UIColor.whiteColor()
    
    let timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "fetch", userInfo: nil, repeats: true)
  }
  
  func timer()
  {
    self.cellCount = 10
    self.collectionView?.reloadData()
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.cellCount
  }
  
  override func collectionView(cv: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
  {
    
    //      label
    //      myLabel.text = "D"
    //      myLabel.textAlignment = NSTextAlignment.Center;
    let cell = cv.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)
    
    let view = UIView(frame: cell.frame)
    var label = UILabel()
    if arrUsers.count == 1
    {
      label = UILabel(frame: CGRectMake(0, 400, cell.frame.width, cell.frame.height))
    }
    else
    {
      label = UILabel(frame: CGRectMake(0, CGFloat(500 / Double(self.cellCount)), cell.frame.width, cell.frame.height))
    }
    
    if arrUsers.count > 0
    {
      let user = arrUsers[indexPath.row]
      label.text = user["name"] as! String
    }
    label.font = UIFont(name: "HelveticaNeue", size: CGFloat(200 / self.cellCount))
    label.textAlignment = .Center
    
    let imagev = UIImageView(frame: CGRectMake(0, 0, cell.frame.width, cell.frame.height))
    imagev.image = UIImage(named: arr[indexPath.row])!
    view.addSubview(imagev)
    view.addSubview(label)
    
    cell.backgroundView = view
    return cell
  }
  
  func handleTapGesture(sender: UITapGestureRecognizer) {
    
    if sender.state == .Ended {
      let initialPinchPoint = sender.locationInView(self.collectionView)
      if let tappedCellPath = self.collectionView!.indexPathForItemAtPoint(initialPinchPoint) {
        
        self.cellCount = self.cellCount - 1
        self.collectionView!.performBatchUpdates({
          self.collectionView!.deleteItemsAtIndexPaths([tappedCellPath])
          }, completion: nil)
      } else {
        self.cellCount = self.cellCount + 1
        self.collectionView!.performBatchUpdates({
          self.collectionView!.insertItemsAtIndexPaths([NSIndexPath(forItem: 0, inSection: 0)])
          }, completion: nil)
      }
    }
  }
  
}

