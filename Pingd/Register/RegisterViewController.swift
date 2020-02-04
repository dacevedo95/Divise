//
//  RegisterViewController.swift
//  Pingd
//
//  Created by David Acevedo on 1/20/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import StepIndicator

class RegisterViewController: UIViewController, RegisterPageViewControllerDelegate {
    
    // MARK: - Properties
    var registerPageViewController: RegisterPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Delegate Functions
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? RegisterPageViewController {
            registerPageViewController = pageViewController
            registerPageViewController?.registerDelegate = self
        }
    }
    
    func updateUI() {
        if let index = registerPageViewController?.currentIndex {
            // stepIndicator.currentStep = index
        }
    }
}
