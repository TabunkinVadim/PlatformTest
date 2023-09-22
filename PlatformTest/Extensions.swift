//
//  Extensions.swift
//  PlatformTest
//
//  Created by Табункин Вадим on 21.09.2023.
//

import UIKit

extension UIView {
    static var identifier:String {String(describing: self)}

    func  toAutoLayout () {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach {addSubview($0)}
    }
}

extension UIColor {

    static var backgroundColor: UIColor {
        Self.makeColor(light: .systemGray6, dark: .darkGray)
    }

    static var textColor: UIColor {
        Self.makeColor(light: .black, dark: .white)
    }

    static var statusTextColor: UIColor {
        Self.makeColor(light: .systemGray, dark: .secondaryLabel )
    }
    
    private static func makeColor(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection -> UIColor in
                switch traitCollection.userInterfaceStyle {
                case .light, .unspecified:
                    return light
                case .dark:
                    return dark
                @unknown default:
                    assertionFailure("Case is not supported")
                    return light
                }
            }
        } else {
            return light
        }
    }
}
