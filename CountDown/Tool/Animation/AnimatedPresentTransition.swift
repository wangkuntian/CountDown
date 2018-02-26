//
//  AnimatedPresentTransition.swift
//  CountDown
//
//  Created by 王坤田 on 2017/10/30.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

class AnimatedPresentTransition: NSObject,UIViewControllerAnimatedTransitioning {
    
    private let duration: TimeInterval!
    private let style : TransitionStyle!
    
    init(duration: TimeInterval, style : TransitionStyle) {
        
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
            let fromVC : UIViewController  = transitionContext.viewController(forKey: .from)!
            let tempView : UIView = fromVC.view.snapshotView(afterScreenUpdates: false)!
            tempView.frame = fromVC.view.frame
            fromVC.view.isHidden = true
            
            let containerView : UIView = transitionContext.containerView
            containerView.addSubview(tempView)
            containerView.addSubview(toVC.view)
            
            let height = screenSize.height - 60
            
            toVC.view.frame = CGRect(x: 0, y: containerView.frame.height, width: containerView.frame.width, height: height)
            
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
                
                toVC.view.transform = CGAffineTransform(translationX: 0, y: -height)
                tempView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                
            }, completion: { (finished) in
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                
                if transitionContext.transitionWasCancelled {
                    
                    fromVC.view.isHidden = false
                    tempView.removeFromSuperview()
                    
                }
                
            })

        default:
            break
        }
        
    }
    

}
