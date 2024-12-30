//
//  LaunchesViewController.swift
//  SpaceXProj
//
//  Created by Max on 27.12.2024.
//

import UIKit

let dataForUseLaunches = LauchesSpaceX()

class LaunchesViewController: UIViewController{
    
    var nameOfRocket: Rocket
    
    lazy var dataInToCell = dataForUseLaunches.getLaunchesByRocket(forRocket: nameOfRocket)
    
    private lazy var parametersCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 15
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(LaunchCollectionViewCell.self, forCellWithReuseIdentifier: LaunchCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    } ()
    
    init(rocketName: Rocket) {
        nameOfRocket = rocketName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupUI()
        setupLayout()
    }
    
    func setupUI() {
        self.view.addSubview(parametersCollectionView)
        self.view.backgroundColor = .black
        self.title = nameOfRocket.name
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            parametersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            parametersCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            parametersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            parametersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)
        ])
    }
}

extension LaunchesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataInToCell?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCollectionViewCell.identifier, for: indexPath) as? LaunchCollectionViewCell else {
            fatalError("Unable to deque CustomCollectionViewCell in LaunchesViewController")
        }
        cell.configureCell(nameOfRocket: dataInToCell?[indexPath.row].name ?? "Not defined", dateOfLaunch: dataInToCell?[indexPath.row].dateUTC ?? "Not defined", isSuccess: dataInToCell?[indexPath.row].success ?? false)
        
        return cell
    }
}
extension LaunchesViewController:UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.width / 4)
    }
}
