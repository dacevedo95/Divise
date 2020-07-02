//
//  TestViewController.swift
//  Pingd
//
//  Created by David Acevedo on 4/5/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, SmoothPickerViewDataSource, SmoothPickerViewDelegate {

    @IBOutlet weak var pickerView: SmoothPickerView!
    
    var i = 0
    var views = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SmoothPickerConfiguration.setSelectionStyle(selectionStyle: .scale)
        
        for _ in 1..<51 {
            i += 5
            let view = viewss(frame: CGRect(x: 0, y: 0, width: 50, height: 100))
            view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            views.append(view)
        }
        pickerView.firstselectedItem  = 4
        pickerView.reloadData()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    func numberOfItems(pickerView: SmoothPickerView) -> Int {
        return 50
    }
    
    func itemForIndex(index: Int, pickerView: SmoothPickerView) -> UIView {
        let itemView = CustomizeYourGiftSliderItemView(frame: CGRect(x: 0, y: 0, width: 70, height: 40))
        itemView.setData(value:"\(index + 1)")
        return itemView
        
    }

    func didSelectItem(index: Int, view: UIView, pickerView: SmoothPickerView) {
        print("SelectedIndex \(index)")
    }
    
    @IBAction func navigateNext(_ sender: Any) {
        // pickerView.navigate(direction: .next)
    }
    @IBAction func navigatePervious(_ sender: Any) {
        // pickerView.navigate(direction: .pervious)
    }

}
