//
//  ParametersTableViewHeaderFooter.swift
//  SpaceXProj
//
//  Created by Max on 27.11.2024.
//

import UIKit

class ParametersTableViewHeaderFooterView: UITableViewHeaderFooterView {
    static let identifier = "ParametersTableViewHeaderFooter"
    
    private let titleLabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
   
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        contentView.backgroundColor = .clear
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}
