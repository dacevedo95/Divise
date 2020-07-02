//
//  SmoothPickerConfiguration.swift
//  Pingd
//
//  Created by David Acevedo on 4/5/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import UIKit
public enum SelectionStyle {
    case scale
    case colored
}
public class SmoothPickerConfiguration {
    internal static  var selectionStyle:SelectionStyle?
    internal static var selectedColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    internal static var dimmedColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    public static func setSelectionStyle(selectionStyle:SelectionStyle) {
        if self.selectionStyle == nil {
            self.selectionStyle = selectionStyle
        }
    }
   public  static func setColors(selectedColor:UIColor,dimmedColor:UIColor) {
        self.selectedColor  = selectedColor
        self.dimmedColor = dimmedColor
    }
}
