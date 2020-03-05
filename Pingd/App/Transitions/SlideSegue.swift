//
//  LoginSegue.swift
//  Pingd
//
//  Created by David Acevedo on 1/22/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import UIKit

class SlideSegue: UIStoryboardSegue {
    
    private var selfSlideRetainer: SlideSegue? = nil
    
    override func perform() {
        destination.transitioningDelegate = self
        selfSlideRetainer = self
        destination.modalPresentationStyle = .fullScreen
        source.present(destination, animated: true, completion: nil)
    }
}

extension SlideSegue: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideAnimator(animationDuration: 0.35, animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        selfSlideRetainer = nil
        return SlideAnimator(animationDuration: 0.35, animationType: .dismiss)
    }
}

class BackslideSegue: UIStoryboardSegue {
    
    private var selfBackslideRetainer: BackslideSegue? = nil
    
    override func perform() {
        destination.transitioningDelegate = self
        selfBackslideRetainer = self
        destination.modalPresentationStyle = .fullScreen
        source.present(destination, animated: true, completion: nil)
    }
}

extension BackslideSegue: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideAnimator(animationDuration: 0.35, animationType: .dismiss)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        selfBackslideRetainer = nil
        return SlideAnimator(animationDuration: 0.35, animationType: .present)
    }
}
