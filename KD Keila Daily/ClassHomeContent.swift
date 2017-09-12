//
//  ClassHomeContent.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 3/19/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit

class ClassHomeContent: NSObject {

    // data member
    private var _menu: String = ""
    private var _contentList = [ClassContent]()
 
    // property
    var menuTitle: String {
        get {
            return _menu
        }
        set {
            _menu = newValue
        }
    }
    
    var contentList: [ClassContent] {
        get {
            return _contentList
        }
        set {
            _contentList = newValue
        }
    }
    
    // constructor
    override init() {
        super.init()
    }
    
    init(menuTitle: String, contentList: [ClassContent]) {
        super.init()
        self.menuTitle = menuTitle
        self.contentList = contentList
    }
    
}
