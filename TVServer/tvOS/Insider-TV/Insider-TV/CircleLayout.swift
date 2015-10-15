//
//  CircleLayout.swift
//  Insider-TV
//
//  Created by Troy Do on 10/8/15.
//  Copyright © 2015 Troy Do. All rights reserved.
//

import UIKit

var ITEM_SIZE: CGFloat = 180

@objc(CircleLayout)
class CircleLayout: UICollectionViewLayout,UICollectionViewDelegate {
    var center: CGPoint = CGPoint()
    var radius: CGFloat = CGFloat()
    var cellCount: Int = Int()
    
    
    override func prepareLayout() {
        super.prepareLayout()
      
      if cellCount == 1
      {
        let size = self.collectionView!.frame.size
        cellCount = self.collectionView!.numberOfItemsInSection(0)
        center = CGPointMake(size.width / 2.0, size.height / 2.0)
        radius = 0
      }
      else
      {
        let size = self.collectionView!.frame.size
        cellCount = self.collectionView!.numberOfItemsInSection(0)
        center = CGPointMake(size.width / 2.0, size.height / 2.0)
        radius = min(size.width, size.height) / 2.8
      }
      if self.collectionView?.numberOfItemsInSection(0)>1
      {
        let num =  900 / (self.collectionView?.numberOfItemsInSection(0))!
        ITEM_SIZE = CGFloat(num)
      }
      else
      {
        ITEM_SIZE = 700
      }
    }
  

    
    override func collectionViewContentSize() -> CGSize {
        return self.collectionView!.frame.size
    }
    
    override func layoutAttributesForItemAtIndexPath(path: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: path)
        attributes.size = CGSizeMake(ITEM_SIZE, ITEM_SIZE)
        attributes.center = CGPointMake(center.x + radius * cos(2 * CGFloat(path.item) * CGFloat(M_PI) / CGFloat(cellCount)),
            center.y + radius * sin(2 * CGFloat(path.item) * CGFloat(M_PI) / CGFloat(cellCount)))
        return attributes
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes: [UICollectionViewLayoutAttributes] = []
        for i in 0..<self.cellCount {
            let indexPath = NSIndexPath(forItem: i, inSection: 0)
            attributes.append(self.layoutAttributesForItemAtIndexPath(indexPath)!)
        }
        return attributes
    }
    
    //### ???
    //- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForInsertedItemAtIndexPath:(NSIndexPath *)itemIndexPath
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes {
        let attributes = self.layoutAttributesForItemAtIndexPath(itemIndexPath)!
        attributes.alpha = 0.0
        attributes.center = CGPointMake(center.x, center.y)
        return attributes
    }
    
    //### ???
    //- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDeletedItemAtIndexPath:(NSIndexPath *)itemIndexPath
    override func finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = self.layoutAttributesForItemAtIndexPath(itemIndexPath)!
        attributes.alpha = 0.0
        attributes.center = CGPointMake(center.x, center.y)
        attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0)
        return attributes
    }
    
}
