//
//  Extension.swift
//  CountDown
//
//  Created by 王坤田 on 2017/10/27.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
        
    }
    
    class var dayTextColor : UIColor {
        
        get {
            
            return UIColor(red:0.125, green:0.431, blue:0.569, alpha:1.000)
            
        }
        
    }
    
    class var lineColor : UIColor {
        
        get {
            
            return UIColor.init(white: 0.85, alpha: 1)
        }
        
    }
    
    class var tableBgColor : UIColor {
        
        get {
            
            return UIColor(r: 239.0, g: 239.0, b: 243.0)
        }
    }
    
    class var textColor : UIColor {
        
        get {
            
            return UIColor(r: 86.0, g: 86.0, b: 86.0)
            
        }
        
    }
    
    class var selectedColor : UIColor {
        
        get {
            
            return UIColor.init(white: 0.90, alpha: 1)
            
        }
    }
    
    class var unSelectedColor : UIColor {
        
        get {
            
            return UIColor.init(white: 0.98, alpha: 1)
            
        }
        
    }
    
    class var cellColor : UIColor {
        
        get {
            
            return UIColor.init(white: 0.93, alpha: 1)
            
        }
        
    }
    
}


extension UIBarButtonItem {
    
    class func createBarButtonItem(with image : UIImage, and tap : UITapGestureRecognizer, width : CGFloat? = 50 * widthScale) -> UIBarButtonItem {
        
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: width!, height: width!)
        imageView.image = image
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        
        let barButtonItem = UIBarButtonItem.init(customView: imageView)
        
        return barButtonItem
    }
    
    
    
}

extension Date {
    
    static var currentDateString : String {
        
        get {
            
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd"
            
            return formatter.string(from: date)
            
        }
    
    }
    
    static var longCurrentDateString : String {
        
        get {
            
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYYMMddHHmmss"
            
            return formatter.string(from: date)
            
        }
        
    }
    
}

extension String {
    
    var isNotEmptyOrWhiteSpaces : Bool {
        
        get {
            
            if self.isEmpty {
                
                return false
                
            }
            
            let str = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            return str.count == 0 ? false : true
            
        }
        
    }
    
    var getDay : String {
        
        get {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd"
            let date = formatter.date(from: self)!
            let temp = formatter.string(from: Date())
            let now : Date = formatter.date(from: temp)!
            
            let time : TimeInterval = date.timeIntervalSince(now)
            
            let day : Int = 86400
            
            return "\(abs(Int(time) / day))"
            
            
        }
        
    }
    
}


