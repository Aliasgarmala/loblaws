//
//  SwiftNews.swift
//  Loblaws
//
//  Created by Aliasgar Mala on 2020-06-05.
//  Copyright © 2020 Aliasgar Mala. All rights reserved.
//

import Foundation

struct SwiftNews {
    
    let viewControllerFactory: ViewControllerFactory
    
    init() {
        let service = ServiceLayerClient()
        self.viewControllerFactory = ViewControllerFactory(service: service)
    }
}
