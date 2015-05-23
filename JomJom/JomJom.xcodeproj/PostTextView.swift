//
//  PostTextView.swift
//  JomJom
//
//  Created by Mubarak Sadoon on 2015-05-18.
//  Copyright (c) 2015 msadoon. All rights reserved.
//

import UIKit

class PostTextView:UITextView {
    
    //MARK: TextView Event Listener
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        return false
    }
    
}