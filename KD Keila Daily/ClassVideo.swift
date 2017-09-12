//
//  ClassVideo.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 5/28/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit

class ClassVideo: NSObject {

    // data members
    private var _videoId: String = ""
    private var _publishedAt: String = ""
    private var _title: String = ""
    private var _description: String = ""
    private var _default: [String] = [String]()
    private var _medium: [String] = [String]()
    private var _high: [String] = [String]()
    
    // properties
    var VideoId: String {
        get {
            return _videoId
        }
        set {
            _videoId = newValue
        }
    }
    var PublishedAt: String {
        get {
            return _publishedAt
        }
        set {
            _publishedAt = newValue
        }
    }
    var Title: String {
        get {
            return _title
        }
        set {
            _title = newValue
        }
    }
    var Description: String {
        get {
            return _description
        }
        set {
            _description = newValue
        }
    }
    var Default: [String] {
        get {
            return _default
        }
        set {
            self._default = newValue
        }
    }
    var Medium: [String] {
        get {
            return _medium
        }
        set {
            self._medium = newValue
        }
    }
    var High: [String] {
        get {
            return _high
        }
        set {
            self._high = newValue
        }
    }
    
}
