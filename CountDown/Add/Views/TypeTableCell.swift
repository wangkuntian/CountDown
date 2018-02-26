//
//  TypeTableCell.swift
//  CountDown
//
//  Created by 王坤田 on 2017/11/3.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

class TypeTableCell: UITableViewCell {
    
    var iconImageView : UIImageView!
    
    var titleLabel : UILabel!
    
    var selectedImageView : UIImageView!
    
    static let cellID : String = "TypeTableCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        
        iconImageView = UIImageView()
        self.contentView.addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.left.equalTo(30 * widthScale)
            make.centerY.equalTo(self.contentView)
            make.width.height.equalTo(55 * heightScale)
            
        }
        
        iconImageView.image = #imageLiteral(resourceName: "ic_calendar")
        
        titleLabel = UILabel()
        self.contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp.right).offset(20 * widthScale)
            make.centerY.equalTo(self.contentView)
            
        }
        
        selectedImageView = UIImageView()
        self.contentView.addSubview(selectedImageView)
        
        selectedImageView.snp.makeConstraints { (make) in
            
            make.right.equalTo(-40 * widthScale)
            make.height.width.equalTo(40 * heightScale)
            make.centerY.equalTo(self.contentView)
            
        }
        selectedImageView.image = #imageLiteral(resourceName: "ic_selected")
        selectedImageView.isHidden = true
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        
    }

}
