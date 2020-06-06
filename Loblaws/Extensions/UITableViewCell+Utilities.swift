//
//  UITableViewCell+Utilities.swift
//  Loblaws
//
//  Created by Aliasgar Mala on 2020-06-05.
//  Copyright © 2020 Aliasgar Mala. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
