//
//  UIDevice.swift
//  Pingd
//
//  Created by David Acevedo on 7/4/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

extension UIDevice {
    static func vibrate() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
}
