//
//  ClassContentDetail.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 3/21/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit

class ClassContentDetail: NSObject {

    private var _menuTitle: String = ""
    private var _content: ClassContent = ClassContent()
    
    var menuTitle: String {
        get {
            return _menuTitle
        }
        set {
            _menuTitle = newValue
        }
    }
    
    var content: ClassContent {
        get {
            return _content
        }
        set {
            _content = newValue
        }
    }
    
    // constructor
    override init() {
        super.init()
    }
    
    init(menuTitle: String, content: ClassContent) {
        super.init()
        self.menuTitle = menuTitle
        self.content = content
    }
    
}
