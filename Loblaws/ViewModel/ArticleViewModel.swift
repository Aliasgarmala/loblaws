//
//  ArticleViewModel.swift
//  Loblaws
//
//  Created by Aliasgar Mala on 2020-06-05.
//  Copyright © 2020 Aliasgar Mala. All rights reserved.
//

import Foundation
protocol ArticleNavigationDelegate: class {
    func navigateToArticle(_ rowViewModel: ArticleRowViewModel)
}

class ArticleViewModel {
    
    weak var navigationDelegate: ArticleNavigationDelegate?
    
    let navigationTitle: String
    let swiftNewsService: SwiftNewsService
    let imageService: ImageService
    var rows: Box<[ArticleRowViewModel]> = Box([])
    let selectedRow: Box<ArticleRowViewModel?> = Box(nil)
    var isLoading: Box<Bool> = Box(false)
    
    init(newsService: SwiftNewsService, imageService: ImageService) {
        self.swiftNewsService = newsService
        self.imageService = imageService
        self.navigationTitle = "Swift News"
        postInit()
        configureBindings()
    }
    
    private func postInit() {
        isLoading.value = true
        swiftNewsService.fetchSwiftNews(path: APIPaths.fetchNews) { [weak self] result in
            guard let self = self else { return }
            
            self.isLoading.value = false
            switch result {
                
            case .success(let articles):
                self.rows.value = articles.articles.map { ArticleRowViewModel(article: $0, imageService: self.imageService) }
            case .failure(let error):
                // can show error pop up here
                print(error)
            }
        }
    }
    
    private func configureBindings() {
        selectedRow.bind { [weak self] (articleViewModel: ArticleRowViewModel?) in
            guard let articleViewModel = articleViewModel else {return}
            self?.navigateToDetailScreen(articleViewModel)
        }
    }
    
    private func navigateToDetailScreen(_ rowViewModel: ArticleRowViewModel) {
         navigationDelegate?.navigateToArticle(rowViewModel)
    }
}
