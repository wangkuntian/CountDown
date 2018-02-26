//
//  InteractiveTransition.swift
//  CountDown
//
//  Created by 王坤田 on 2017/10/31.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit

enum GestureScene {
    
    case present
    case dismiss
    case push
    case pop
    
}

enum GestureDirection{
    
    case left
    case right
    case up
    case down
    
}


typealias GestureHandle = () -> Void

class InteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    var isGestureEnabled : Bool!
    
    var direction : GestureDirection!
    
    var scene : GestureScene!
    
    var vc : UIViewController!
    
    var present : GestureHandle?
    
    var push : GestureHandle?
    
    init(direction : GestureDirection, scene : GestureScene) {
        
        self.direction = direction
        self.scene = scene
    }

    
    func addPanGesture(for viewController : UIViewController ) {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
        self.vc = viewController
        
        viewController.view.addGestureRecognizer(pan)
        
    }
    
    @objc func panGestureAction(sender : UIPanGestureRecognizer) {
        
        var percent : CGFloat = 0.0
        
        switch direction {
        case .left:
            
            let transitionX = -sender.translation(in: sender.view).x
            percent = transitionX / (sender.view?.frame.size.width)!
            
        case .right:
            
            let transitionX = sender.translation(in: sender.view).x
            percent = transitionX / (sender.view?.frame.size.width)!
            
        case .up:
            
            let transitionY = -sender.translation(in: sender.view).y
            percent = transitionY / (sender.view?.frame.size.width)!
            
        case .down:
            
            let transitionY = sender.translation(in: sender.view).y
            percent = transitionY / (sender.view?.frame.size.width)!
            
        default:
            break
        }
        
        switch sender.state {
        case .began:
            
            self.isGestureEnabled = true
            self.start()
            
        case .changed:
            
            self.update(percent)

            
        case .ended:
            self.isGestureEnabled = false
            
            if percent > 0.5 {
                
                self.finish()
                
            }else {
                
                self.cancel()
                
            }
            
        default:
            break
        }
        
        
    }
    
    
    func start() {
        
        switch self.scene {
        case .present:
            
            
            if let present = self.present {
                
                present()
                
            }
            
            break
        case .dismiss:
            
            vc.dismiss(animated: true, completion: nil)
            
            break
        case .push:
            
            if let push = self.push {
                
                push()
                
            }
            
            break
            
        case .pop:
            
            vc.navigationController?.popViewController(animated: true)
            
            break
        default:
            break
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
