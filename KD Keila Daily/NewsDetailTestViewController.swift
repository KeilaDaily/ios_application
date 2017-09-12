//
//  NewsDetailTestViewController.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 3/21/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit

class NewsDetailTestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var splitString = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splitString = any("<img https://media.licdn.com/mpr/mpr/shrinknp_200_200/p/8/005/02d/335/19f24eb.jpg/>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. <img https://media.licdn.com/mpr/mpr/shrinknp_200_200/p/8/005/02d/335/19f24eb.jpg/>It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.separatorColor = .white
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.reloadData()
    }
    
    
    
}

extension NewsDetailTestViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 + splitString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")

        if indexPath.row >= 5 && splitString.count <= 0 { return cell }
        
        makeView(cell: cell, index: indexPath.row)

        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        if row == 0 {
            return 50
        }
        if row == 1 {
            return 100
        }
        if row == 2 {
            return 30
        }
        if row >= 5 && isImage(index: row) {
            return 100
        }
        return UITableViewAutomaticDimension
    }
    
    
}

extension NewsDetailTestViewController {
    
    func makeView(cell: UITableViewCell, index: Int) {
        
        switch (index) {
        case 0:
            let imageView = makeImageView(0, 0, cell.width, 50)
            imageView.image = UIImage(named: "keila_daily_adv")
            cell.addSubview(imageView)
            break
        case 1:
            let imageView = makeImageView(cell.width*0.2, 0, cell.width-(cell.width*0.4), 100)
            imageView.contentMode = .scaleToFill
            imageView.image = UIImage(named: "keila_daily_adv1")
            cell.addSubview(imageView)
            break
        case 2:
            cell.textLabel?.text = "កីឡា"
            cell.textLabel?.textColor = UIColor.init(red: 226/255, green: 111/255, blue: 132/255, alpha: 1)
            cell.backgroundColor = UIColor.init(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
            break
        case 3:
            cell.textLabel?.text = "ណាតាហ្សា និង Booysen ធ្លាប់គ្រោងបើកហាងលក់សម្លៀកបំពាក់"
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textColor = UIColor(red: 0, green: 21/255, blue: 1, alpha: 1)
            cell.textLabel?.font = UIFont(name: (cell.textLabel?.font.fontName)!, size: 17)
            break
        case 4:
            break
        default:
            var content = splitString[index-5]
            if content.contains("<img") {
                let imageView = makeImageView(cell.width*0.2, 0, cell.width-(cell.width*0.4), 100)
                imageView.contentMode = .scaleToFill
//                imageView.image = UIImage(named: "keila_daily_adv1")
                content = content.components(separatedBy: "<img ")[1]
                imageView.sd_setImage(with: URL(string: content))
                cell.addSubview(imageView)
            } else {
                cell.textLabel?.text = content
                cell.textLabel?.textAlignment = .justified
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.font = UIFont(name: (cell.textLabel?.font.fontName)!, size: 12)
            }
            
            break
        }
        
        
    }
    
    func isImage(index: Int) -> Bool {
        if splitString[index-5].contains("<img") {
            return true
        }
        return false
    }
    
    func any(_ str: String) -> [String] {
        
        var spString = [String]()
        let firstSplit = str.components(separatedBy: "/>")
        
        for st in firstSplit {
            if st.contains("<img") {
                let imageSt = st.components(separatedBy: "<img ")

                // string contains text and image url
                if !imageSt[0].isEmpty {
                    spString.append(imageSt[0])
                }
                spString.append("<img " + imageSt[1])
                
            } else {
                spString.append(st)
            }
        }
        
        return spString

    }
    
    func makeTextLabel(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> UILabel {
        let lbl = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        [lbl].forEach {
            $0.numberOfLines = 0
        }
        
        return lbl
    }
    
    func makeImageView(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
        
        return imageView
    }
}
