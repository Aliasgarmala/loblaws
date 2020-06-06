//
//  UIView+AutoLayout.swift
//  Loblaws
//
//  Created by Aliasgar Mala on 2020-06-05.
//  Copyright © 2020 Aliasgar Mala. All rights reserved.
//

import UIKit

extension UIView {
    
    func pinToEdges(of view:UIView, padding: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: padding.top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding.bottom)
        ])
    }
}

