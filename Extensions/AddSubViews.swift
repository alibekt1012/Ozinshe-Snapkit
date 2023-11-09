//
//  File.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 09.11.2023.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
