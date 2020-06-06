//
//  DetailViewController.swift
//  Loblaws
//
//  Created by Aliasgar Mala on 2020-06-06.
//  Copyright © 2020 Aliasgar Mala. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let viewModel: ArticleRowViewModel
    
    private var mainView: DetailView {
        return self.view as! DetailView
    }
    
    init(viewModel: ArticleRowViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        self.view = DetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureBindings()
    }
    
    private func configureNavigationBar() {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.text = viewModel.title.value
        navigationItem.titleView = label
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray]
               navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func configureBindings() {
        mainView.bind(viewModel: viewModel)
    }
}
