//
//  ViewControllerFactory.swift
//  Loblaws
//
//  Created by Aliasgar Mala on 2020-06-05.
//  Copyright © 2020 Aliasgar Mala. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerFactory {
    
    let service: ServiceLayerClient
    init(service: ServiceLayerClient) {
        self.service = service
    }
    
    func mainViewController() -> UIViewController {
        let viewModel = ArticleViewModel(newsService: service, imageService: service)
        return ArticleMainViewController(viewModel: viewModel, viewControllerFactory: self)
    }
    
    func detailViewController(viewModel: ArticleRowViewModel) -> UIViewController {
        return DetailViewController(viewModel: viewModel)
    }
}
