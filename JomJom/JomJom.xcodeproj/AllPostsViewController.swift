//
//  AllPostsViewController.swift
//  
//
//  Created by Mubarak Sadoon on 2015-05-05.
//
//

import UIKit

class AllPostsViewController: UIViewController {
    
    var utilityInstance:Utilities = Utilities.utilitiesInstance
    var buttonWidth:CGFloat?
    var underline:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureNavigationBar()
        setupSegmentButtons()
        setupUnderline()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UI Methods
    func configureNavigationBar() {
        //get rid of shadow in navigationbar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //set this up for underline and segment buttonsr
        buttonWidth = CGFloat(utilityInstance.getScreenWidth()/3)
        
        //left navigation bar button item
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        var groupChatButton:UIButton = UIButton(frame: CGRectMake(0, 0, 30.0, 30.0))
        groupChatButton.addTarget(self, action: "goToGroupChat", forControlEvents: UIControlEvents.TouchUpInside)
        groupChatButton.setBackgroundImage(UIImage(named: "1.0wechat"), forState: UIControlState.Normal)
        groupChatButton.setBackgroundImage(UIImage(named: "1.0wechat"), forState: UIControlState.Selected)
        groupChatButton.setBackgroundImage(UIImage(named: "1.0wechat"), forState: UIControlState.Highlighted)
        var newBarItemBackButton:UIBarButtonItem = UIBarButtonItem(customView: groupChatButton)
        self.navigationItem.leftBarButtonItem = newBarItemBackButton
        
        //right navigation bar button item
        var writePostButton:UIButton = UIButton(frame: CGRectMake(0, 0, 30.0, 30.0))
        writePostButton.addTarget(self, action: "goToWritePost", forControlEvents: UIControlEvents.TouchUpInside)
        writePostButton.setBackgroundImage(UIImage(named: "1.0post"), forState: UIControlState.Normal)
        writePostButton.setBackgroundImage(UIImage(named: "1.0post"), forState: UIControlState.Selected)
        writePostButton.setBackgroundImage(UIImage(named: "1.0post"), forState: UIControlState.Highlighted)
        var newBarItemRightButton:UIBarButtonItem = UIBarButtonItem(customView: writePostButton)
        self.navigationItem.rightBarButtonItem = newBarItemRightButton
        
        //custom titleview
        var updatingChatTitleButton:UIButton = UIButton(frame: CGRectMake(0, 0, 200, 34)) //50,34 bubble icon original size
        var imageInsets:UIEdgeInsets = UIEdgeInsetsMake(0, 21, 0, 10)
        var updatingChatTitleImage:UIImage =  UIImage(named: "1.0wechat_update")!
        updatingChatTitleImage = updatingChatTitleImage.resizableImageWithCapInsets(imageInsets)
        updatingChatTitleButton.setBackgroundImage(updatingChatTitleImage, forState: UIControlState.Normal)
        updatingChatTitleButton.setBackgroundImage(updatingChatTitleImage, forState: UIControlState.Highlighted)
        updatingChatTitleButton.setBackgroundImage(updatingChatTitleImage, forState: UIControlState.Selected)
        updatingChatTitleButton.addTarget(self, action: "goToGroupChat", forControlEvents: UIControlEvents.TouchUpInside)
        
            //add a UILabel to update text from server every 3 seconds
            var serverText:UILabel = UILabel(frame: CGRectMake(21, 0, 170, 34))
            serverText.text = "server text"
            serverText.textAlignment = NSTextAlignment.Center
            updatingChatTitleButton.addSubview(serverText)
        
        self.navigationItem.titleView = updatingChatTitleButton
    }
    
    func setupSegmentButtons() {
        
        var myPosts:UIButton = UIButton(frame: CGRectMake(0, 0, buttonWidth!, 25))
        var popularPosts:UIButton = UIButton(frame:CGRectMake(buttonWidth!+myPosts.frame.origin.x, 0, buttonWidth!, 25))
        var cityPosts:UIButton = UIButton(frame:CGRectMake(buttonWidth!+popularPosts.frame.origin.x, 0, buttonWidth!, 25))
        
        cityPosts.backgroundColor = UIColor(red: 94.0/255.0, green: 169.0/255.0, blue: 186.0/255.0, alpha: 1)
        popularPosts.backgroundColor = UIColor(red: 94.0/255.0, green: 169.0/255.0, blue: 186.0/255.0, alpha: 1)
        myPosts.backgroundColor = UIColor(red: 94.0/255.0, green: 169.0/255.0, blue: 186.0/255.0, alpha: 1)
        
        var attributedTitle:NSAttributedString = NSAttributedString(string: "My Posts", attributes:
            [NSFontAttributeName:UIFont(name: "Arial", size: 10.0)!,
             NSForegroundColorAttributeName:UIColor.whiteColor()])
        myPosts.setAttributedTitle(attributedTitle, forState: UIControlState.Normal)
        attributedTitle = NSAttributedString(string: "Popular Posts", attributes:
            [NSFontAttributeName:UIFont(name: "Arial", size: 10.0)!,
                NSForegroundColorAttributeName:UIColor.whiteColor()])
        popularPosts.setAttributedTitle(attributedTitle, forState: UIControlState.Normal)
        attributedTitle = NSAttributedString(string: "City Posts", attributes:
            [NSFontAttributeName:UIFont(name: "Arial", size: 10.0)!,
                NSForegroundColorAttributeName:UIColor.whiteColor()])
        cityPosts.setAttributedTitle(attributedTitle, forState: UIControlState.Normal)
        
        myPosts.addTarget(self, action: "myPosts", forControlEvents: UIControlEvents.TouchUpInside)
        popularPosts.addTarget(self, action: "popularPosts", forControlEvents: UIControlEvents.TouchUpInside)
        cityPosts.addTarget(self, action: "cityPosts", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(myPosts)
        self.view.addSubview(popularPosts)
        self.view.addSubview(cityPosts)
    }
    
    func setupUnderline() {
        underline = UIView(frame:CGRectMake(0,22, buttonWidth!,3))
        underline!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(underline!)
    }
    
    //MARK: IBActions or target actions
    
    func myPosts() {
        println("My posts")
        
        UIView.transitionWithView(self.underline!,
            duration: 0.3,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {self.underline?.frame = CGRectMake(0, 22, buttonWidth!, 3)},
            completion: nil)
    }
    
    func popularPosts() {
        println("Popular Posts")
        
        UIView.transitionWithView(self.underline!,
            duration: 0.3,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {self.underline?.frame = CGRectMake(buttonWidth!, 22, buttonWidth!, 3)},
            completion: nil)
    }
    
    func cityPosts() {
        println("City Posts")
        
        UIView.transitionWithView(self.underline!,
            duration: 0.3,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {self.underline?.frame = CGRectMake(buttonWidth!*2, 22, buttonWidth!, 3)},
            completion: nil)
    }
    
    func goToGroupChat() {
        println("group chat")
    }
    
    func goToWritePost() {
        println("write post")
    }
}