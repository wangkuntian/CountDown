//
//  DayView.swift
//  CountDown
//
//  Created by 王坤田 on 2017/10/27.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

class DayView: UIView {
    
    var distaceLabel : UILabel!
    var titleLabel : UILabel!
    var dayLabel : UILabel!
    var dateLabel : UILabel!

    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        initViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        
        self.isHidden = true
        
        distaceLabel = UILabel()
        self.addSubview(distaceLabel)
        
        distaceLabel.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(self)
            make.top.equalTo(40 * heightScale)
        }
        distaceLabel.text = "距离"
        distaceLabel.textAlignment = .center
        distaceLabel.textColor = UIColor.white
        distaceLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(distaceLabel.snp.bottom).offset(10 * heightScale)
            make.centerX.equalTo(self)
            
        }
        titleLabel.text = "圣诞节"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        
        dayLabel = UILabel()
        self.addSubview(dayLabel)
        
        dayLabel.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(self)
            make.top.equalTo(titleLabel.snp.bottom).offset(0 * heightScale)
        }
        
        dayLabel.text = "56"
        dayLabel.textAlignment = .center
        dayLabel.textColor = UIColor.white
        dayLabel.font = UIFont.systemFont(ofSize: 120, weight: .medium)
        
        dateLabel = UILabel()
        self.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(dayLabel.snp.bottom).offset(0 * heightScale)
        }
        dateLabel.text = "2017-12-25"
        dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor.white
        dateLabel.font = UIFont.systemFont(ofSize: 18.5, weight: .thin)
        
    }
    
    func setData(day : Day){
        
        self.dateLabel.text = day.dateString
        self.dayLabel.text = day.date.getDay
        self.titleLabel.text = day.title
        
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let result = super.hitTest(point, with: event)
        
        if result == self {

            return nil

        }
        
        return result
    
    }
    
}
