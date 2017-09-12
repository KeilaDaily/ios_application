//
//  NewsByCategoryViewController.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 3/17/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit
import Haneke
import Toast_Swift

class NewsByCategoryViewController: UIViewController {

    @IBOutlet var advertisingImageView: UIImageView!
    @IBOutlet var menuTitleLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    var catID: Int = 0
    var menuTitle: String = ""
    
    @IBAction func Close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    struct Menu {
        var menuID: Int
        var menuName: String
        init(menuID: Int, menuName: String) {
            self.menuID = menuID
            self.menuName = menuName
        }
    }
    
    var contentMenu: Menu?
    var contentListByCategory = [ClassContent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        
        if isInternetAvailable() {
            let cache = Shared.JSONCache
            cache.removeAll()
        } else {
            self.view.makeToast("No Internet Connection", duration: 3.0, position: .top)
        }
        
        advertisingImageView.image = UIImage(named: "keila_daily_adv")
        menuTitleLabel.text = menuTitle
        getNewsByCategory()
    }

}

extension NewsByCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentListByCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReferenceValues.newsByCategoryCollectionViewCellIdentifier, for: indexPath) as! NewsByCategoryCollectionViewCell
        
        let content = contentListByCategory[indexPath.item]
        
        cell.newsImageView.sd_setImage(with: URL(string: content.contentMedia)!)
        cell.countLabel.text = content.contentCount.toString()
        cell.dateLabel.text = content.contentPublishDate
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        style.minimumLineHeight = 20
        let attributes = [
            NSParagraphStyleAttributeName: style
        ]
        let attrString = NSAttributedString(string: content.contentTitle, attributes: attributes)
        cell.newsTitleLabel.attributedText = attrString
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = self.parent as? NewsByCategoryMainViewController {
            let contentDetail = ClassContentDetail(menuTitle: menuTitle, content: contentListByCategory[indexPath.item])
            vc.content = contentDetail
            vc.setViewController(index: 1)
        } else {
            let vc = self.parent as! MainViewController
            let contentDetail = ClassContentDetail(menuTitle: menuTitle, content: contentListByCategory[indexPath.item])
            vc.content = contentDetail
            vc.setViewController(index: 1)
        }
    }
    
    
    
}

extension NewsByCategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 5
        let height = 150
        return CGSize(width: width, height: CGFloat(height))
    }
    
}

// MARK: - JSON Data
extension NewsByCategoryViewController {
    func getNewsByCategory() {
        let cache = Shared.JSONCache
        let newsByCategoryURL = URL(string: MyService.keilaContentsByCategory(catID))!
//        let newsByCategoryURL = URL(string: MyService.keilaContents(catID, 11))!
        cache.fetch(URL: newsByCategoryURL).onSuccess { (JSON) in
            let json = JSON.dictionary?["Content"] as! NSArray
            self.contentListByCategory.removeAll()
            for i in 0..<json.count {
                let content = json[i] as! NSDictionary
                var tag = "", mediaTitle = ""
                if content["tag"] is NSNull {
                    tag = ""
                } else {
                    tag = content["tag"] as! String
                }
                if content["media_title"] is NSNull {
                    mediaTitle = ""
                } else {
                    mediaTitle = content["media_title"] as! String
                }
                self.contentListByCategory.append(
                    ClassContent(contentID: (content["id"] as! String).toInt(),
                                 contentDescription: content["description"] as! String,
                                 contentFullText: content["full_text"] as! String,
                                 contentTitle: content["text_title"] as! String,
                                 contentCatID: (content["cat_id"] as! String).toInt(),
                                 contentCreateDate: content["create_date"] as! String,
                                 contentMemberID: (content["member_id"] as! String).toInt(),
                                 contentDisplay: content["display"] as! String,
                                 contentCount: (content["count"] as! String).toInt(),
                                 contentFeature: (content["feature"] as! String).toInt(),
                                 contentPublishDate: content["publish_date"] as! String,
                                 contentMedia: content["media"] as! String,
                                 contentMediaTitle: mediaTitle,
                                 contentMediaPublish: (content["media_publish"] as! String).toInt(),
                                 contentTag: tag,
                                 contentIcon: content["icon"] as! String,
                                 contentDeleteStatue: (content["delete_statue"] as! String).toInt()
                    )
                )
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
}

