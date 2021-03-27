//
//  UIView+Extensions.swift
//  CoreDataProject
//
//  Created by Alexey Pavlov on 23.03.2021.
//

import UIKit

public extension UIView {

    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

}
