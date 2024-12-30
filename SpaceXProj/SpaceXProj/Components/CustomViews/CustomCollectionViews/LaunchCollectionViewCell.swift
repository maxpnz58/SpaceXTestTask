//
//  LaunchCollectionViewCell.swift
//  SpaceXProj
//
//  Created by Max on 30.12.2024.
//

import UIKit

class LaunchCollectionViewCell: UICollectionViewCell {

    static let identifier = "LaunchCollectionViewCell"
    
    private let launchNameLabel = {
        let label  = UILabel()
        label.text = "Falcon Sat"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let launchDateLabel = {
        let label  = UILabel()
        label.text = "2 февраля, 2022"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.8)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rocketIconImage = {
        let label = UILabel()
        label.text = "🚀"
        label.font = UIFont.systemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let successTickLabel = {
        let label = UILabel()
        label.text = "✅"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
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
    
    public func configureCell(nameOfRocket: String, dateOfLaunch: String, isSuccess: Bool) {
        launchNameLabel.text = nameOfRocket
        launchDateLabel.text = formatDateString(dateOfLaunch)
        configurePicture(isSucceess: isSuccess)
    }
    
    private func configurePicture(isSucceess: Bool) {
        if isSucceess {
            successTickLabel.text = "✅"
            rocketIconImage.transform = CGAffineTransform(scaleX: 1, y: 1)
        } else {
            successTickLabel.text = "❌"
            rocketIconImage.transform = CGAffineTransform(scaleX: -1, y: -1)
        }
    }
    
    func formatDateString(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        guard let date = dateFormatter.date(from: dateString) else {
            print("Ошибка при разборе даты")
            return dateString
        }
        
        let formattedDateFormatter = DateFormatter()
        formattedDateFormatter.dateFormat = "d MMMM yyyy"
        formattedDateFormatter.locale = Locale(identifier: "ru_RU")
        
        let formattedDate = formattedDateFormatter.string(from: date)
        return formattedDate
    }
    
    private func setupUI() {
        contentView.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        contentView.layer.cornerRadius = 25
        
        contentView.addSubview(launchNameLabel)
        contentView.addSubview(launchDateLabel)
        contentView.addSubview(rocketIconImage)
        addSubview(successTickLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            launchNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -20),
            launchNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            launchDateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 20),
            launchDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            rocketIconImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rocketIconImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            rocketIconImage.heightAnchor.constraint(equalToConstant: 50),
            rocketIconImage.widthAnchor.constraint(equalToConstant: 50),
            
            successTickLabel.trailingAnchor.constraint(equalTo: rocketIconImage.trailingAnchor, constant: 5),
            successTickLabel.bottomAnchor.constraint(equalTo: rocketIconImage.bottomAnchor, constant: 5)
        ])
    }
}

