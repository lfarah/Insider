//
//  ViewController.swift
//  TVPhoneBeacon
//
//  Created by Lucas Farah on 10/6/15.
//  Copyright © 2015 Lucas Farah. All rights reserved.
//

import UIKit
import UIKit
import CoreLocation
import Alamofire

class ViewController: UIViewController,CLLocationManagerDelegate {
  
  
  @IBOutlet weak var txtEmail: UITextField!
  @IBOutlet weak var txtPassword: UITextField!
  
  @IBOutlet weak var txtName: UITextField!
  
  let userID = "5613150c060f0bd03d702440"
  @IBOutlet weak var segLocation: UISegmentedControl!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.image()
    
  }
  
  func image()
  {
    let image = UIImage(named: "profile-circle.png")
    if let data = UIImagePNGRepresentation(image!) as NSData?
    {
      Alamofire.request(.GET, "http://0.0.0.0:5000/upload", parameters: ["file": data])
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
  func fetch()
  {
    NSUserDefaults.standardUserDefaults().setObject(self.txtEmail.text, forKey: "user")
    
    print(self.txtEmail.text)
    print(self.txtName.text)
    print(self.txtPassword.text)
    
    if let email=self.txtEmail.text,name = self.txtName.text,password=self.txtPassword.text
    {
      let url = NSURL(string: "https://frozen-island-1739.herokuapp.com/addUser?email=\(email)&password=\(password)&name=\(name)")
      print(url?.absoluteString)
      
      let request = NSURLRequest(URL: url!)
      
      NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
        
        self.performSegueWithIdentifier("login", sender: self)
      }
    }
    
    
  }
  
  @IBOutlet weak var butLogin: UIButton!
  
  
  @IBAction func butLoginSelected(sender: AnyObject)
  {
    self.fetch()
  }
  
}

//MARK - UITextFieldDelegate
extension ViewController:UITextFieldDelegate
{
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    switch textField
    {
    case self.txtName:
      //do something
      self.txtEmail.becomeFirstResponder()
      break
    case self.txtEmail:
      //do something else
      self.txtPassword.becomeFirstResponder()
      
      break
    default:
      self.txtPassword.resignFirstResponder()
      break;
    }
    return true
  }
}
