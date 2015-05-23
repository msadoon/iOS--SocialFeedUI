//
//  AllPostsViewController.swift
//  
//
//  Created by Mubarak Sadoon on 2015-05-05.
//
//

import UIKit

class AllPostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    var utilityInstance:Utilities = Utilities.utilitiesInstance
    var buttonWidth:CGFloat?
    var underline:UIView?
    var bottomNav:UIView?
    var topTabBar:UIView?
    var mainTable:UITableView?
    var goToTopButton:UIButton?
    var refreshControl:UIRefreshControl?
    var lastScrollPostition: CGFloat? = 0
    
    var tableResize:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureNavigationBar()
        setupSegmentButtons()
        setupUnderline()
        bottomNavBar()
        setupTableDatasource()
        setupTableView()
        setupRefreshControl()
        setupGoToTopButton()
    }
    
    override func viewWillAppear(animated: Bool) {
        mainTable?.reloadData()
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
    
    func setupGoToTopButton() {
        var image:UIImage = UIImage(named: "1.2gototop")!
        var imageView:UIImageView = UIImageView(image: image)
        goToTopButton = UIButton(frame: CGRectMake(CGFloat(utilityInstance.getScreenWidth()/2) - CGFloat((imageView.frame.width/3)/2), 20, imageView.frame.width/3, imageView.frame.height/3))
        goToTopButton!.setBackgroundImage(image, forState: UIControlState.Normal)
        goToTopButton!.setBackgroundImage(image, forState: UIControlState.Selected)
        goToTopButton!.setBackgroundImage(image, forState: UIControlState.Highlighted)
        goToTopButton!.addTarget(self, action: "scrollToTop", forControlEvents: UIControlEvents.TouchUpInside)
        goToTopButton!.hidden = true
        self.view.addSubview(goToTopButton!)
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl!.backgroundColor = UIColor.clearColor()
        refreshControl!.tintColor = utilityInstance.UIColorFromRGB(0xC0F1E9)
        refreshControl!.addTarget(self, action: nil, forControlEvents: UIControlEvents.ValueChanged)
        mainTable?.addSubview(refreshControl!)
        
    }
    
    func setupSegmentButtons() {
        
        topTabBar = UIView(frame: CGRectMake(0, 0, CGFloat(utilityInstance.getScreenWidth()), 25))
        
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
        
        self.topTabBar?.addSubview(myPosts)
        self.topTabBar?.addSubview(popularPosts)
        self.topTabBar?.addSubview(cityPosts)
        self.view.addSubview(topTabBar!)
    }
    
    func setupUnderline() {
        underline = UIView(frame:CGRectMake(0,22, buttonWidth!,3))
        underline!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(underline!)
    }
    
    func setupTableView() {
        var navbarHeight = self.navigationController?.navigationBar.bounds.height as CGFloat!
        mainTable = UITableView(frame: CGRectMake(CGFloat(0), CGFloat(25), CGFloat(utilityInstance.getScreenWidth()), CGFloat(utilityInstance.getScreenHeight())-(navbarHeight+25+44+20)))//20 pixels I cannot account for
        mainTable!.delegate = self
        mainTable!.dataSource = self

        var nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        mainTable!.registerNib(nib, forCellReuseIdentifier: "postCell")
        mainTable!.backgroundColor = utilityInstance.UIColorFromRGB(0xF0F7F2)
        mainTable!.separatorColor = UIColor.clearColor()
        mainTable!.separatorInset = UIEdgeInsetsZero
        self.view.addSubview(mainTable!)
    }
    
    func setupTableDatasource() {
        utilityInstance.setArrayForDemoPurposes()
    }
    
    func bottomNavBar() {
        var navbarHeight = self.navigationController?.navigationBar.bounds.height as CGFloat!
        bottomNav = UIView(frame: CGRectMake(0, CGFloat(utilityInstance.getScreenHeight())-(navbarHeight+CGFloat(25)+39), CGFloat(utilityInstance.getScreenWidth()), 44)) //5 pixels I cannot account for
        bottomNav!.backgroundColor = utilityInstance.getAppColor()
        self.view.addSubview(bottomNav!)
        
        //left navigation button -- My Message
        var myMessageButton:UIButton = UIButton(frame: CGRectMake(12, 5, 33.0, 33.0))
        myMessageButton.addTarget(self, action: "goToMyMessage", forControlEvents: UIControlEvents.TouchUpInside)
        myMessageButton.setBackgroundImage(UIImage(named: "1.0my_message"), forState: UIControlState.Normal)
        myMessageButton.setBackgroundImage(UIImage(named: "1.0my_message"), forState: UIControlState.Selected)
        myMessageButton.setBackgroundImage(UIImage(named: "1.0my_message"), forState: UIControlState.Highlighted)
        bottomNav!.addSubview(myMessageButton)
        
        //right navigation button
        var mySettingsButton:UIButton = UIButton(frame: CGRectMake(CGFloat(utilityInstance.getScreenWidth()-12-33.0), 5, 33.0, 33.0))
        mySettingsButton.addTarget(self, action: "goToMySettings", forControlEvents: UIControlEvents.TouchUpInside)
        mySettingsButton.setBackgroundImage(UIImage(named: "1.0settings"), forState: UIControlState.Normal)
        mySettingsButton.setBackgroundImage(UIImage(named: "1.0settings"), forState: UIControlState.Selected)
        mySettingsButton.setBackgroundImage(UIImage(named: "1.0settings"), forState: UIControlState.Highlighted)
        bottomNav!.addSubview(mySettingsButton)

        //center navigation button
        //custom titleview
        var personalChatButton:UIButton = UIButton(frame: CGRectMake(CGFloat((utilityInstance.getScreenWidth()/2)-100), 5, 200, 34))
        personalChatButton.setTitle("1 on 1 chat", forState: UIControlState.Normal)
        personalChatButton.addTarget(self, action: "goToPersonalChat", forControlEvents: UIControlEvents.TouchUpInside)
        bottomNav!.addSubview(personalChatButton)
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var newCell:PostTableViewCell = mainTable?.dequeueReusableCellWithIdentifier("postCell") as! PostTableViewCell
        // configure drop shadow
        
        newCell.contentView.backgroundColor = utilityInstance.UIColorFromRGB(0xF0F7F2)
        newCell.backgroundColor = utilityInstance.UIColorFromRGB(0xF0F7F2)
        newCell.loadPost(utilityInstance.getArrayForDemoPurposes()[indexPath.row])
        newCell.cellView.layer.bounds = CGRectMake(0, 0, 320*0.9375, 200*0.933335)
        newCell.cellView.layer.shadowPath = UIBezierPath(rect: newCell.cellView.layer.bounds).CGPath
        newCell.cellView.layer.shadowOffset = CGSizeMake(2, 2)
        newCell.cellView.layer.shadowColor = UIColor.blackColor().CGColor
        newCell.cellView.layer.shadowRadius = 3
        newCell.cellView.layer.shadowOpacity = 0.30
        
        return newCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return utilityInstance.getArrayForDemoPurposes().count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 200
    }
    
    //UIScrollViewDelegate
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
    
        if ((lastScrollPostition > scrollView.contentOffset.y) && (scrollView.contentOffset.y != 0) && (scrollView.contentOffset.y >= 0)) {
            goToTopButton?.hidden = false
        } else {
            goToTopButton?.hidden = true
        }
        
        lastScrollPostition = scrollView.contentOffset.y
        
        
        if (tableResize) {
            if (scrollView.contentOffset.y <= 0) {
                tableResize = false
                
                //animate
                UIView.transitionWithView(self.bottomNav!,
                    duration: 0.3,
                    options: UIViewAnimationOptions.CurveEaseInOut,
                    animations: {
                        self.mainTable?.frame = CGRectMake(self.mainTable!.frame.origin.x, self.mainTable!.frame.origin.y+25, self.mainTable!.frame.width, self.mainTable!.frame.height-self.bottomNav!.frame.height-25)
                        
                    },
                    completion: nil)
            }
        } else {
            if (scrollView.contentOffset.y > 0) {
                
                refreshControl?.endRefreshing()
                tableResize = true
                UIView.transitionWithView(self.bottomNav!,
                    duration: 0.3,
                    options: UIViewAnimationOptions.CurveEaseInOut,
                    animations: {
                        self.mainTable?.frame = CGRectMake(self.mainTable!.frame.origin.x, self.mainTable!.frame.origin.y-25, self.mainTable!.frame.width, self.mainTable!.frame.height+self.bottomNav!.frame.height+25)
                    },
                    completion: nil)
            }
        }
    }
    
    
    //MARK: IBActions or target actions
    
    func scrollToTop() {
        mainTable?.scrollRectToVisible(CGRectMake(0, 0, CGFloat(utilityInstance.getScreenWidth()), 1), animated: true)
    }
    
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
        let writePostVC:CreatePostViewController = CreatePostViewController.init(nibName:"CreatePostViewController", bundle:nil)
        utilityInstance.setWriteVC(writePostVC)
        self.navigationController?.pushViewController(writePostVC, animated: true)
    }
    
    func goToPersonalChat() {
        println("personal chat")
    }
    
    func goToMySettings() {
        println("settings")
    }
    
    func goToMyMessage() {
        println("my message")
    }
}