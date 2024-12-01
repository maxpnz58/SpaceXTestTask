//
//  ViewController.swift
//  SpaceXProj
//
//  Created by Max on 17.11.2024.
//

import UIKit

let dataForUse = rocketsSpaceX()

class SpaceXInitialScreen: UIViewController {
    
    let backImage = {
        let image = UIImageView()
        image.image = UIImage(named: "rocketPic1")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let parametrsScrollView: UIScrollView = {
        let view = UIScrollView()
        view.bounces = true
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let parametersScrollContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rocketNameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.text = "Falcon Heavy"
        label.textColor = .white.withAlphaComponent(0.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rocketSettingsButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var parametersCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 15
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(ParametersCollectionViewCell.self, forCellWithReuseIdentifier: ParametersCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    } ()
    
    var tableView = {
        let view = ParametersTableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var pageNumber = 0
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.page = pageNumber
        self.view.backgroundColor = .black
        setupLayout()
        setupData()
    }
    init(numberOfPage: Int) {
        super.init(nibName: nil, bundle: nil)
        pageNumber = numberOfPage
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension SpaceXInitialScreen {
    func setupData() {
        if let image = UIImage(named: dataForUse.rocketPictures[pageNumber]) { backImage.image = image }
        rocketNameLabel.text = dataForUse.rockets?[pageNumber].name ?? "Not defined"
    }
    
    func setupUI() {
        view.addSubview(backImage)
        view.addSubview(parametrsScrollView)
        parametrsScrollView.addSubview(parametersScrollContentView)
        parametersScrollContentView.addSubview(rocketNameLabel)
        parametersScrollContentView.addSubview(rocketSettingsButton)
        parametersScrollContentView.addSubview(parametersCollectionView)
        parametersScrollContentView.addSubview(tableView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            backImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            backImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -110),
            
            parametrsScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            parametrsScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80),
            parametrsScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            parametrsScrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            
            parametersScrollContentView.topAnchor.constraint(equalTo: parametrsScrollView.topAnchor),
            parametersScrollContentView.leadingAnchor.constraint(equalTo: parametrsScrollView.leadingAnchor),
            parametersScrollContentView.trailingAnchor.constraint(equalTo: parametrsScrollView.trailingAnchor),
            parametersScrollContentView.bottomAnchor.constraint(equalTo: parametrsScrollView.bottomAnchor),
            parametersScrollContentView.widthAnchor.constraint(equalTo: parametrsScrollView.widthAnchor),
            parametersScrollContentView.heightAnchor.constraint(equalToConstant: 800),
            
            rocketNameLabel.leadingAnchor.constraint(equalTo: parametersScrollContentView.leadingAnchor, constant: 40),
            rocketNameLabel.topAnchor.constraint(equalTo: parametersScrollContentView.topAnchor, constant: 50),
            
            rocketSettingsButton.trailingAnchor.constraint(equalTo: parametersScrollContentView.trailingAnchor, constant: -40),
            rocketSettingsButton.bottomAnchor.constraint(equalTo: rocketNameLabel.bottomAnchor),
            rocketSettingsButton.heightAnchor.constraint(equalToConstant: 40),
            rocketSettingsButton.widthAnchor.constraint(equalToConstant: 40),
            
            parametersCollectionView.leadingAnchor.constraint(equalTo: parametersScrollContentView.leadingAnchor),
            parametersCollectionView.topAnchor.constraint(equalTo: rocketNameLabel.bottomAnchor, constant: 20),
            parametersCollectionView.trailingAnchor.constraint(equalTo: parametersScrollContentView.trailingAnchor),
            parametersCollectionView.heightAnchor.constraint(equalToConstant: 140),
            
            tableView.leadingAnchor.constraint(equalTo: parametersScrollContentView.leadingAnchor, constant: 40),
            tableView.topAnchor.constraint(equalTo: parametersCollectionView.bottomAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: parametersScrollContentView.trailingAnchor, constant: -40),
            tableView.bottomAnchor.constraint(equalTo: parametersScrollContentView.bottomAnchor),
        ])
    }
}


extension SpaceXInitialScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataForUse.rocketCollectionParametersNames[0].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParametersCollectionViewCell.identifier, for: indexPath) as? ParametersCollectionViewCell else {
            fatalError("Unable to deque CustomCollectionViewCell in HomeController")
        }
        cell.configure(param: dataForUse.rocketCollectionParametersNames[0][indexPath.row], meaning: dataForUse.rocketCollectionParameters[pageNumber][indexPath.row] )
        return cell
    }
}
extension SpaceXInitialScreen:UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
}
