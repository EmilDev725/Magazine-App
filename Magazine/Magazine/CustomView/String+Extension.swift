//
//  String+Extension.swift
//  Quest-ios
//
//  Created by Dev on 21/02/2018.
//  Copyright © 2018 SecretCircle. All rights reserved.
//

import Foundation

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedStringKey.font: font],
                                            context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedStringKey.font: font],
                                            context: nil)

        return ceil(boundingBox.width)
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.width)
    }

//    func attributedText(withString string: String, boldString: String, font: UIFont, boldFont: UIFont) -> NSAttributedString {
//        let attributedString = NSMutableAttributedString(string: string,
//                                                         attributes: [NSAttributedStringKey.font: font])
//        let boldFontAttribute: [String: Any] = [NSAttributedStringKey.font.rawValue: boldFont]
//        let range = (string.lowercased() as NSString).range(of: boldString.lowercased())
//        attributedString.addAttributes(boldFontAttribute, range: range)
//        return attributedString
//    }
}
