//
//  SlideAnimator.swift
//  Pingd
//
//  Created by David Acevedo on 1/22/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import UIKit

class SlideAnimator: NSObject {
    private let animationDuration: Double
    private let animationType: AnimationType
    
    internal enum AnimationType {
        case present
        case dismiss
        case slideUp
        case slideDown
    }
    
    // MARK: - Init
    init(animationDuration: Double, animationType: AnimationType) {
        self.animationDuration = animationDuration
        self.animationType = animationType
    }
    
}

extension SlideAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: animationDuration) ?? 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else {
                transitionContext.completeTransition(false)
                return
        }
        
        switch animationType {
        case .present:
            transitionContext.containerView.addSubview(toViewController.view)
            presentAnimation(with: transitionContext, viewToAnimate: toViewController.view, viewToDismiss: fromViewController.view)
        case .dismiss:
            transitionContext.containerView.addSubview(toViewController.view)
            dismissAnimation(with: transitionContext, viewToAnimate: toViewController.view, viewToDismiss: fromViewController.view)
        case .slideUp:
            transitionContext.containerView.addSubview(toViewController.view)
            slideUpAnimation(with: transitionContext, viewToAnimate: toViewController.view, viewToDismiss: fromViewController.view)
        case .slideDown:
            transitionContext.containerView.addSubview(toViewController.view)
            slideDownAnimation(with: transitionContext, viewToAnimate: toViewController.view, viewToDismiss: fromViewController.view)
        }
    }
    
    func presentAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView, viewToDismiss: UIView) {
        viewToAnimate.clipsToBounds = true
        viewToDismiss.clipsToBounds = true
        viewToAnimate.frame.origin.x = viewToAnimate.frame.width
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            viewToAnimate.frame.origin.x = 0
            viewToDismiss.frame.origin.x = -1 * viewToAnimate.frame.width
            
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
    
    func dismissAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView, viewToDismiss: UIView) {
        viewToAnimate.clipsToBounds = true
        viewToDismiss.clipsToBounds = true
        viewToAnimate.frame.origin.x = -1 * viewToAnimate.frame.width
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            viewToAnimate.frame.origin.x = 0
            viewToDismiss.frame.origin.x = viewToAnimate.frame.width
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
    
    func slideUpAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView, viewToDismiss: UIView) {
        viewToAnimate.clipsToBounds = true
        viewToDismiss.clipsToBounds = true
        viewToAnimate.frame.origin.y = viewToAnimate.frame.height
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            viewToAnimate.frame.origin.y = 0
            viewToDismiss.frame.origin.y = -1 * viewToAnimate.frame.height
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
    
    func slideDownAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView, viewToDismiss: UIView) {
        viewToAnimate.clipsToBounds = true
        viewToDismiss.clipsToBounds = true
        viewToAnimate.frame.origin.y = -1 * viewToAnimate.frame.height
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            viewToAnimate.frame.origin.y = 0
            viewToDismiss.frame.origin.y = viewToAnimate.frame.height
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
    
    
}
