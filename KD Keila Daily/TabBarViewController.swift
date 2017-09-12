//
//  TabBarViewController.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 2/4/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class TabBarViewController: UITabBarController {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBar.unselectedItemTintColor = UIColor.white
        self.tabBar.tintColor = UIColor.lightGray
        self.tabBar.barTintColor = UIColor.init(red: 206/255, green: 123/255, blue: 105/255, alpha: 1)
        
        self.setNavigationBarItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}


extension TabBarViewController: SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
    
}
