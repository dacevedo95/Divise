//
//  MainTabBarController.swift
//  Pingd
//
//  Created by David Acevedo on 8/22/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController : UITabBarController {
    
    var overview: Overview?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let overviewView = self.viewControllers![0] as! OverviewViewController
        overviewView.overview = self.overview
        print("Overview MainTab: " + overview!.header)
    }
    
    override func viewDidLoad() {
        setupMiddleButton()
        
        self.tabBar.layer.borderWidth = 0.5
        self.tabBar.layer.borderColor = UIColor(red: 229, green: 229, blue: 229).cgColor
        self.tabBar.clipsToBounds = true
        
        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "Home")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem1.selectedImage = UIImage(named: "SelectedHome")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "Transactions")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.selectedImage = UIImage(named: "SelectedTransactions")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        
    }
    
    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 78, height: 78))

        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 40.0
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame

        menuButton.backgroundColor = UIColor(red: 136, green: 87, blue: 215)
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        menuButton.layer.applySketchShadow(color: .black, alpha: 0.25, x: 0.0, y: 4.0, blur: 10, spread: 0)
        view.addSubview(menuButton)
        
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

        view.layoutIfNeeded()
    }


    // MARK: - Actions

    @objc private func menuButtonAction(sender: UIButton) {
        print("middle pressed")
    }
    
}
