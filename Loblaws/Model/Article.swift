//
//  Article.swift
//  Loblaws
//
//  Created by Aliasgar Mala on 2020-06-05.
//  Copyright © 2020 Aliasgar Mala. All rights reserved.
//

import Foundation

struct ArticleContainer: Decodable {
    let articles:[Article]
    
    enum CodingKeys: String, CodingKey {
        case data
        case children
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        let children = try data.decode([Children].self, forKey: .children)
        articles = children.map { $0.data }
    }
}

struct Children: Decodable {
    let data: Article
}

struct Article: Decodable {
    let title: String
    let thumbnail: String?
    let url: String
}






