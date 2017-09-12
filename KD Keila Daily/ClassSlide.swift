//
//  ClassSlide.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 3/16/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit

class ClassSlide: NSObject {

    // Data members
    private var slide_id: Int = 0
    private var s_title: String = ""
    private var s_description: String = ""
    private var link: String = ""
    private var s_img: String = ""
    private var _ordering: Int = 0
    
    // properties
    var slideID: Int {
        get {
            return slide_id
        }
        set {
            slide_id = newValue
        }
    }
    
    var slideTitle: String {
        get {
            return s_title
        }
        set {
            s_title = newValue
        }
    }
    
    var slideDescription: String {
        get {
            return s_description
        }
        set {
            s_description = newValue
        }
    }

    var slideLink: String {
        get {
            return link
        }
        set {
            link = newValue
        }
    }
    
    var slideImage: String {
        get {
            return s_img
        }
        set {
            let urlString = newValue.trimmed.replacingOccurrences(of: " ", with: "%20")
            s_img = urlString
        }
    }
    
    var slideOrdering: Int {
        get {
            return _ordering
        }
        set {
            _ordering = newValue
        }
    }
    
    // constructors 
    override init() {
        super.init()
    }
    
    init(slideID: Int, slideTitle: String, slideDescription: String, slideLink: String, slideImage: String, slideOrdering: Int) {
        super.init()
        self.slideID = slideID
        self.slideTitle = slideTitle
        self.slideDescription = slideDescription
        self.slideLink = slideLink
        self.slideImage = slideImage
        self.slideOrdering = slideOrdering
    }
    
    // functions
    func toString() -> String {
        return "\(slideImage) \(slideTitle)"
    }
    
}
