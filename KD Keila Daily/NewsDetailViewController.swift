//
//  NewsDetailViewController.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 3/6/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var splitString = [String]()
    
    var content = ClassContentDetail()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
//        [content.content].forEach {
//            newsTitle.text = $0.contentTitle
//            dateLabel.text = $0.contentPublishDate
//            numberViewLabel.text = $0.contentCount.toString()
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitString = any(content.content.contentFullText)
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.separatorColor = .white
        //        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.reloadData()

    }
    
}

extension NewsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        if row == 4 {
            return 18
        }
        if row >= 5 && isImage(index: row) {
            return 100
        }
        return UITableViewAutomaticDimension
    }
    
}

extension NewsDetailViewController {
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
            cell.textLabel?.text = content.menuTitle
            cell.textLabel?.textColor = UIColor.init(red: 226/255, green: 111/255, blue: 132/255, alpha: 1)
            cell.backgroundColor = UIColor.init(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
            break
        case 3:
            cell.textLabel?.text = content.content.contentTitle
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textColor = UIColor(red: 0, green: 21/255, blue: 1, alpha: 1)
            cell.textLabel?.font = UIFont(name: (cell.textLabel?.font.fontName)!, size: 17)
            break
        case 4:
            cell.textLabel?.text = content.content.contentPublishDate + "   " + content.content.contentCount.toString()
            cell.textLabel?.font = UIFont(name: (cell.textLabel?.font.fontName)!, size: 9)
            cell.textLabel?.textColor = UIColor.gray
            break
        default:
            var content = splitString[index-5]
            if content.contains("<img") {
                let imageView = makeImageView(cell.width*0.2, 0, cell.width-(cell.width*0.4), 100)
                imageView.contentMode = .scaleToFill
                //                imageView.image = UIImage(named: "keila_daily_adv1")
                content = content.components(separatedBy: "<img ")[1]
                imageView.sd_setImage(with: content.toURL())
                cell.addSubview(imageView)
            } else {
//                cell.textLabel?.text = content
                let stringValue = content
//                let attrString = NSMutableAttributedString(string: stringValue)
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 5
                style.minimumLineHeight = 16                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
//                attrString.addAttribute(characterAttribute: CharacterAttribute(rawValue: NSParagraphStyleAttributeName), value: style, range: NSRange(location: 0, length: stringValue.characters.count))
                let attribute = [
                    NSParagraphStyleAttributeName: style
                ]
                let attrString = NSAttributedString(string: stringValue, attributes: attribute)
                cell.textLabel?.attributedText = attrString
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
