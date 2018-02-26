//
//  AnimatedPresentationController.swift
//  CountDown
//
//  Created by 王坤田 on 2017/10/30.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

class AnimatedPresentationController: UIPresentationController,UIGestureRecognizerDelegate{
    
    private var style : TransitionStyle!
    
    private var isGestureEnabled : Bool!
    
    private var pan : UIPanGestureRecognizer!
    
    convenience init(presented: UIViewController, presenting: UIViewController?, isGestureEnabled : Bool? = AnimatedTransitionConstant.isDismissGestureEnabled, style : TransitionStyle? = AnimatedTransitionConstant.defaultTransitionStyle) {
        
        self.init(presentedViewController: presented, presenting: presenting)
        
        self.isGestureEnabled = isGestureEnabled
        self.style = style
        
        
    }
    
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        
        switch style {
        case .deck:
            
            pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
            
            pan.delegate = self
            pan.maximumNumberOfTouches = 1
            pan.cancelsTouchesInView = false
            self.presentedViewController.view.addGestureRecognizer(pan)
            
            
        default:
            break
        }
        
        
        
    }
    
    @objc func panGestureAction(sender : UIPanGestureRecognizer) {
        
        if !sender.isEqual(pan) {
            
            return
            
        }
        
        
        
        
        switch  sender.state {
            
        case .began:
            
            sender.setTranslation(CGPoint.init(x: 0, y: 0), in: self.containerView)
            
        case .changed:
            
            if let view = self.presentedView {
                
                if self.isGestureEnabled {
                    
                    let translation = sender.translation(in: view)
                    
                    if translation.y >= 240 {
                        
                        self.presentedViewController.dismiss(animated: true, completion: nil)
                        
                    }
                    
                }
                
            }
            
            break
            
        case .ended:
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.presentedView?.transform = .identity
                
            })
            
            
        default:
            break
            
        }
        
        
        
        
        
    }
    
    
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        
        return true
        
    }

}
