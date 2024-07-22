//
//  MainViewController.swift
//  VK_WeatherApp
//
//  Created by Ai Hawok on 22/07/2024.
//

import UIKit

class MainViewController: UIViewController {
    private var mainView: MainView!
    
    override func loadView() {
        mainView = MainView(frame: UIScreen.main.bounds)
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
