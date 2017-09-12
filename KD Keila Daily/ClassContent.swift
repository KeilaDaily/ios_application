//
//  ClassContent.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 3/16/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit

class ClassContent: NSObject {

    // data members
    private var id: Int = 0
    private var _description: String = ""
    private var full_text: String = ""
    private var text_title: String = ""
    private var cat_id: Int = 0
    private var create_date: String = ""
    private var member_id: Int = 0
    private var display: String = ""
    private var count: Int = 0
    private var feature: Int = 0
    private var publish_date: String = ""
    private var media: String = ""
    private var media_title: String = ""
    private var media_publish: Int = 0
    private var tag: String = ""
    private var icon: String = ""
    private var delete_statue: Int = 0
    
    // properties
    var contentID: Int {
        get {
            return id
        }
        set {
            id = newValue
        }
    }
    
    var contentDescription: String {
        get {
            return _description
        }
        set {
            _description = newValue
        }
    }
    
    var contentFullText: String {
        get {
            return full_text
        }
        set {
            full_text = newValue
        }
    }
    
    var contentTitle: String {
        get {
            return text_title
        }
        set {
            text_title = newValue
        }
    }
    
    var contentCatID: Int {
        get {
            return cat_id
        }
        set {
            cat_id = newValue
        }
    }
    
    var contentCreateDate: String {
        get {
            return create_date
        }
        set {
            create_date = newValue
        }
    }
    
    var contentMemberID: Int {
        get {
            return member_id
        }
        set {
            member_id = newValue
        }
    }
    
    var contentDisplay: String {
        get {
            return display
        }
        set {
            display = newValue
        }
    }
    
    var contentCount: Int {
        get {
            return count
        }
        set {
            count = newValue
        }
    }
    
    var contentFeature: Int {
        get {
            return feature
        }
        set {
            feature = newValue
        }
    }
    
    var contentPublishDate: String {
        get {
            return publish_date
        }
        set {
            publish_date = newValue
        }
    }
    
    var contentMedia: String {
        get {
            return media
        }
        set {
            media = newValue.trimmed.replacingOccurrences(of: " ", with: "%20")
        }
    }
    
    var contentMediaTitle: String {
        get {
            return media_title
        }
        set {
            media_title = newValue
        }
    }
    
    var contentMediaPublish: Int {
        get {
            return media_publish
        }
        set {
            media_publish = newValue
        }
    }
    
    var contentTag: String {
        get {
            return tag
        }
        set {
            tag = newValue
        }
    }
    
    var contentIcon: String {
        get {
            return icon
        }
        set {
            icon = newValue
        }
    }
    
    var contentDeleteStatue: Int {
        get {
            return delete_statue
        }
        set {
            delete_statue = newValue
        }
    }
 
    // constructors
    override init() {
        super.init()
    }
    
    init(contentID: Int,
         contentDescription: String,
         contentFullText: String,
         contentTitle: String,
         contentCatID: Int,
         contentCreateDate: String,
         contentMemberID: Int,
         contentDisplay: String,
         contentCount: Int,
         contentFeature: Int,
         contentPublishDate: String,
         contentMedia: String,
         contentMediaTitle: String,
         contentMediaPublish: Int,
         contentTag: String,
         contentIcon: String,
         contentDeleteStatue: Int) {
        super.init()
        [self].forEach {
            $0.contentID = contentID
            $0.contentDescription = contentDescription
            $0.contentFullText = contentFullText
            $0.contentTitle = contentTitle
            $0.contentCatID = contentCatID
            $0.contentCreateDate = contentCreateDate
            $0.contentMemberID = contentMemberID
            $0.contentDisplay = contentDisplay
            $0.contentCount = contentCount
            $0.contentFeature = contentFeature
            $0.contentPublishDate = contentPublishDate
            $0.contentMedia = contentMedia
            $0.contentMediaTitle = contentMediaTitle
            $0.contentMediaPublish = contentMediaPublish
            $0.contentTag = contentTag
            $0.contentIcon = contentIcon
            $0.contentDeleteStatue = contentDeleteStatue
        }
    }
    
    // Function
    func toString() -> String {
        return "\(contentID) \(contentTitle)"
    }
    
}
