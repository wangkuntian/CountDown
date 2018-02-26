//
//  Models.swift
//  CountDown
//
//  Created by 王坤田 on 2017/11/6.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import Foundation


struct Type {
    
    
    var id : String = ""
    
    var name : String = ""
    
    var image : String = ""
    
    var level : Double = 0.0
    
}

class NewDay {
    
    var title : String = ""
    
    var date : String = Date.currentDateString
    
    var dateString : String = Date.currentDateString
    
    var type : String = "事件"
    
    var typeImage : String = "ic_calendar.png"
    
    var `repeat` : String = "不重复"
    
    var isCover : Bool = false
    
    var repeatIndexPath : IndexPath = IndexPath(row: 0, section: 0)
    
    var typeIndexPath : IndexPath = IndexPath(row: 0, section: 0)
    
    static let current = NewDay()
    
    class func reset() {
        
        NewDay.current.title = ""
        
        NewDay.current.date = Date.currentDateString
        
        NewDay.current.dateString = Date.currentDateString
        
        NewDay.current.type = "事件"
        
        NewDay.current.typeImage = "ic_calendar.png"
        
        NewDay.current.`repeat` = "不重复"
        
        NewDay.current.isCover = false
        
        NewDay.current.repeatIndexPath = IndexPath(row: 0, section: 0)
        
        NewDay.current.typeIndexPath = IndexPath(row: 0, section: 0)
        
        
    }
    
}
