//
//  UIDeviceExtensions.swift
//  News App
//
//  Created by Matthew Guest on 12/4/20.
//

import Foundation
import UIKit

public extension UIDevice {

    class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
