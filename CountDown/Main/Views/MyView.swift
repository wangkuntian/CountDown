//
//  MyView.swift
//  CountDown
//
//  Created by 王坤田 on 2017/11/22.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

class MyView: UIView {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let result = super.hitTest(point, with: event)
        
        if result == self {
            
            return nil
            
        }
        
        return result
        
    }
    

}
