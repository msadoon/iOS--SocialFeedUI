//
//  PostTableViewCell.swift
//  JomJom
//
//  Created by Mubarak Sadoon on 2015-05-09.
//  Copyright (c) 2015 msadoon. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    var thisPost:Post?
    var utilityInstance:Utilities = Utilities.utilitiesInstance
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellPostImageView: UIImageView!
    @IBOutlet weak var cellPostCornerImageView: UIImageView!
    @IBOutlet weak var cellCommentNumLabel: UILabel!
    @IBOutlet weak var cellLikesNumLabel: UILabel!
    @IBOutlet weak var cellLikesButton: UIButton!
    @IBOutlet weak var cellCommentButton: UIButton!
    @IBOutlet weak var cellPostContentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupButtons()
    }
    
    private func setupButtons() {
        self.cellCommentButton.setBackgroundImage(UIImage(named:"1.1emptychat"), forState: UIControlState.Normal)
        self.cellCommentButton.setBackgroundImage(UIImage(named:"1.1emptychat"), forState: UIControlState.Highlighted)
        self.cellCommentButton.setBackgroundImage(UIImage(named:"1.1emptychat"), forState: UIControlState.Selected)
        self.cellCommentButton.setBackgroundImage(UIImage(named:"1.1emptychat"), forState: UIControlState.Disabled)
        
        self.cellLikesButton.setBackgroundImage(UIImage(named:"1.1empty_like"), forState: UIControlState.Normal)
        self.cellLikesButton.setBackgroundImage(UIImage(named:"1.1filllike"), forState: UIControlState.Highlighted)
        self.cellLikesButton.setBackgroundImage(UIImage(named:"1.1filllike"), forState: UIControlState.Selected)
        self.cellLikesButton.setBackgroundImage(UIImage(named:"1.1empty_like"), forState: UIControlState.Disabled)

    }

    func loadPost(post:Post) {
        thisPost = post
        cellLikesNumLabel.text = String(post.numLikes)
        cellCommentNumLabel.text = String(post.numComments)
        cellPostContentLabel.text = String(post.postContent)
        if (post.liked) {
            self.cellLikesButton.selected = true
        } else {
            self.cellLikesButton.selected = false
        }
        loadColor(thisPost!.color)
    }
    
    private func loadColor(type:ColorType) {
        var applyColor:UIColor = utilityInstance.UIColorFromRGB(0xFFFFFF)
        var cornerImageString:String = ""
        switch (type) {
            case ColorType.Teal:
                applyColor = utilityInstance.UIColorFromRGB(0xC0F1E9)
                cornerImageString = "1.1corner_a"
            case ColorType.Yellow:
                applyColor = utilityInstance.UIColorFromRGB(0xF1EEBE)
                cornerImageString = "1.1corner_b"
            case ColorType.Gray:
                applyColor = utilityInstance.UIColorFromRGB(0xD6D6D6)
                cornerImageString = "1.1corner_c"
            case ColorType.LightBlue:
                applyColor = utilityInstance.UIColorFromRGB(0xBDE3F0)
                cornerImageString = "1.1corner_d"
            case ColorType.Purple:
                applyColor = utilityInstance.UIColorFromRGB(0xD9BDEF)
                cornerImageString = "1.1corner_e"
            case ColorType.Orange:
                applyColor = utilityInstance.UIColorFromRGB(0xF0D5BD)
                cornerImageString = "1.1corner_f"
            case ColorType.Pink:
                applyColor = utilityInstance.UIColorFromRGB(0xF0BDDB)
                cornerImageString = "1.1corner_g"
            default:
                applyColor = utilityInstance.UIColorFromRGB(0xBDD2F0)
                cornerImageString = "1.1corner_h"
        }
        
        cellPostImageView.backgroundColor = applyColor
        cellPostCornerImageView.image = UIImage(named:cornerImageString)
    }
    
    @IBAction func clickLike(sender: AnyObject) {
        thisPost!.numLikes as Int
        if (!self.cellLikesButton.selected) {
            self.cellLikesButton.selected = true
            thisPost?.numLikes += Int(1)
            thisPost?.liked = true
            cellLikesNumLabel.text = String(stringInterpolationSegment: thisPost!.numLikes as Int)
        } else {
            self.cellLikesButton.selected = false
            thisPost?.numLikes -= Int(1)
            thisPost?.liked = false
            cellLikesNumLabel.text = String(stringInterpolationSegment: thisPost!.numLikes as Int)
        }
    }
    
    @IBAction func clickComment(sender: AnyObject) {
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
