//
//  DetailView.swift
//  Loblaws
//
//  Created by Aliasgar Mala on 2020-06-06.
//  Copyright © 2020 Aliasgar Mala. All rights reserved.
//

import UIKit
import WebKit

class DetailView: UIView {
    private let scrollView = UIScrollView()
    
    private let imageView = UIImageView()
    private let webView = WKWebView()
    
    private var heightConstraint: NSLayoutConstraint?
    
    init() {
        super.init(frame: CGRect.zero)
        postInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
    
    private func postInit() {
        configureView()
        setupConstraints()
    }
    
    private func configureView() {
        tintColor = .black
        backgroundColor = .white
        layoutMargins = UIEdgeInsets.zero
        accessibilityViewIsModal = true

        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .interactive
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        scrollView.addSubview(webView)
    }
    
    private func setupConstraints() {
        scrollView.pinToEdges(of: self)
        scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        webView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        heightConstraint = webView.heightAnchor.constraint(equalToConstant: 1427)
        heightConstraint?.isActive = true
        webView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        webView.scrollView.isScrollEnabled = false
    }
    
    func bind(viewModel: ArticleRowViewModel) {
        imageView.image = viewModel.thumbnail.value
        webView.load(URLRequest(url: viewModel.url))
    }
}

extension DetailView: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        scrollView.showActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        scrollView.hideActivityIndicator()
        heightConstraint?.constant = webView.scrollView.contentSize.height
    }
}
