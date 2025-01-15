//
//  SettingsViewController.swift
//  SpaceXProj
//
//  Created by Max on 08.01.2025.
//

import UIKit

class SettingsViewController: UIViewController {
    weak var delegate: SettingsViewControllerDelegate?
    
    let labelsText = ["Высота", "Диаметр", "Масса", "Полезная нагрузка"]
    let segmentedControlData = [["m", "ft"],["m","ft"],["kg","lb"],["kg","lb"]]
    
    
    private let backButton = {
        let button = UIButton(type: .system)
        button.setTitle("Закрыть", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let settingsLabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heightLabel = {
        let label = UILabel()
        label.text = "Высота"
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        setupUI()
        setupLayout()
        createLabels()
        setupTargets()
    }
}

extension SettingsViewController {
    func createLabels() {
        
        var previousElement: UIView? = nil
        
        for (index , text) in labelsText.enumerated() {
            
            // Cоздаем labels
            let label = UILabel()
            label.text = text
            label.textColor = .white
            label.font = .systemFont(ofSize: 22, weight: .regular)
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            
            let segmentedControl = UISegmentedControl(items: segmentedControlData[index])
            segmentedControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "Segment_\(labelsText[index])")
            segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
            segmentedControl.tag = index
            segmentedControl.translatesAutoresizingMaskIntoConstraints = false
            segmentedControl.tintColor = .clear
            segmentedControl.backgroundColor  = UIColor(
                red: 15.0 / 255.0,
                green: 13.0 / 255.0,
                blue: 15.0 / 255.0,
                alpha: 0.1
            )
            segmentedControl.translatesAutoresizingMaskIntoConstraints = false
            
            let normalAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 16), // Обычный шрифт, размер 14
                .foregroundColor: UIColor.gray
            ]

            let selectedAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 18), // Жирный шрифт, размер 16
                .foregroundColor: UIColor.black
            ]

            segmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
            segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)
    
            view.addSubview(segmentedControl)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            ])
            
            if let previous = previousElement {
                NSLayoutConstraint.activate([
                    label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 25)
                ])
            } else {
                NSLayoutConstraint.activate([
                    label.topAnchor.constraint(equalTo: view.topAnchor, constant: 135)
                ])
            }
            
            NSLayoutConstraint.activate([
                segmentedControl.widthAnchor.constraint(equalToConstant: 130),
                segmentedControl.heightAnchor.constraint(equalToConstant: 40),
                segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
                segmentedControl.centerYAnchor.constraint(equalTo: label.centerYAnchor)
            ])
            previousElement = label
        }
    }
    
    private func setupUI() {
        view.addSubview(settingsLabel)
        view.addSubview(backButton)
        view.backgroundColor = .black
        title = "Настройки"
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            settingsLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            settingsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            backButton.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 45),
        ])
    }
    
    func setupTargets() {
        backButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
        let index = sender.tag
        let selectedValue = sender.selectedSegmentIndex
        
        // Сохраняем значение в UserDefaults
        UserDefaults.standard.set(selectedValue, forKey: "Segment_\(labelsText[index])")
        print("Saved Segment_\(labelsText[index]): \(selectedValue)")
    }
}

protocol SettingsViewControllerDelegate: AnyObject {
    func settingsDidUpdate()
}

extension SettingsViewController {

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        delegate?.settingsDidUpdate()
    }
}

