//
//  UserTableViewCell.swift
//  tv
//
//  Created by Lucas Farah on 10/5/15.
//  Copyright © 2015 Lucas Farah. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

  
  @IBOutlet weak var lblName:UILabel!
  @IBOutlet weak var imgvUser:UIImageView!
  @IBOutlet weak var lblStatus:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
