//
//  AnimatedDismissTransition.swift
//  CountDown
//
//  Created by 王坤田 on 2017/10/30.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

class AnimatedDismissTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration: TimeInterval!
    private let style : TransitionStyle!
    
    init(duration: TimeInterval? = AnimatedTransitionConstant.defaultAnimationDuration, style : TransitionStyle? = AnimatedTransitionConstant.defaultTransitionStyle) {
        
        self.duration = duration
        self.style = style
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return duration
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        switch style {
        case .deck:
            
            let toVC : UIViewController = transitionContext.viewController(forKey: .to)!
            let fromVC : UIViewController = transitionContext.viewController(forKey: .from)!
            
            let tempView : UIView = transitionContext.containerView.subviews[0]
            
            UIView.animate(withDuration: duration, animations: {
                
                fromVC.view.transform = CGAffineTransform.identity
                tempView.transform = CGAffineTransform.identity
                
            }, completion: { (finished) in
                
                if transitionContext.transitionWasCancelled {
                    
                    transitionContext.completeTransition(false)
                    
                }else {
                    
                    transitionContext.completeTransition(true)
                    toVC.view.isHidden = false
                    tempView.removeFromSuperview()
                    
                }
                
                
            })

        default:
            break
        }
        
    }
    

}
