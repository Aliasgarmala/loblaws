//
//  ViewController.swift
//  Loblaws
//
//  Created by Aliasgar Mala on 2020-06-05.
//  Copyright © 2020 Aliasgar Mala. All rights reserved.
//

import UIKit

class ArticleMainViewController: UITableViewController {
    let viewModel: ArticleViewModel
    let viewControllerFactory: ViewControllerFactory
    private var rows: [ArticleRowViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
        
    init(viewModel: ArticleViewModel, viewControllerFactory: ViewControllerFactory) {
        self.viewModel = viewModel
        self.viewControllerFactory = viewControllerFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        configureBindings()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = viewModel.navigationTitle
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.gray]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        viewModel.navigationDelegate = self
    }
    
    private func configureTableView() {
        tableView.register(ArticlePreviewCell.self, forCellReuseIdentifier: ArticlePreviewCell.defaultReuseIdentifier)
    }
    
    private func configureBindings() {
        
        viewModel.isLoading.bind { [weak self] isLoading in
            isLoading ? self?.view.showActivityIndicator() : self?.view.hideActivityIndicator()
        }
        viewModel.rows.bind { [weak self] in
            self?.rows = $0
        }
    }
    
    //MARK: TABLE VIEW DATASOURCE AND DELEGATE
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: ArticlePreviewCell.defaultReuseIdentifier) as? ArticlePreviewCell else {
           preconditionFailure("This should never be nil")
        }
        
        tableViewCell.bind(viewModel: rows[indexPath.row])
        return tableViewCell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectedRow.value = rows[indexPath.row]
    }
}

//MARK: Navigate to detail view
extension ArticleMainViewController: ArticleNavigationDelegate {
    func navigateToArticle(_ rowViewModel: ArticleRowViewModel) {
        navigationController?.pushViewController(viewControllerFactory.detailViewController(viewModel: rowViewModel), animated: true)
    }
}


