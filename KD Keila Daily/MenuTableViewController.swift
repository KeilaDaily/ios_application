//
//  MenuTableViewController.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 2/2/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit
import Material
import Haneke
import SlideMenuControllerSwift

class MenuTableViewController: UITableViewController {
    
    var mainViewController: UIViewController!
    var newsByCategoryViewController: UIViewController!
    
    let personalMenu: [String] = ["អំពីយើង", "ទាក់ទងយើង", "ផ្សាយពាណិជ្ជកម្ម", "Developed by IBS"]
    var menuList = [ClassMenu]()
    
    let images: [UIImage] = [UIImage(named: "user-silhouette.png")!, UIImage(named: "nut-icon.png")!, UIImage(named: "rate-star-button.png")!]
    
//    var mainViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if isInternetAvailable() {
            let cache = Shared.JSONCache
            cache.removeAll()
        }
        
        setMenuList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        setMenuList()
        
    }

    // MARK: - JSON Data
    func setMenuList() {
        let cache = Shared.JSONCache
        let getMenuURL = URL(string: MyService.keilaMenuList)!
        cache.fetch(URL: getMenuURL)
            .onSuccess { (json) in
                let menus = json.dictionary?["Menu"] as! NSArray
                self.menuList.removeAll()
                for i in 0..<menus.count {
                    let menu = menus[i] as! NSDictionary
                    self.menuList.append(ClassMenu(id: (menu["c_id"]! as! String).toInt(),
                                              title: menu["c_title"]! as! String,
                                              c_is_show: (menu["c_is_show"]! as! String).toInt(),
                                              type: (menu["c_type"]! as! String).toInt(),
                                              mainId: (menu["c_main_id"]! as! String).toInt(),
                                              ordering: (menu["ordering"]! as! String).toInt()
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
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (menuList.count + personalMenu.count + 1)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 { return 90 }
        return 40
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if indexPath.row == 0 {
            let keilaImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
            keilaImageView.contentMode = .scaleToFill
            keilaImageView.image = UIImage(named: "keila_daily_menu.png")
            cell.addSubview(keilaImageView)
            return cell
        }
        
        if menuList.count == 0 {
            return cell
        }
        
        if indexPath.row >= (menuList.count+1) {
            if indexPath.row == (menuList.count + personalMenu.count) {
                cell.textLabel?.font = Font.italicSystemFont(ofSize: 12)
                cell.textLabel?.text = personalMenu[indexPath.row - (menuList.count + 1)]
                cell.selectionStyle = .none
            } else {
                cell.textLabel?.text = personalMenu[indexPath.row - (menuList.count + 1)]
                cell.imageView?.image = images[indexPath.row - (menuList.count + 1)]
            }
            cell.backgroundColor = ReferenceValues.customMenuListColor
            return cell
        }
        
//        cell.imageView?.image = images[indexPath.row]
//        cell.textLabel?.text = titles[indexPath.row]
        cell.textLabel?.text = menuList[indexPath.row-1].title
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < 1 { return }
        if indexPath.row == 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainView = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            self.mainViewController = UINavigationController(rootViewController: mainView)
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        }
        if indexPath.row <= menuList.count && indexPath.row > 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newsByCategory = storyboard.instantiateViewController(withIdentifier: "NewsByCategoryMainViewController") as! NewsByCategoryMainViewController
            newsByCategory.vcCategoryData = [menuList[indexPath.row-1].id.toString(), menuList[indexPath.row-1].title]
            self.newsByCategoryViewController = UINavigationController(rootViewController: newsByCategory)
            self.slideMenuController()?.changeMainViewController(newsByCategoryViewController, close: true)
        }
    }
    
}
