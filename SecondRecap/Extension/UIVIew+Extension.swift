//
//  UIVIew+Extension.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
