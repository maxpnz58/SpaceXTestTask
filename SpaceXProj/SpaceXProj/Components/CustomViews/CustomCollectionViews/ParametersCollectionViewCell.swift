//
//  CustomParametersCollectionViewCell.swift
//  SpaceXProj
//
//  Created by Max on 17.11.2024.
//

import UIKit

class ParametersCollectionViewCell: UICollectionViewCell {
    
   static let identifier = "ParametersCollectionViewCell"
    
    let cellParameterValue = {
        let label = UILabel()
        label.text = "229.9"
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cellParameterDescription = {
        let label = UILabel()
        label.text = "Высота, ft"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.6)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure( param: String, meaning: String) {
        cellParameterValue.text = meaning
        cellParameterDescription.text = param
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        contentView.layer.cornerRadius = 25
        
        contentView.addSubview(cellParameterValue)
        contentView.addSubview(cellParameterDescription)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            cellParameterValue.centerXAnchor.constraint(equalTo: centerXAnchor),
            cellParameterValue.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -5),
            
            cellParameterDescription.centerXAnchor.constraint(equalTo: centerXAnchor),
            cellParameterDescription.topAnchor.constraint(equalTo: centerYAnchor, constant: 5)
        ])
    }
}
