//
//  NewsViewController.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 2/2/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit
import ImageSlideshow
import Material
import Haneke
import SlideMenuControllerSwift
import Toast_Swift

class NewsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var menuBarButton: UIBarButtonItem!
//    @IBOutlet var advertisingImageView: UIImageView!
    
    @IBOutlet var footerAdvImageView: UIImageView!
    
    let sectionTitles = ["បាល់ទាត់", "ប្រដាល់"]
    let sectionImages = ["soccer-ball.png", "hand.png"]
    
    var slideShows = [ClassSlide]()
    var menuList = [ClassMenu]()
    var homeContentList = [ClassHomeContent]()
    
    var indexPath: IndexPath!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if isInternetAvailable() {
            let cache = Shared.JSONCache
            cache.removeAll()
        } else {
            self.view.makeToast("No Internet Connection", duration: 3.0, position: .top)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        setSlideShow()
        setMenuList()
        
        footerAdvImageView.image = UIImage(named: "keila_daily_adv.png")
        
//        advertisingImageView.contentScaleMode = .scaleAspectFill
//        advertisingImageView.slideshowInterval = 10.0
//        footerAdvImageView.contentScaleMode = .scaleAspectFill
//        footerAdvImageView.slideshowInterval = 10.0
//        
//        advertisingImageView.setImageInputs([
//            ImageSource(image: UIImage(named: "keila_daily_adv.png")!),
//            ImageSource(image: UIImage(named: "komsandialy_advertising.png")!),
//            ImageSource(image: UIImage(named: "pisnoka_kd_ads.png")!)
//            ])
//        
//        footerAdvImageView.setImageInputs([
//            ImageSource(image: UIImage(named: "keila_daily_adv.png")!),
//            ImageSource(image: UIImage(named: "komsandialy_advertising.png")!),
//            ImageSource(image: UIImage(named: "pisnoka_kd_ads.png")!)
//        ])
        
        tableView.separatorInset = .zero
        tableView.register(UINib.init(nibName: "NewsListTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        setSlideShow()
        setMenuList()
    }
    
    func headerViewTap(_ gesture: UITapGestureRecognizer) {
        let tag = (gesture.view?.tag)!
        let homeContent = homeContentList[tag-1]
        let vc = self.parent as! MainViewController
        vc.vcCategoryData = [homeContent.contentList[0].contentCatID.toString(), homeContent.menuTitle]
        vc.setViewController(index: 2)   
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        return menuList.count + 1
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
//        if homeContentList.count == 0 { return 1 }
//        return homeContentList[section-1].contentList.count + 1
        if homeContentList.count == 0 { return 0 }
        return homeContentList[section-1].contentList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: .init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        if section == 0 { return headerView }
        headerView.backgroundColor = ReferenceValues.homePageHeaderViewColor
        
//        let imgView = UIImageView(frame: .init(x: 5, y: 5, width: 30, height: 30))
//        
//        let titleLabel = UILabel(frame: .init(x: 40, y: 5, width: tableView.frame.width-imgView.frame.width, height: 30))
        let titleLabel = UILabel(frame: .init(x: 10, y: 5, width: tableView.frame.width-20, height: 20))
        titleLabel.text = menuList[section-1].title
        titleLabel.textColor = UIColor.init(red: 226/255, green: 111/255, blue: 132/255, alpha: 1)
        
//        headerView.addSubview(imgView)
        headerView.addSubview(titleLabel)
        headerView.tag = section
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.headerViewTap(_ :)))
        headerView.isUserInteractionEnabled = true
        headerView.addGestureRecognizer(tap)
        view.addSubview(headerView)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 }
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 && indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReferenceValues.newsListTableHeaderCellIdentifier) as! NewsHeaderTableViewCell
            
            var inputs = [InputSource]()
            for slideShow in slideShows {
                inputs.append(SDWebImageSource(url: URL(string: slideShow.slideImage)!))
            }
            cell.advertisingImageView.image = UIImage(named: "komsandialy_advertising.png")
            cell.newsHeaderSlideShow.setImageInputs(inputs)
            let lbl = UILabel()
            lbl.tag = 100
            lbl.translatesAutoresizingMaskIntoConstraints = false
            cell.newsHeaderSlideShow.addSubview(lbl)
            let lblBConstraint = NSLayoutConstraint(item: lbl, attribute: .bottom, relatedBy: .equal, toItem: cell.newsHeaderSlideShow, attribute: .bottom, multiplier: 1, constant: -2)
            let lblTConstraint = NSLayoutConstraint(item: lbl, attribute: .trailing, relatedBy: .equal, toItem: cell.newsHeaderSlideShow, attribute: .trailing, multiplier: 1, constant: -5)
            let lblLConstraint = NSLayoutConstraint(item: lbl, attribute: .left, relatedBy: .equal, toItem: cell.newsHeaderSlideShow, attribute: .left, multiplier: 1, constant: 5)
            let lblHConstraint = NSLayoutConstraint(item: lbl, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .height, multiplier: 1, constant: 150)
            cell.newsHeaderSlideShow.addConstraints([lblBConstraint, lblTConstraint, lblLConstraint, lblHConstraint])
            lbl.font = UIFont(name: lbl.font.fontName, size: 12)
            lbl.textColor = UIColor.black
            lbl.numberOfLines = 0
            cell.newsHeaderSlideShow.currentPageChanged = { page in
                let label = cell.newsHeaderSlideShow.viewWithTag(100) as! UILabel
                label.text = ""
                label.text = self.slideShows[page].slideTitle
            }
            lbl.backgroundColor = UIColor(red: 232/255, green: 235/255, blue: 239/255, alpha: 0.7)
            cell.selectionStyle  = .none
            return cell
        }
        
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: ReferenceValues.newsByCategoryHeaderCellIdentifier) as! NewsByCategoryHeaderTableViewCell
//            cell.headerCategoryImageView.sd_setImage(with: URL(string: "http://www.hotelroomsearch.net/im/hotels/gb/seashore-2.jpg")!)
//            return cell
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReferenceValues.newsListTableCellIdentifier) as! NewsListTableViewCell
        
        if homeContentList.count <= 0 {
            return cell
        }
        
        let homeContent = homeContentList[indexPath.section-1]
//        let content = homeContent.contentList[indexPath.row-1]
        let content = homeContent.contentList[indexPath.row]
        cell.newsDateTimeLabel.text = content.contentPublishDate
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        style.minimumLineHeight = 20
        let attribute = [
            NSParagraphStyleAttributeName: style
        ]
        let attrString = NSAttributedString(string: content.contentTitle, attributes: attribute)
        cell.newsTitleLabel.attributedText = attrString
        cell.newsImageView.sd_setImage(with: URL(string: content.contentMedia)!)
        
        //        if homeContent.contentList[indexPath.row-1].contentCatID == menuList[indexPath.section].id {
        //            let content = homeContentList[indexPath.section].contentList[indexPath.row]
        //            //            cell.newsImageView.sd_setImage(with: URL(string: content.contentMedia)!)
        //            cell.newsDateTimeLabel.text = content.contentPublishDate
        //            cell.newsTitleLabel.text = content.contentTitle
        //        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && indexPath.section == 0 {
            return CGFloat(ReferenceValues.newsListTableHeaderCellHeight)
        }
//        if indexPath.row == 0 {
//            return CGFloat(ReferenceValues.newsByCategoryHeaderCellHeight)
//        }
        return CGFloat(ReferenceValues.newsListTableCellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 && indexPath.section == 0 {
            return
        }
        let vc = self.parent as! MainViewController
        let homeContent = homeContentList[indexPath.section-1]
//        let content = homeContent.contentList[indexPath.row-1]
        let content = homeContent.contentList[indexPath.row]
        let contentDetail = ClassContentDetail(menuTitle: homeContent.menuTitle, content: content)
        vc.content = contentDetail
        vc.setViewController(index: 1)
    }
}

// MARK: JSON DATA
extension NewsViewController {
    // get slide show
    func setSlideShow() {
        let cache = Shared.JSONCache
        let getSlideShowURL = URL(string: MyService.keilaSlideShow)!
        cache.fetch(URL: getSlideShowURL)
            .onSuccess { (JSON) in
                let slides = JSON.dictionary["SlideShow"] as! NSArray
                self.slideShows.removeAll()
                for i in 0..<slides.count {
                    let slide = slides[i] as! NSDictionary
                    self.slideShows.append(ClassSlide(slideID: (slide["slide_id"] as! String).toInt(),
                                                      slideTitle: slide["s_title"] as! String,
                                                      slideDescription: slide["s_description"] as! String,
                                                      slideLink: slide["link"] as! String,
                                                      slideImage: slide["s_img"] as! String,
                                                      slideOrdering: (slide["ordering"] as! String).toInt()
                        )
                    )
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            .onFailure { (err) in
                print("\(err?.localizedDescription)")
        }
    }
    
    // get menu list
    func setMenuList() {
        let cache = Shared.JSONCache
        let getMenuURL = URL(string: MyService.keilaMenuList)!
        cache.fetch(URL: getMenuURL)
            .onSuccess { (json) in
                let menus = json.dictionary?["Menu"] as! NSArray
                self.menuList.removeAll()
                for i in 0..<menus.count {
                    let menu = menus[i] as! NSDictionary
                    if (menu["c_id"]! as! String).toInt() == 1 { continue }
                    self.menuList.append(ClassMenu(id: (menu["c_id"]! as! String).toInt(),
                                                   title: menu["c_title"]! as! String
                        )
                    )
                }
                DispatchQueue.main.async {
                    self.setHomeContentList(number: 5)
                    //                    self.tableView.reloadData()
                }
            }
            .onFailure { (err) in
                print("\(err?.localizedDescription)")
        }
    }
    
    // set home content list
    func setHomeContentList(number: Int) {
        let cache = Shared.JSONCache
        let contentURL = URL(string: MyService.keilaHomeContentWithNumber(number))!
        cache.fetch(URL: contentURL)
            .onSuccess { (JSON) in
                let json = JSON.dictionary?["Content"] as! NSDictionary
                for menuIndex in 0..<self.menuList.count {
                    let jsonByCategory = json[self.menuList[menuIndex].title] as! NSArray
                    let homeContent = ClassHomeContent.init()
                    homeContent.menuTitle = self.menuList[menuIndex].title
                    for i in 0..<jsonByCategory.count {
                        let content = jsonByCategory[i] as! NSDictionary
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
                        homeContent.contentList.append(
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
                    self.homeContentList.append(homeContent)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            .onFailure { (err) in
                print("\(err?.localizedDescription)")
        }
    }
}
