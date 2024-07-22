//
//  RainViewController.swift
//  VK_WeatherApp
//
//  Created by Ai Hawok on 23/07/2024.
//

import Foundation
import UIKit

class RainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black // Set background color to make the white rain stand out
        setupRainAnimation()
    }
    
    private func setupRainAnimation() {
        let rainEmitter = CAEmitterLayer()
        rainEmitter.emitterPosition = CGPoint(x: view.bounds.width / 2, y: -50) // Start the rain from above the view
        rainEmitter.emitterSize = CGSize(width: view.bounds.width, height: 1)
        rainEmitter.emitterShape = .line
        
        let rainCell = CAEmitterCell()
        rainCell.birthRate = 25
        rainCell.lifetime = 5.0
        rainCell.velocity = 200
        rainCell.velocityRange = 50
        rainCell.emissionLongitude = .pi
        rainCell.scale = 0.1
        rainCell.scaleRange = 0.05
        rainCell.color = UIColor.white.cgColor
        rainCell.contents = UIImage(named: "raindrop")?.cgImage
        
        rainEmitter.emitterCells = [rainCell]
        view.layer.addSublayer(rainEmitter)
    }
}

