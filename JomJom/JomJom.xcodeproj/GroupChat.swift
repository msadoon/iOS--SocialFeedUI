//
//  GroupChat.swift
//  JomJom
//
//  Created by Mubarak Sadoon on 2015-05-23.
//  Copyright (c) 2015 msadoon. All rights reserved.
//

import UIKit

class GroupChat: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var utilityInstance:Utilities = Utilities.utilitiesInstance
    var chatTable:UITableView?
    var tableHeader:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupTableView()
        setupTableHeaderView()
        // Do any additional setup after loading the view.
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

        //left navigation bar button item
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        let groupChatButton:UIButton = UIButton(frame: CGRectMake(0, 0, 30.0, 30.0))
        groupChatButton.addTarget(self, action: "popBack", forControlEvents: UIControlEvents.TouchUpInside)
        groupChatButton.setBackgroundImage(UIImage(named: "2.1back"), forState: UIControlState.Normal)
        groupChatButton.setBackgroundImage(UIImage(named: "2.1back"), forState: UIControlState.Selected)
        groupChatButton.setBackgroundImage(UIImage(named: "2.1back"), forState: UIControlState.Highlighted)
        let newBarItemBackButton:UIBarButtonItem = UIBarButtonItem(customView: groupChatButton)
        self.navigationItem.leftBarButtonItem = newBarItemBackButton
    }
    
    func setupTableView() {
        let navbarHeight = self.navigationController?.navigationBar.bounds.height as CGFloat!
        
        chatTable = UITableView(frame: CGRectMake(CGFloat(0), CGFloat(0), CGFloat(utilityInstance.getScreenWidth()), CGFloat(utilityInstance.getScreenHeight())-navbarHeight-20))
        chatTable!.delegate = self
        chatTable!.dataSource = self
        chatTable!.bounces = false
        let nib = UINib(nibName: "ChatBubbleCell", bundle: nil)
        chatTable!.registerNib(nib, forCellReuseIdentifier: "ChatBubbleCell")
        chatTable!.backgroundColor = utilityInstance.UIColorFromRGB(0xF0F7F2)//
        chatTable!.separatorColor = UIColor.clearColor()
        chatTable!.separatorInset = UIEdgeInsetsZero
        self.view.addSubview(chatTable!)
    }
    
    func setupTableHeaderView() {
        let blueHeaderText:NSAttributedString = NSAttributedString(string: "some text", attributes: [NSForegroundColorAttributeName:utilityInstance.getAppColor(), NSFontAttributeName:UIFont(name: "Arial", size: 12.0)!])
        let tableHeaderLine1:GroupChatLabelLine = GroupChatLabelLine(frame: CGRectMake(0, 0, CGFloat(utilityInstance.getScreenWidth()), blueHeaderText.size().height))
        tableHeaderLine1.strokeFillColor = utilityInstance.getAppColor()
        tableHeaderLine1.backgroundColor = utilityInstance.UIColorFromRGB(0xF0F7F2)
        let crossLine1:UIBezierPath = UIBezierPath()
        crossLine1.moveToPoint(CGPoint(x: 5, y: tableHeaderLine1.frame.height/2))
        crossLine1.addLineToPoint(CGPoint(x: tableHeaderLine1.frame.size.width-5, y: CGFloat(tableHeaderLine1.frame.height/2)))
        crossLine1.closePath()
        tableHeaderLine1.currentStrokePath = crossLine1
        let tableHeaderText1:UILabel = UILabel(frame: CGRectMake((tableHeaderLine1.frame.size.width/2)-(blueHeaderText.size().width/2), 0, blueHeaderText.size().width+10, CGFloat(ceilf(Float(tableHeaderLine1.frame.size.height)))))
        tableHeaderText1.attributedText = blueHeaderText
        tableHeaderText1.backgroundColor = utilityInstance.UIColorFromRGB(0xF0F7F2)
        tableHeaderText1.textAlignment = NSTextAlignment.Center
        tableHeaderLine1.labelToAdd = tableHeaderText1
        
        let warningText:NSAttributedString = NSAttributedString(string: "some text in red", attributes: [NSForegroundColorAttributeName:UIColor.redColor(), NSFontAttributeName:UIFont(name: "Arial", size: 12.0)!])
        let tableHeaderLine2:GroupChatLabelLine = GroupChatLabelLine(frame: CGRectMake(0, tableHeaderLine1.frame.size.height, CGFloat(utilityInstance.getScreenWidth()), warningText.size().height))
        tableHeaderLine2.strokeFillColor = UIColor.redColor()
        tableHeaderLine2.backgroundColor = utilityInstance.UIColorFromRGB(0xF0F7F2)
        let crossLine2:UIBezierPath = UIBezierPath()
        crossLine2.moveToPoint(CGPoint(x: 5, y: tableHeaderLine2.frame.height/2))
        crossLine2.addLineToPoint(CGPoint(x: tableHeaderLine2.frame.size.width-5, y: CGFloat(tableHeaderLine2.frame.height/2)))
        crossLine2.closePath()
        tableHeaderLine2.currentStrokePath = crossLine2
        let tableHeaderText2:UILabel = UILabel(frame: CGRectMake((tableHeaderLine2.frame.size.width/2)-(warningText.size().width/2), 0, CGFloat(ceilf(Float(warningText.size().width+10))), CGFloat(ceilf(Float(tableHeaderLine2.frame.size.height)))))
        tableHeaderText2.attributedText = warningText
        tableHeaderText2.backgroundColor = utilityInstance.UIColorFromRGB(0xF0F7F2)
        tableHeaderText2.textAlignment = NSTextAlignment.Center
        tableHeaderLine2.labelToAdd = tableHeaderText2
        
        let blueHeaderText2:NSAttributedString = NSAttributedString(string: "some other blue text that should span two lines", attributes: [NSForegroundColorAttributeName:utilityInstance.getAppColor()])
        let tableHeaderText3:UILabel = UILabel(frame: CGRectMake(0, tableHeaderText1.frame.size.height*2, CGFloat(utilityInstance.getScreenWidth()), 100))
        tableHeaderText3.numberOfLines = 0
        tableHeaderText3.attributedText = blueHeaderText2
        tableHeaderText3.textAlignment = NSTextAlignment.Center
        tableHeaderText3.backgroundColor = UIColor.blueColor()
        
//        CGSize maximumLabelSize = CGSizeMake(CGFloat(utilityInstance.getScreenWidth()), FLT_MAX)
//        CGSize expectedLabelSize = blueHeaderText2.
        
        let rectForHeaderText2:CGRect = blueHeaderText2.boundingRectWithSize(CGSizeMake(CGFloat(utilityInstance.getScreenWidth()), CGFloat(10000)), options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], context: nil)
        tableHeaderText3.frame.size = rectForHeaderText2.size
        
        let heightOfHeader:CGFloat = CGFloat(tableHeaderText1.frame.size.height + tableHeaderText2.frame.size.height + tableHeaderText3.frame.size.height)
        
        tableHeader = UIView(frame: CGRectMake(0, 0, CGFloat(utilityInstance.getScreenWidth()), heightOfHeader))
        tableHeader!.backgroundColor = utilityInstance.UIColorFromRGB(0xF0F7F2)
        
        tableHeader!.addSubview(tableHeaderLine1)
        tableHeader!.addSubview(tableHeaderLine2)
        tableHeader!.addSubview(tableHeaderText3)
    }
    
    func setupTableDatasource() {
        utilityInstance.setArrayForDemoPurposes()
    }
    
    func popBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: Tableview delegate methods
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return tableHeader
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableHeader!.frame.size.height
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

}
