//
//  ParametersTableViewCell.swift
//  SpaceXProj
//
//  Created by Max on 18.11.2024.
//

import UIKit

class ParametersTableViewCell: UITableViewCell {
    static let identifier = "ParametersTableViewCell"
    
    let leftLabel = {
        let label  = UILabel()
        label.text = "параметр"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.8)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rightLabel = {
        let label  = UILabel()
        label.text = "значение"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.8)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
        setupData()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            self.contentView.heightAnchor.constraint(equalToConstant: 50),
            
            leftLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            leftLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            rightLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            rightLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
        ])
        
    }
    
    func setupData(_ leftText: String? = "Параметр",_ rightText: String? = "Значение") {
        leftLabel.text = leftText
        rightLabel.text = rightText
    }
    
}
