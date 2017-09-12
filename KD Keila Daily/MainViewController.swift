//
//  MainViewController.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 3/30/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class MainViewController: UIViewController {
    
    var isNewsDetailFirstTime: Bool = true
    
    @IBOutlet weak var contentView: UIView!
    var buttons: [UIButton]!
    @IBOutlet weak var tabBarView: UIView!
    
    var viewControllers: [UIViewController]!
    var content = ClassContentDetail()
    var vcCategoryData: [String]!
    
    var newsViewController: UIViewController!
    var newsDetailViewController: UIViewController!
    var newsByCategoryViewController: UIViewController!
    var videoViewController: UIViewController!
    var selectedIndex: Int = 0
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.tag = 100
        contentView.tag = 101
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
//        let imgView = UIImageView(image: UIImage(named: "kd-logo-r.png")!)
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "kd-logo-r.png")
        navigationItem.titleView = imgView
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        newsViewController = storyboard.instantiateViewController(withIdentifier: "NewsViewController")
        newsDetailViewController = storyboard.instantiateViewController(withIdentifier: "NewsDetailViewController")
        newsByCategoryViewController = storyboard.instantiateViewController(withIdentifier: "NewsByCategoryViewController")
        videoViewController = storyboard.instantiateViewController(withIdentifier: "VideoViewController")
        viewControllers = [newsViewController, newsDetailViewController, newsByCategoryViewController, videoViewController]
        
        setViewController(index: selectedIndex)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        
        setBarButtons()
    }
    
    func setViewController(index: Int) {
        let previousIndex = selectedIndex
        selectedIndex = index
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        if selectedIndex == 1 {
            let vc = viewControllers[selectedIndex] as! NewsDetailViewController
            vc.content = content
            if !isNewsDetailFirstTime {
                vc.viewDidLoad()
            }
            isNewsDetailFirstTime = false
            addChildViewController(vc)
            vc.view.frame = contentView.bounds
            contentView.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
        } else if selectedIndex == 2 {
            let vc = viewControllers[selectedIndex] as! NewsByCategoryViewController
            vc.catID = Int(vcCategoryData[0])!
            vc.menuTitle = vcCategoryData[1]
            addChildViewController(vc)
            vc.view.frame = contentView.bounds
            contentView.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
        } else if selectedIndex == 3 {
            let vc = viewControllers[selectedIndex] as! VideoViewController
            vc.viewDidLoad()
            addChildViewController(vc)
            vc.view.frame = contentView.bounds
            contentView.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
        }else {
            let vc = viewControllers[selectedIndex] as! NewsViewController
            vc.viewDidLoad()
            addChildViewController(vc)
            vc.view.frame = contentView.bounds
            contentView.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
        }
    }
    
    func setBarButtons(){
        
        let totalWidth = self.view.frame.width
        let totalHeight = tabBarView.frame.height
        
        let newsButton = UIImageView(frame: CGRect(x: (totalWidth/3-30)/2, y: (totalHeight-30)/2, width: 30, height: 30))
        newsButton.image = UIImage(named: "newspaper.png")
        
        let videoButton = UIImageView(frame: CGRect(x: totalWidth/3 + (totalWidth/3-30)/2, y: (totalHeight-30)/2, width: 30, height: 30))
        videoButton.image = UIImage(named: "play-button.png")
        
        let liveButton = UIImageView(frame: CGRect(x: (totalWidth/3)*2 + (totalWidth/3-30)/2, y: (totalHeight-30)/2, width: 30, height: 30))
        liveButton.image = UIImage(named: "spotify-logo.png")
        
        newsButton.isUserInteractionEnabled = true
        videoButton.isUserInteractionEnabled = true
        liveButton.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.openNews))
        newsButton.addGestureRecognizer(tap)
        
        let videoTap = UITapGestureRecognizer(target: self, action: #selector(self.openVideo))
        videoButton.addGestureRecognizer(videoTap)
        
        tabBarView.addSubview(newsButton)
        tabBarView.addSubview(videoButton)
        tabBarView.addSubview(liveButton)
        
    }
    
    func openNews() {
        if selectedIndex == 0 {
            return
        }
        setViewController(index: 0)
    }
    
    func openVideo() {
        setViewController(index: 3)
    }

}

extension MainViewController: SlideMenuControllerDelegate {
    
    func leftWillOpen() {
    }
    
    func leftDidOpen() {
    }
    
    func leftWillClose() {
    }
    
    func leftDidClose() {
    }
    
    func rightWillOpen() {
    }
    
    func rightDidOpen() {
    }
    
    func rightWillClose() {
    }
    
    func rightDidClose() {
    }
    
}
