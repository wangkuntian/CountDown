//
//  TypeImageCollectionCell.swift
//  CountDown
//
//  Created by 王坤田 on 2017/11/3.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

class TypeImageCollectionCell: UICollectionViewCell {
    
    var imageView : UIImageView!
    
    var imageName : String!
    
    static let cellID : String = "TypeImageCollectionCell"
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        initViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        
        self.layer.cornerRadius = 15 * widthScale
        self.layer.masksToBounds = true
        
        imageView = UIImageView()
        self.contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            
            make.center.equalTo(self.contentView)
            make.height.width.equalTo(50 * heightScale)
            
        }
        
    }
    
}
