//
//  Tool.swift
//  CountDown
//
//  Created by 王坤田 on 2017/10/27.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import Foundation
import SnapKit


let screenSize = UIScreen.main.bounds

let widthScale = UIScreen.main.bounds.width / 750.0

let heightScale = UIScreen.main.bounds.height / 1334.0


let itemHeight = (screenSize.width - 30 * widthScale * 2 - 8 * spacing) / 8

let spacing = 8 * widthScale

let Days : [String] = ["初一",
                       "初二",
                       "初三",
                       "初四",
                       "初五",
                       "初六",
                       "初七",
                       "初八",
                       "初九",
                       "初十",
                       "十一",
                       "十二",
                       "十三",
                       "十四",
                       "十五",
                       "十六",
                       "十七",
                       "十八",
                       "十九",
                       "二十",
                       "廿一",
                       "廿二",
                       "廿三",
                       "廿四",
                       "廿五",
                       "廿六",
                       "廿七",
                       "廿八",
                       "廿九",
                       "三十"]



class UserConfig {
    
    var backgroundImage : UIImage = #imageLiteral(resourceName: "bg_1")
 
    static let share = UserConfig()
}
