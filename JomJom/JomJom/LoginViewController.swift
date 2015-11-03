//
//  ViewController.swift
//  JomJom
//
//  Created by Mubarak Sadoon on 2015-05-05.
//  Copyright (c) 2015 msadoon. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var BackgroundImageView: UIImageView!
    @IBOutlet weak var LogoImageView: UIImageView!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var FacebookLogo: UIImageView!
    @IBOutlet weak var FacebookLogin: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupBackground()
    }
    
    override func viewWillAppear(animated: Bool) {
        configureNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UI Methods
    func setupBackground() {
        BackgroundImageView.backgroundColor = UIColor(patternImage: UIImage(named: "0.tile_back")!)
    }

    func configureNavigationBar() {
        self.navigationController?.navigationBarHidden = true
    }

    
    //MARK: IBActions
    
    @IBAction func loginWithFacebook(sender: AnyObject) {
        let allPostsVC:AllPostsViewController = AllPostsViewController.init(nibName:"AllPostsViewController", bundle:nil)
        self.navigationController?.pushViewController(allPostsVC, animated: true)
    }
}

