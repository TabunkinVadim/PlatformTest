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
