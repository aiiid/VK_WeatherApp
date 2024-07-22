//
//  SplashScreenViewController.swift
//  VK_WeatherApp
//
//  Created by Ai Hawok on 22/07/2024.
//

import UIKit

class SplashScreenViewController: UIViewController {
    private let contentView = SplashView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.showMainScreen()
        }
    }
    
    func showMainScreen() {
        let mainViewController = MainViewController()
        
        guard let window = view.window else { return }
        
        window.rootViewController = mainViewController
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
