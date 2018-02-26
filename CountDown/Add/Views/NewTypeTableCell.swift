//
//  NewTypeTableCell.swift
//  CountDown
//
//  Created by 王坤田 on 2017/11/3.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

class NewTypeTableCell: UITableViewCell {

    var titleLabel : UILabel!
    
    static let cellID = "NewTypeTableCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        
        titleLabel = UILabel()
        self.contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(30 * heightScale)
            make.width.equalTo(140 * widthScale)
            make.centerY.equalTo(self.contentView)
            
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 16.5, weight: .regular)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
