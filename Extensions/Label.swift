//
//  Label.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 24.11.2023.
//

import Foundation
import UIKit

extension UILabel {
    var actualNumberOfLines: Int {
        guard let text = self.text else {
            return 0
        }
        layoutIfNeeded()
        let rect = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = text.boundingRect(
            with: rect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font as Any],
            context: nil)
        return Int(ceil(CGFloat(labelSize.height) / font.lineHeight))
    }
}
