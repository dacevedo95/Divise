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
    
    private var selfRetainer: SlideSegue? = nil
    
    override func perform() {
        destination.transitioningDelegate = self
        selfRetainer = self
        destination.modalPresentationStyle = .fullScreen
        source.present(destination, animated: true, completion: nil)
    }
}

extension SlideSegue: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideAnimator(animationDuration: 0.5, animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        selfRetainer = nil
        return SlideAnimator(animationDuration: 0.5, animationType: .dismiss)
    }
}
