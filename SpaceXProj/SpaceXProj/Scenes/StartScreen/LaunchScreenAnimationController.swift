//
//  LaunchScreenAnimationController.swift
//  SpaceXProj
//
//  Created by Max on 15.01.2025.
//

import UIKit
import Lottie

class LaunchScreenAnimationController: UIViewController {

    private var animationView: LottieAnimationView!
    
    private var navigation: UINavigationController!
    
    let spaceXLabel = {
        let label  = UILabel()
        label.text = "SPACE X"
        label.font = .systemFont(ofSize: 70, weight: .bold)
        label.textColor = .white
        label.alpha = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let testTaskLabel = {
        let label  = UILabel()
        label.text = "test task by maxpnz"
        label.font = .systemFont(ofSize: 50, weight: .regular)
        label.textColor = .white
        label.alpha = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(navigation: UINavigationController?) {
        super.init(nibName: nil, bundle: nil)
        self.navigation = navigation
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        // Настраиваем анимацию Lottie
        animationView = LottieAnimationView(name: "rocketAnimation2")
        
        view.addSubview(animationView)
        view.addSubview(spaceXLabel)
        view.addSubview(testTaskLabel)
        
        NSLayoutConstraint.activate([
            spaceXLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spaceXLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            
            testTaskLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testTaskLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
        
        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        animationView.center = view.center
        animationView.loopMode = .playOnce
        animationView.play()
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animateLabelAppearanceAndFade()
        }
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.4) {
            self.goToMainScreen()
        }
    }

    private func goToMainScreen() {
        let initialViewController = PagesViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, navigation: self.navigation)
        initialViewController.modalTransitionStyle = .crossDissolve
        initialViewController.modalPresentationStyle = .fullScreen

        navigation?.pushViewController(initialViewController, animated: true)
    }
    
    private func animateLabelsAppearance() {
            UIView.animate(withDuration: 1.5) {
                self.spaceXLabel.alpha = 1
                
        }
    }
    
    private func animateLabelAppearanceAndFade() {
        UIView.animate(withDuration: 1.5, animations: {
            self.spaceXLabel.alpha = 1
            self.testTaskLabel.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 1.5, delay: 1, options: [.curveEaseIn], animations: {
                self.spaceXLabel.alpha = 0
                self.testTaskLabel.alpha = 0
            })
        }
    }
}

