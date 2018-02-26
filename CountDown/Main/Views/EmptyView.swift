//
//  EmptyView.swift
//  CountDown
//
//  Created by 王坤田 on 2017/11/22.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

class EmptyView: UIView {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        initViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        
        self.isHidden = true
        
        let titleLabel = UILabel()
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(100 * heightScale)
            make.centerX.equalTo(self)
            
        }
        titleLabel.text = "无内容"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        titleLabel.textColor = .white
        
        let emotionLabel = UILabel()
        self.addSubview(emotionLabel)
        
        emotionLabel.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(self)
            make.top.equalTo(titleLabel.snp.bottom).offset(30 * heightScale)
            
        }
        emotionLabel.text = ":("
        emotionLabel.textColor = UIColor.white
        emotionLabel.textAlignment = .center
        emotionLabel.font = UIFont.systemFont(ofSize: 120, weight: .regular)
        
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let result = super.hitTest(point, with: event)
        
        if result == self {
            
            return nil
            
        }
        
        return result
        
    }

}
