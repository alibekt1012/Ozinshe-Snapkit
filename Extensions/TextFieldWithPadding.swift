//
//  TextFieldWithPadding.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 09.11.2023.
//

import Foundation

import UIKit

class TextFieldWithPadding: UITextField {

    var padding = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 16)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
