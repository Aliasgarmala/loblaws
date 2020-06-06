//
//  ArticlePreviewCell.swift
//  Loblaws
//
//  Created by Aliasgar Mala on 2020-06-05.
//  Copyright © 2020 Aliasgar Mala. All rights reserved.
//

import UIKit

class ArticlePreviewCell: UITableViewCell {
    private let titleLabel = UILabel()
    private var thumbnailView = UIImageView()
    
    private let verticalStackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        postInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func postInit() {
        configureView()
        setupConstraints()
    }
    
    private func configureView() {
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.spacing = 5
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(verticalStackView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        verticalStackView.addArrangedSubview(titleLabel)
        
        thumbnailView.contentMode = .scaleAspectFit
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.addArrangedSubview(thumbnailView)
    }

    private func setupConstraints() {
        verticalStackView.pinToEdges(of: contentView, padding: UIEdgeInsets(top: 10, left: 6, bottom: 10, right: 6))
    }
    
    func bind(viewModel: ArticleRowViewModel) {
    
        viewModel.title.bind { [weak self] in
            self?.titleLabel.text = $0
        }
        
        thumbnailView.image = nil
        viewModel.thumbnail.bind { [weak self] in
            self?.thumbnailView.image = $0
        }
    }
}
