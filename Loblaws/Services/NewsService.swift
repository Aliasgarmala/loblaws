//
//  NewsService.swift
//  Loblaws
//
//  Created by Aliasgar Mala on 2020-06-05.
//  Copyright © 2020 Aliasgar Mala. All rights reserved.
//

import UIKit

protocol SwiftNewsService {
    func fetchSwiftNews(path: APIPaths, completion: @escaping (Result<ArticleContainer, ServiceLayerClient.ServiceError>) -> Void)
}

extension ServiceLayerClient: SwiftNewsService {
    
    func fetchSwiftNews(path: APIPaths, completion: @escaping (Result<ArticleContainer, ServiceError>) -> Void) {
        
        createDataTask(path: path.rawValue) { result in
            completion(result)
        }
    }
}
