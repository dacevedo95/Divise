//
//  OnboardingViewController.swift
//  Pingd
//
//  Created by David Acevedo on 1/15/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import AuthenticationServices

class OnboardingViewController: UIViewController, OnboardingPageViewControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet weak var signInWithAppleButton: UIButton! {
        didSet {
            self.signInWithAppleButton.layer.cornerRadius = 25.0
        }
    }
    
    @IBOutlet var signInWithEmail: UIButton! {
        didSet {
            signInWithEmail.backgroundColor = .clear
//            signInWithEmail.layer.cornerRadius = 25
//            signInWithEmail.layer.borderWidth = 1
//            signInWithEmail.layer.borderColor = UIColor.black.cgColor
//            signInWithEmail.layer.masksToBounds = true
        }
    }
    
    // MARK: - Properties
    var onboardingPageViewController: OnboardingPageViewController?
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Actions
    func didUpdatePageIndex(currentIndex: Int) {
        if let index = onboardingPageViewController?.currentIndex {
            pageControl.currentPage = index
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? OnboardingPageViewController {
            onboardingPageViewController = pageViewController
            onboardingPageViewController?.onboardingDelegate = self
        }
    }
    
    
}
