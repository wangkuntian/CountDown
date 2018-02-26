//
//  AnimatedTransitionDelegate.swift
//  CountDown
//
//  Created by 王坤田 on 2017/10/30.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

class AnimatedTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    
    public var isGestureEnabled : Bool = true
    
    public var style : TransitionStyle!
    
    private let presentDuration: TimeInterval!
    private let dismissDuration: TimeInterval!
    
    init(style : TransitionStyle? = AnimatedTransitionConstant.defaultTransitionStyle, presentDuration: TimeInterval? = AnimatedTransitionConstant.defaultAnimationDuration, dismissDuration: TimeInterval? = AnimatedTransitionConstant.defaultAnimationDuration) {
        
        self.style = style
        self.presentDuration = presentDuration
        self.dismissDuration = dismissDuration
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return AnimatedPresentTransition(duration: presentDuration, style: style)
        
        
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return AnimatedDismissTransition(duration: dismissDuration, style: style)
        
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        switch style {
        case .deck:
            
            return InteractiveTransition(direction: .down, scene: .dismiss)
            
        case .spread:
            break
        default:
            break
        }
        
        return nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        switch style {
        case .deck:
            
            return InteractiveTransition(direction: .up, scene: .present)
            
        case .spread:
            break
        default:
            break
        }
        
        return nil
        
    }
    
    
}
