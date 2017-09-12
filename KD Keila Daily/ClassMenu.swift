//
//  ClassMenu.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 3/15/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit

class ClassMenu: NSObject {

    // data members
    private var c_id: Int = 0
    private var c_title: String = ""
    private var c_is_show: Int = 0
    private var c_type: Int = 0
    private var c_main_id: Int = 0
    private var _ordering: Int = 0
    
    // properties
    var id: Int {
        get { return c_id }
        set { c_id = newValue }
    }
    
    var title: String {
        get { return c_title }
        set { c_title = newValue }
    }
    
    var cIsShow: Int {
        get { return c_is_show }
        set { c_is_show = newValue }
    }
    
    var type: Int {
        get { return c_type }
        set { c_type = newValue }
    }
    
    var mainId: Int {
        get { return c_main_id }
        set { c_main_id = newValue }
    }
    
    var ordering: Int {
        get { return _ordering }
        set { _ordering = newValue }
    }
    
    // constructor
    override init() {
        super.init()
    }
    
    init(id: Int, title: String, c_is_show                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          : Int, type: Int, mainId: Int, ordering: Int) {
        super.init()
        self.id = id
        self.title = title
        self.cIsShow = c_is_show
        self.type = type
        self.mainId = mainId
        self.ordering = ordering
    }

    init(id: Int, title: String) {
        super.init()
        self.id = id
        self.title = title
    }
    
    func toString() -> String {
        return "\(self.id) \(self.title)"
    }
 
    // Functions
    
    
}


