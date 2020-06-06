//
//  ActivityIndicator.swift
//  Loblaws
//
//  Created by Aliasgar Mala on 2020-06-06.
//  Copyright © 2020 Aliasgar Mala. All rights reserved.
//

import UIKit

extension UIView {
    func showActivityIndicator() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.tag = 100
        addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    func hideActivityIndicator() {
        if let spinnerView = self.viewWithTag(100) {
            spinnerView.removeFromSuperview()
        }
    }
}
