//
//  ArticleRowViewMode.swift
//  Loblaws
//
//  Created by Aliasgar Mala on 2020-06-05.
//  Copyright © 2020 Aliasgar Mala. All rights reserved.
//

import Foundation
import UIKit

class ArticleRowViewModel {
    
    private let article: Article
    let title: Box<String> = Box("")
    let thumbnail: Box<UIImage?> = Box(nil)
    let url: URL
    let imageService: ImageService
    
    init(article: Article, imageService: ImageService) {
        self.article = article
        self.title.value = article.title
        self.url = URL(string: article.url)!
        self.imageService = imageService
        if let urlString = self.article.thumbnail,
            urlString.hasPrefix("https://"),
            let url = URL(string: urlString),
            let placeHolderImage = UIImage(named: "placeholder"){
            
            thumbnail.value = placeHolderImage
            imageService.fetchImage(url: url) { [weak self] image in
                guard let self = self else {return}
                self.thumbnail.value = image
            }
        }
    }
}
