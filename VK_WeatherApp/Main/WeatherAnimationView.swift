//
//  WeatherAnimationView.swift
//  VK_WeatherApp
//
//  Created by Ai Hawok on 23/07/2024.
//
import UIKit

class WeatherAnimationView: UIView {
    
    private var rainLayers: [CAEmitterLayer] = []
    private var lightningImageViews: [UIImageView] = []
    private var starLayers: [CALayer] = []
    private var cloudImageViews: [UIImageView] = []
    
    private let lightningImages = ["lightning1", "lightning2", "lightning3", "lightning4", "lightning5"]
    private let cloudImages = ["cloud1", "cloud2", "cloud3", "cloud4", "cloud5", "cloud6"]
    
    private var isLightning = false

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Rain
    func startRainAnimation() {
        print("Starting rain animation")
        stopAllAnimations()
        let rainLayer = CAEmitterLayer()
        rainLayer.emitterPosition = CGPoint(x: bounds.width, y: -50)
        rainLayer.emitterShape = .line
        rainLayer.emitterSize = CGSize(width: bounds.width, height: 1)
        
        let rainCell = CAEmitterCell()
        rainCell.birthRate = 25
        rainCell.lifetime = 5.0
        rainCell.velocity = 200
        rainCell.velocityRange = 50
        rainCell.emissionLongitude = .pi
        rainCell.emissionRange = .pi / 8
        rainCell.xAcceleration = -100
        rainCell.yAcceleration = 200
        rainCell.scale = 0.15
        rainCell.scaleRange = 0.05
        rainCell.color = UIColor.white.cgColor
        rainCell.contents = UIImage(named: "raindrop")?.cgImage
        
        rainLayer.emitterCells = [rainCell]
        layer.addSublayer(rainLayer)
        rainLayers.append(rainLayer)
    }
    
    //MARK: - Lightning
    func startLightningAnimation() {
        print("Starting lightning animation")
        stopAllAnimations()
        isLightning = true
        scheduleNextLightning(lightningImages)
        
    }

    private func scheduleNextLightning(_ lightningImages: [String]) {
        if isLightning {
            let randomDelay = Double(arc4random_uniform(5) + 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay) {
                let randomImage = lightningImages.randomElement()!
                self.animateLightningImage(randomImage)
                self.scheduleNextLightning(lightningImages)
            }
        }
    }

    private func animateLightningImage(_ imageName: String) {
        let lightningImageView = UIImageView(image: UIImage(named: imageName))
        let imageSize: CGFloat = 500
        let maxX = max(self.bounds.width - imageSize, 0)
        let maxY = max(self.bounds.height - imageSize, 0)
        let randomX = CGFloat(arc4random_uniform(UInt32(maxX)))
        let randomY = CGFloat(arc4random_uniform(UInt32(maxY)))
        lightningImageView.frame = CGRect(x: randomX, y: randomY, width: imageSize, height: imageSize)
        lightningImageView.alpha = 0.0
        self.addSubview(lightningImageView)
        self.lightningImageViews.append(lightningImageView)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.autoreverse], animations: {
            lightningImageView.alpha = 1.0
        }, completion: { _ in
            lightningImageView.removeFromSuperview()
        })
    }

    //MARK: - Stars
    func startStarryNightAnimation() {
        print("Starting starry night animation")
        stopAllAnimations()
        for _ in 0..<50 {
            let starLayer = CALayer()
            if let starImage = UIImage(named: "star")?.cgImage {
                starLayer.contents = starImage
            }
            let size: CGFloat = CGFloat(arc4random_uniform(5) + 2)
            starLayer.frame = CGRect(x: CGFloat(arc4random_uniform(UInt32(bounds.width))),
                                     y: CGFloat(arc4random_uniform(UInt32(bounds.height))),
                                     width: size,
                                     height: size)
            starLayer.cornerRadius = size / 2
            layer.addSublayer(starLayer)
            starLayers.append(starLayer)
            
            let fadeIn = CABasicAnimation(keyPath: "opacity")
            fadeIn.fromValue = 0.0
            fadeIn.toValue = 1.0
            fadeIn.duration = CFTimeInterval(arc4random_uniform(5) + 2)
            fadeIn.autoreverses = true
            fadeIn.repeatCount = .greatestFiniteMagnitude
            fadeIn.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            starLayer.opacity = 0.0
            starLayer.add(fadeIn, forKey: "fadeInOut")
        }
    }

    //MARK: - Clouds
    func startCloudAnimation(cloudCount: Int) {
        print("Starting cloud animation")
        stopAllAnimations()
        for _ in 0..<cloudCount {
            let randomImageName = cloudImages.randomElement()!
            let cloudImageView = UIImageView(image: UIImage(named: randomImageName))
            let randomY = CGFloat.random(in: 0...max(bounds.height - 200, 0))
            let randomX = CGFloat.random(in: 0...max(bounds.width - 200, 0))
            cloudImageView.frame = CGRect(x: randomX, y: randomY, width: 400, height: 200)
            cloudImageView.alpha = 0.0
            addSubview(cloudImageView)
            cloudImageViews.append(cloudImageView)
            animateCloud(cloudImageView)
        }
    }
    
    private func animateCloud(_ cloud: UIImageView) {
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = cloud.frame.origin.x
        animation.toValue = bounds.width + 200
        animation.duration = 40
        animation.repeatCount = .infinity
        cloud.layer.add(animation, forKey: "cloudMovement")
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
            cloud.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 1.0, delay: 39, options: [], animations: {
                cloud.alpha = 0.0
            }, completion: { _ in
                cloud.removeFromSuperview()
            })
        })
    }
    
    //MARK: - Reset
    func stopAllAnimations() {
        isLightning = false
        rainLayers.forEach { $0.removeFromSuperlayer() }
        lightningImageViews.forEach { $0.removeFromSuperview() }
        starLayers.forEach { $0.removeFromSuperlayer() }
        cloudImageViews.forEach { $0.removeFromSuperview() }
        
        rainLayers.removeAll()
        lightningImageViews.removeAll()
        starLayers.removeAll()
        cloudImageViews.removeAll()
    }
}
