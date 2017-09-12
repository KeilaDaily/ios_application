//
//  NewsByCategoryMainViewController.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 3/31/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit

class NewsByCategoryMainViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet var buttons: [UIButton]!
    
    var isFirstTimeNewsDetail: Bool = true
    var newsByCategoryViewController: UIViewController!
    var newsDetailViewController: UIViewController!
    var vcCategoryData: [String]!
    var content = ClassContentDetail()
    
    var selectedIndex: Int = 0
    var viewControllers: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "kd-logo-r.png")
        navigationItem.titleView = imgView
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewsByCategoryViewController") as! NewsByCategoryViewController
        vc.catID = Int(vcCategoryData[0])!
        vc.menuTitle = vcCategoryData[1]
        newsByCategoryViewController = vc
        
        newsDetailViewController = storyboard.instantiateViewController(withIdentifier: "NewsDetailViewController")
        viewControllers = [newsByCategoryViewController, newsDetailViewController]
        
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
            if !isFirstTimeNewsDetail {
                vc.viewDidLoad()
            }
            isFirstTimeNewsDetail = false
            addChildViewController(vc)
            vc.view.frame = contentView.bounds
            contentView.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
        } else {
            let vc = viewControllers[selectedIndex]
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
    
}
