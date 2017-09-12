//
//  ViewController.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 1/21/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit
import SideMenu

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: self)
        menuLeftNavigationController.leftSide = true
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
    }

    @IBAction func click(_ sender: Any) {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
//        dismiss(animated: true, completion: nil)
    }

}

