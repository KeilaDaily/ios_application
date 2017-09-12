//
//  LeftViewController.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 3/29/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class LeftViewController: UIViewController {

    var mainViewController: UIViewController!
    var selectViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let selectVC = storyboard.instantiateViewController(withIdentifier: "SelectViewController") as! SelectViewController
        self.selectViewController = UINavigationController(rootViewController: selectVC)
    }
    
    @IBAction func clickme(_ sender: UIButton) {
        self.slideMenuController()?.changeMainViewController(self.selectViewController, close: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
