//
//  WebServices.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 3/14/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import Foundation

class MyService: NSObject {
    
    /** Properties **/
    
    // Show All Contents
    static let keilaAllContents = "http://tostenh.com/ContentAll"
    
    // Show contents with number specified
    private static let keilaContentsWithNumber = "http://tostenh.com/ContentAll/ShowContentAmount/"
    
    // Show contents by category
    private static let keilaContentsByCategory = "http://tostenh.com/ContentAll/ShowContentByCategory/"
    
    // Show contents by category and number of contents
    private static let keilaContentsByCategoryAndWithNumber = "http://tostenh.com/ContentAll/ShowContentByCategory/3?amount=3"
    
    // Show content by content id
    private static let keilaContentByContentID = "http://tostenh.com/ContentAll/ShowContentAmountById/"
    
    // Show menu list
    static let keilaMenuList = "http://tostenh.com/Menu"
    
    // Show slide show value
    static let keilaSlideShow = "http://tostenh.com/SlideShow"
    
    // Show all home content with all categories
    static let keilaAllHomeContent = "http://tostenh.com/ShowContentByAllCategory"
    
    // Show a number of home content with all categories
    private static let keilaHomeContentWithNumber = "http://tostenh.com/ShowContentByAllCategory/AmountContentOfEachCategory/"
    
    
    /** Functions **/
    
    // return string of keilaContentsWithNumber
    static func keilaContentsWithNumber(_ number: Int) -> String {
        return "\(keilaContentsWithNumber)\(number)"
    }
    
    // return string of keilaContentsByCategory
    static func keilaContentsByCategory(_ categoryID: Int) -> String {
        return "\(keilaContentsByCategory)\(categoryID)"
    }
    
    // return string of keilaContentsByCategoryAndWithNumber
    static func keilaContents(_ categoryID: Int, _ number: Int) -> String {
        return String.init(format: "http://tostenh.com/ContentAll/ShowContentByCategory/%d?amount=%d", categoryID, number)
    }
    
    // return string of keilaContentByContentID
    static func keilaContentByContentID(_ contentID: Int) -> String {
        return "\(keilaContentByContentID)\(contentID)"
    }
    
    // return string of keilaHomeContentWithNumber
    static func keilaHomeContentWithNumber(_ number: Int) -> String {
        return "\(keilaHomeContentWithNumber)\(number)"
    }
    
}
