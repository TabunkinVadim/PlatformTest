//
//  UIFactory.swift
//  PlatformTest
//
//  Created by Табункин Вадим on 21.09.2023.
//

import UIKit

class UIFactory {

    func addImage(imageNamed: String,cornerRadius: CGFloat,borderWidth: CGFloat, borderColor: CGColor?, clipsToBounds: Bool, contentMode: UIView.ContentMode,tintColor: UIColor?, backgroundColor: UIColor? ) -> UIImageView {
        return {
            $0.toAutoLayout()
            $0.layer.cornerRadius = cornerRadius
            $0.layer.borderWidth = borderWidth
            $0.layer.borderColor =  borderColor
            $0.clipsToBounds = clipsToBounds
            $0.contentMode = contentMode
            $0.tintColor = tintColor
            $0.backgroundColor = backgroundColor
            $0.image = UIImage(named: imageNamed)
            if $0.image == nil{
                $0.image = UIImage(systemName: imageNamed)
            }
            return $0
        }(UIImageView())
    }

    func addBoldTextLable(lable: String?, textColor: UIColor, textSize: CGFloat, textAlignment: NSTextAlignment) -> UILabel {
        return {
            $0.toAutoLayout()
            $0.numberOfLines = 0
//            $0.attributedText = NSMutableAttributedString(string: lable!, attributes: [NSAttributedString.Key.kern: 0.18])
            $0.font = UIFont(name: "Bold", size: textSize)
            $0.textColor = textColor
            $0.textAlignment = textAlignment
            return $0
        }(UILabel())
    }

    func addRegularTextLable(lable: String?, textColor: UIColor, textSize: CGFloat, textAlignment: NSTextAlignment) -> UILabel {
        return {
//            let paragraphStyle = NSMutableParagraphStyle()
//            paragraphStyle.lineHeightMultiple = lineHeightMultiple
            $0.toAutoLayout()
            $0.numberOfLines = 0
//            $0.attributedText = NSMutableAttributedString(string: lable!,  attributes: [NSAttributedString.Key.kern: 0.12, NSAttributedString.Key.paragraphStyle: paragraphStyle])
            $0.font = UIFont(name: "Regular", size: textSize)
            $0.textColor = textColor
            $0.textAlignment = textAlignment
            return $0
        }(UILabel())
    }
}
