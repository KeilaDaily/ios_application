//
//  NewsHomePageViewController.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 3/17/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//


import UIKit
import ImageSlideshow
import Material
import Haneke
/*
class NewsHomePageViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let sectionTitles = ["បាល់ទាត់", "ប្រដាល់"]
    let sectionImages = ["soccer-ball.png", "hand.png"]
    
    var slideShows = [ClassSlide]()
    var menuList = [ClassMenu]()
    var homeContentList = [ClassHomeContent]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let cache = Shared.JSONCache
        cache.removeAll()
        setSlideShow()
        setMenuList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView.separatorColor = UIColor.white
        tableView.separatorInset = .zero
        tableView.register(UINib.init(nibName: "NewsListTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        setSlideShow()
        setMenuList()
    }
    
}

extension NewsHomePageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuList.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        if homeContentList.count == 0 { return 1 }
        return homeContentList[section-1].contentList.count + 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: .init(x: 0, y: 0, width: tableView.frame.width, height: 40))
        if section == 0 { return headerView }
        headerView.backgroundColor = ReferenceValues.homePageHeaderViewColor
        
        let imgView = UIImageView(frame: .init(x: 5, y: 5, width: 30, height: 30))
        
        let titleLabel = UILabel(frame: .init(x: 40, y: 5, width: tableView.frame.width-imgView.frame.width, height: 30))
        titleLabel.text = menuList[section-1].title
        titleLabel.textColor = UIColor.init(red: 226/255, green: 111/255, blue: 132/255, alpha: 1)
        
        headerView.addSubview(imgView)
        headerView.addSubview(titleLabel)
        view.addSubview(headerView)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 }
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 && indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReferenceValues.newsListTableHeaderCellIdentifier) as! NewsHeaderTableViewCell
            cell.advertisingImageView.image = UIImage(named: "keila_daily_adv.png")
            var inputs = [InputSource]()
            for slideShow in slideShows {
                inputs.append(SDWebImageSource(url: URL(string: slideShow.slideImage)!))
            }
            cell.newsHeaderSlideShow.setImageInputs(inputs)
            cell.selectionStyle  = .none
            return cell
        }
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReferenceValues.newsByCategoryHeaderCellIdentifier) as! NewsByCategoryHeaderTableViewCell
            cell.headerCategoryImageView.sd_setImage(with: URL(string: "http://www.hotelroomsearch.net/im/hotels/gb/seashore-2.jpg")!)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReferenceValues.newsListTableCellIdentifier) as! NewsListTableViewCell
        
        if homeContentList.count <= 0 {
            return cell
        }
        
        let homeContent = homeContentList[indexPath.section-1]
        let content = homeContent.contentList[indexPath.row-1]
        cell.newsDateTimeLabel.text = content.contentPublishDate
        cell.newsTitleLabel.text = content.contentTitle
        cell.newsImageView.sd_setImage(with: URL(string: content.contentMedia)!)
        cell.backgroundColor = ReferenceValues.homePageNewsListColor
        customSeparator(cell: cell)
        
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
        if indexPath.row == 0 {
            return CGFloat(ReferenceValues.newsByCategoryHeaderCellHeight)
        }
        return CGFloat(ReferenceValues.newsListTableCellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func customSeparator(cell: UITableViewCell) {
        let separator = UIView(frame: CGRect(x: 0, y: cell.frame.height - 5, width: cell.frame.width, height: 5))
        separator.backgroundColor = UIColor.white
        cell.addSubview(separator)
    }
}

// MARK: JSON DATA
extension NewsHomePageViewController {
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
                    print("jsonByCategory \(self.menuList[menuIndex].title) \(jsonByCategory.count)")
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
*/
