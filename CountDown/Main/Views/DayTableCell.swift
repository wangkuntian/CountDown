//
//  DayTableCell.swift
//  CountDown
//
//  Created by 王坤田 on 2017/10/30.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

class DayTableCell: UITableViewCell {
    
    
    static let cellID = "DayTableCell"
    
    var typeImageView : UIImageView!
    
    var titleLabel : UILabel!
    
    var dateLabel : UILabel!
    
    var dayLabel : UILabel!
    
    var line : UIView!
    
    var day : Day!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initViews() {
        
        self.backgroundColor = UIColor.cellColor
        
        typeImageView = UIImageView()
        self.contentView.addSubview(typeImageView)
        
        typeImageView.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(30 * widthScale)
            make.height.width.equalTo(55 * widthScale)
            
        }
        typeImageView.image = #imageLiteral(resourceName: "ic_calendar")
        
        titleLabel = UILabel()
        self.contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(typeImageView.snp.right).offset(25 * widthScale)
            make.centerY.equalTo(self.contentView).offset(-25 * heightScale)
            
        }
        titleLabel.text = "圣诞节"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        
        dateLabel = UILabel()
        self.contentView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8 * heightScale)
        }
        dateLabel.text = "2017-12-25"
        dateLabel.textColor = UIColor.lightGray
        dateLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        let day = UILabel()
        self.contentView.addSubview(day)
        
        day.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(-20 * widthScale)
            
        }
        day.text = "天"
        day.textColor = UIColor.lightGray
        day.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        dayLabel = UILabel()
        self.contentView.addSubview(dayLabel)
        
        dayLabel.snp.makeConstraints { (make) in
            
            make.right.equalTo(day.snp.left).offset(-9 * widthScale)
            make.centerY.equalTo(self.contentView)
            
        }
        dayLabel.text = "56"
        dayLabel.textColor = UIColor.dayTextColor
        dayLabel.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        
        line = UIView()
        self.contentView.addSubview(line)
        
        line.snp.makeConstraints { (make) in
            
            make.left.equalTo(titleLabel)
            make.right.bottom.equalTo(0)
            make.height.equalTo(2 * heightScale)
            
        }
        line.backgroundColor = UIColor.lineColor
        
    }
    
    func setData(day : Day) {
        
        self.day = day
        titleLabel.text = self.day.title
        dateLabel.text = self.day.dateString
        dayLabel.text = self.day.date.getDay
        typeImageView.image = UIImage(named: day.typeImage)
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
