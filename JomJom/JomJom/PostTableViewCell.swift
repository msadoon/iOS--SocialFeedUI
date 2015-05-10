//
//  PostTableViewCell.swift
//  JomJom
//
//  Created by Mubarak Sadoon on 2015-05-09.
//  Copyright (c) 2015 msadoon. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    var message:String = ""
    var comments:Int = 0
    var likes:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
