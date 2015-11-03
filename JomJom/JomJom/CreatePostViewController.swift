//
//  CreatePost.swift
//  JomJom
//
//  Created by Mubarak Sadoon on 2015-05-14.
//  Copyright (c) 2015 msadoon. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate, CreatePostViewControllerDelegate{

    var utilityInstance:Utilities = Utilities.utilitiesInstance
    var buttonWidth:CGFloat?
    var heightOfNavBar:CGFloat?
    var postView:UIView?
    var textView:PostTextView?
    var scrollView:UIScrollView?
    var postLabel:UITextView?
    var colorPickerView:ColorPickerControl?
    var currentColor:ColorType?
    var startEditing:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        configureNavigationBar()
        setupPostSpaceAndColorPicker()
//        setupPostText()
        setupPostLabel()
        setupScrollView()
        setupKeyboardListeners()
        setupGestureRecognizers()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureNavigationBar() {
        //get rid of shadow in navigationbar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //set this up for underline and segment buttonsr
        buttonWidth = CGFloat(utilityInstance.getScreenWidth()/3)
        
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
        //right navigation bar button item
        let writePostButton:UIButton = UIButton(frame: CGRectMake(0, 0, 30.0, 30.0))
        writePostButton.addTarget(self, action: nil, forControlEvents: UIControlEvents.TouchUpInside)
        writePostButton.setBackgroundImage(UIImage(named: "2.1writepost"), forState: UIControlState.Normal)
        writePostButton.setBackgroundImage(UIImage(named: "2.1writepost"), forState: UIControlState.Selected)
        writePostButton.setBackgroundImage(UIImage(named: "2.1writepost"), forState: UIControlState.Highlighted)
        writePostButton.addTarget(self, action: "addPostToMainArray", forControlEvents: UIControlEvents.TouchUpInside)
        let newBarItemRightButton:UIBarButtonItem = UIBarButtonItem(customView: writePostButton)
        self.navigationItem.rightBarButtonItem = newBarItemRightButton
        
        //custom titleview
        let updatingChatTitleButton:UIButton = UIButton(frame: CGRectMake(0, 0, 200, 34)) //50,34 bubble icon original size
        let imageInsets:UIEdgeInsets = UIEdgeInsetsMake(0, 21, 0, 10)
        var updatingChatTitleImage:UIImage =  UIImage(named: "1.0wechat_update")!
        updatingChatTitleImage = updatingChatTitleImage.resizableImageWithCapInsets(imageInsets)
        updatingChatTitleButton.setBackgroundImage(updatingChatTitleImage, forState: UIControlState.Normal)
        updatingChatTitleButton.setBackgroundImage(updatingChatTitleImage, forState: UIControlState.Highlighted)
        updatingChatTitleButton.setBackgroundImage(updatingChatTitleImage, forState: UIControlState.Selected)
        updatingChatTitleButton.addTarget(self, action: "popBack", forControlEvents: UIControlEvents.TouchUpInside)
        
        //add a UILabel to update text from server every 3 seconds
        let serverText:UILabel = UILabel(frame: CGRectMake(21, 0, 170, 34))
        serverText.text = "Group Chat"
        serverText.textAlignment = NSTextAlignment.Center
        updatingChatTitleButton.addSubview(serverText)
        
        self.navigationItem.titleView = updatingChatTitleButton
    }
    
    func popBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func pickRandomColor(num:Int) -> UIColor{
        var applyColor:UIColor
        switch (num) {
            case 0:
                applyColor = utilityInstance.returnColorForString(ColorType.Teal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1a"), forState: UIControlState.Normal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1a"), forState: UIControlState.Highlighted)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1a"), forState: UIControlState.Selected)
                colorPickerView?.currentColorName = ColorType.Teal
                currentColor = ColorType.Teal
            case 1:
                applyColor = utilityInstance.returnColorForString(ColorType.Yellow)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1b"), forState: UIControlState.Normal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1b"), forState: UIControlState.Highlighted)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1b"), forState: UIControlState.Selected)
                colorPickerView?.currentColorName = ColorType.Yellow
                currentColor = ColorType.Yellow
            case 2:
                applyColor = utilityInstance.returnColorForString(ColorType.Gray)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1c"), forState: UIControlState.Normal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1c"), forState: UIControlState.Highlighted)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1c"), forState: UIControlState.Selected)
                colorPickerView?.currentColorName = ColorType.Gray
                currentColor = ColorType.Gray
            case 3:
                applyColor = utilityInstance.returnColorForString(ColorType.LightBlue)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1d"), forState: UIControlState.Normal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1d"), forState: UIControlState.Highlighted)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1d"), forState: UIControlState.Selected)
                colorPickerView?.currentColorName = ColorType.LightBlue
                currentColor = ColorType.LightBlue
            case 4:
                applyColor = utilityInstance.returnColorForString(ColorType.Purple)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1e"), forState: UIControlState.Normal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1e"), forState: UIControlState.Highlighted)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1e"), forState: UIControlState.Selected)
                colorPickerView?.currentColorName = ColorType.Purple
                currentColor = ColorType.Purple
            case 5:
                applyColor = utilityInstance.returnColorForString(ColorType.Orange)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1f"), forState: UIControlState.Normal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1f"), forState: UIControlState.Highlighted)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1f"), forState: UIControlState.Selected)
                colorPickerView?.currentColorName = ColorType.Orange
                currentColor = ColorType.Orange
            case 6:
                applyColor = utilityInstance.returnColorForString(ColorType.Pink)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1g"), forState: UIControlState.Normal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1g"), forState: UIControlState.Highlighted)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1g"), forState: UIControlState.Selected)
                colorPickerView?.currentColorName = ColorType.Pink
                currentColor = ColorType.Pink
            default:
                applyColor = utilityInstance.returnColorForString(ColorType.DarkBlue)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1h"), forState: UIControlState.Normal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1h"), forState: UIControlState.Highlighted)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1h"), forState: UIControlState.Selected)
                colorPickerView?.currentColorName = ColorType.DarkBlue
                currentColor = ColorType.DarkBlue
        }
        return applyColor
    }
    
    func setupPostSpaceAndColorPicker() {
        let navbarHeight = self.navigationController?.navigationBar.bounds.height as CGFloat!
        heightOfNavBar = CGFloat(navbarHeight+20)
        postView = UIView(frame: CGRectMake(0, 0, CGFloat(utilityInstance.getScreenWidth()), CGFloat(utilityInstance.getScreenHeight())-heightOfNavBar!))
        colorPickerView = ColorPickerControl(frame: CGRectMake(20, postView!.frame.height-120, 100, 100))
        colorPickerView?.allBPaths = [utilityInstance.drawTeal(),utilityInstance.drawYellow(),utilityInstance.drawOrange(),utilityInstance.drawPink(),utilityInstance.drawGray(),utilityInstance.drawPurple(),utilityInstance.drawDarkBlue(), utilityInstance.drawLightBlue()]
        let randomColorNumber = utilityInstance.rollRandomColor()
        postView!.backgroundColor = pickRandomColor(randomColorNumber)
    }

    func setupPostLabel() {
        let postContentVerticalSpacer:CGFloat = CGFloat(utilityInstance.getScreenWidth()*0.204)
        let postContentHorizontalSpacer:CGFloat = CGFloat(CGFloat(utilityInstance.getScreenWidth()) - CGFloat(213))*0.5
        postLabel = PostTextView(frame: CGRectMake(postContentHorizontalSpacer, postContentVerticalSpacer, CGFloat(213), CGFloat(183)))//same height as the cell post content label (check xib)
        postLabel?.delegate = self
        postLabel?.textContainer.lineBreakMode = NSLineBreakMode.ByWordWrapping
        postLabel?.scrollEnabled = false
        postLabel?.backgroundColor = UIColor.clearColor()
        postLabel?.textAlignment = NSTextAlignment.Center
        applyPlaceholderStyle(postLabel!, placeholderString: utilityInstance.placeHolderTextCreatePost())
    }
    
//    func setupPostText() {
//        textView = UIView(frame: CGRectMake(0, postView!.frame.height, CGFloat(utilityInstance.getScreenWidth()), 44))
//        textView!.backgroundColor = utilityInstance.UIColorFromRGB(0xCBD6DD)
//        
//        var textBox:UITextField = UITextField(frame: CGRectMake(15, 9.5, CGFloat(utilityInstance.getScreenWidth()/1.30), 25))
//        textBox.addTarget(self, action: "textDidChange:", forControlEvents: UIControlEvents.EditingChanged)
//        textBox.borderStyle = UITextBorderStyle.RoundedRect
//        textBox.backgroundColor = UIColor.whiteColor()
//        textBox.delegate = self
//        var prefSendButtonWidth:CGFloat = CGFloat(utilityInstance.getScreenWidth()/10)
//        var prefSendButtonHeight:CGFloat = prefSendButtonWidth*0.85185
//        var sendButton:UIButton = UIButton(frame: CGRectMake(textBox.frame.width+32, 9.5, prefSendButtonHeight, 25))
//        sendButton.setBackgroundImage(UIImage(named:"2.1post"), forState: UIControlState.Normal)
//        sendButton.setBackgroundImage(UIImage(named:"2.1post"), forState: UIControlState.Selected)
//        sendButton.setBackgroundImage(UIImage(named:"2.1post"), forState: UIControlState.Highlighted)
//        sendButton.addTarget(self, action: "addPostToMainArray", forControlEvents: UIControlEvents.TouchUpInside)
//        textView!.addSubview(sendButton)
//        textView!.addSubview(textBox)
//    }
    
    func setupScrollView() {
        scrollView = UIScrollView(frame: CGRectMake(0, 0, CGFloat(utilityInstance.getScreenWidth()), CGFloat(utilityInstance.getScreenHeight())-heightOfNavBar!))
        scrollView!.contentSize = CGSizeMake(CGFloat(utilityInstance.getScreenWidth()), CGFloat(utilityInstance.getScreenHeight())-heightOfNavBar!)
        scrollView!.bounces = false
        scrollView?.delaysContentTouches = false
        scrollView?.addSubview(postView!)
        scrollView?.addSubview(postLabel!)
        scrollView?.addSubview(colorPickerView!)
        self.view.addSubview(scrollView!)
    }
    
    func setupKeyboardListeners() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func setupGestureRecognizers() {
        let dismissKeyboard:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "keyboardDismissTap:")
        dismissKeyboard.delegate = self
        self.view.addGestureRecognizer(dismissKeyboard)
    }
    
    func addPostToMainArray() {
        let pContent:String = postLabel!.text!
        let newPost:Post = Post(ID:utilityInstance.getArrayForDemoPurposes().count+1, numLikes:0, numComments:0, postContent:pContent, liked:false, color: currentColor!, createdTime: "11 hours ago", createdCity: "Toronto")
        utilityInstance.addPostToDemoArray(newPost)
        popBack()
    }
    
    //MARK: TextView helper methods
    
    func applyPlaceholderStyle(txtView: UITextView, placeholderString: String) {
        txtView.textColor = UIColor.lightGrayColor()
        txtView.text = placeholderString
    }
    
    func applyNonPlaceholderStyle(txtView: UITextView)
    {
        txtView.textColor = UIColor.darkTextColor()
        txtView.alpha = 1.0
        txtView.text = ""
    }
    
    func moveCursorToStart(txtView: UITextView) {
        dispatch_async(dispatch_get_main_queue(), {
            txtView.selectedRange = NSMakeRange(0, 0)
        })
    }
    
    //MARK: Keyboard methods
    
    func keyboardWillShow(notif:NSNotification) {
        let keyboardFrame = view.convertRect(notif.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue, fromView:nil)
        scrollView!.frame = CGRectMake(0, 0, CGFloat(utilityInstance.getScreenWidth()), CGFloat(utilityInstance.getScreenHeight())-heightOfNavBar!-keyboardFrame.height)
        scrollView?.contentOffset = CGPointMake(0, keyboardFrame.size.height)
        scrollView?.scrollRectToVisible(CGRectMake(0, 0, CGFloat(utilityInstance.getScreenWidth()), 1), animated: false)
    }
    
    func keyboardWillHide(notif: NSNotification) {
        let keyboardFrame = view.convertRect(notif.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue, fromView:nil)
        scrollView!.frame = CGRectMake(0, 0, CGFloat(utilityInstance.getScreenWidth()), CGFloat(utilityInstance.getScreenHeight())-heightOfNavBar!+keyboardFrame.height)
    }
    
    //MARK: TextView Delegate Methods
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if((textView == postLabel) && (textView.text == utilityInstance.placeHolderTextCreatePost()))
        {
            moveCursorToStart(textView)

        }
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        //handle placeholder text
            if ((textView.text.characters.count >= utilityInstance.placeHolderTextCreatePost().characters.count) && !startEditing && (text.characters.count>0)) {
                applyNonPlaceholderStyle(textView)
                startEditing = true
            } else if ((text == "") && startEditing && (textView.text.characters.count == 1)) {
                startEditing = false
                applyPlaceholderStyle(textView, placeholderString: utilityInstance.placeHolderTextCreatePost())
                moveCursorToStart(textView)
                let newRange = NSMakeRange(0, 0)
                return false
        }

        //handles maximum characters and max lines
        let textViewText:NSMutableString = NSMutableString(string: textView.text)
        
        textViewText.replaceCharactersInRange(range, withString: text)
        
        let maxLines = 12
        let maxChars = 140
        var currentNumLines = 1
        var counter  = 0
        for (counter = 0; counter < textViewText.length; counter++) {
            if (NSCharacterSet.newlineCharacterSet().characterIsMember(textViewText.characterAtIndex(counter))) {
                currentNumLines++
            }
        }
        
        return ((currentNumLines <= maxLines) && ((textViewText.length-currentNumLines) <= maxChars))
    }
    
    //MARK: Gesture Recognizer Methods
    
    func keyboardDismissTap(gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //MARK: Delegate callback methods
    func changeBackgroundBasedOnColorWheel(color:ColorType) {
        currentColor = color
        self.postView?.backgroundColor = utilityInstance.returnColorForString(color)
    }
}
