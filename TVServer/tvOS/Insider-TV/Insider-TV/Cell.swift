//
//  Cell.swift
//  Insider-TV
//
//  Created by Troy Do on 10/8/15.
//  Copyright © 2015 Troy Do. All rights reserved.
//

import UIKit

@objc(Cell)
class Cell : UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.contentView.layer.cornerRadius = ITEM_SIZE/2
    self.contentView.layer.borderWidth = 1.0
    self.contentView.layer.borderColor = UIColor.clearColor().CGColor
    
    
//    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
//    let blurEffectView = UIVisualEffectView(effect: blurEffect)
//    //always fill the view
//    blurEffectView.frame = self.contentView.bounds
//    blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
//    self.contentView.addSubview(blurEffectView)
    
    //        self.contentView.backgroundColor = UIColor(patternImage: UIImage(named: "profile-picture-round-e1410459370598.png")!)
    //        self.contentView.background
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
