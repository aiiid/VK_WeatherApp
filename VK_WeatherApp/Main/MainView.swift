//
//  MainView.swift
//  VK_WeatherApp
//
//  Created by Ai Hawok on 22/07/2024.
//

import UIKit

class MainView: UIView {
    private let gradientLayer = CAGradientLayer()
    
    private let blurContainer: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.layer.cornerRadius = 16
        blurView.clipsToBounds = true
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.shadowColor = UIColor.black.cgColor
        blurView.layer.shadowOpacity = 0.5
        blurView.layer.shadowOffset = CGSize(width: 0, height: 2)
        blurView.layer.shadowRadius = 4
        return blurView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.font = Constants.Fonts.body
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "weatherIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather"
        label.font = Constants.Fonts.title
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather description"
        label.font = Constants.Fonts.body
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 4
        layout.itemSize = CGSize(width: 90, height: 90)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupCollectionView()
        setupBackground()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        backgroundColor = Constants.Colors.primary
        addSubview(collectionView)
        addSubview(locationLabel)
        addSubview(blurContainer)
        blurContainer.contentView.addSubview(weatherIcon)
        blurContainer.contentView.addSubview(weatherLabel)
        blurContainer.contentView.addSubview(descriptionLabel)
        
        let paddingSmall = Constants.Padding.small
        let paddingMedium = Constants.Padding.medium
        let paddingLarge = Constants.Padding.large

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: paddingSmall),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            
            locationLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: paddingMedium),
            locationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: paddingMedium),
            locationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -paddingMedium),
            locationLabel.heightAnchor.constraint(equalToConstant: 30),
            
            blurContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            blurContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            blurContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            blurContainer.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            
            weatherIcon.centerXAnchor.constraint(equalTo: blurContainer.contentView.centerXAnchor),
            weatherIcon.topAnchor.constraint(equalTo: blurContainer.contentView.topAnchor, constant: paddingMedium),
            weatherIcon.widthAnchor.constraint(equalToConstant: 150),
            weatherIcon.heightAnchor.constraint(equalToConstant: 150),
            
            weatherLabel.centerXAnchor.constraint(equalTo: blurContainer.contentView.centerXAnchor),
            weatherLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: paddingSmall),
            weatherLabel.leadingAnchor.constraint(equalTo: blurContainer.contentView.leadingAnchor, constant: paddingMedium),
            weatherLabel.trailingAnchor.constraint(equalTo: blurContainer.contentView.trailingAnchor, constant: -paddingMedium),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: blurContainer.contentView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: paddingSmall),
            descriptionLabel.leadingAnchor.constraint(equalTo: blurContainer.contentView.leadingAnchor, constant: paddingMedium),
            descriptionLabel.trailingAnchor.constraint(equalTo: blurContainer.contentView.trailingAnchor, constant: -paddingMedium),
            descriptionLabel.bottomAnchor.constraint(equalTo: blurContainer.contentView.bottomAnchor, constant: -paddingMedium)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.reuseIdentifier)
    }
    
    private func setupBackground() {
        setupGradient()
        setupClouds()
        setupDoodles()
    }
    
    private func setupClouds() {
        let cloudImages = ["bgCloud1", "bgCloud2", "bgCloud3", "bgCloud4", "bgCloud5"]
        let screenWidth = UIScreen.main.bounds.width
        let initialCloudHeight = screenWidth * 0.45
        
        for (index, imageName) in cloudImages.enumerated() {
            let cloudImageView = UIImageView(image: UIImage(named: imageName))
            cloudImageView.contentMode = .scaleAspectFit
            cloudImageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(cloudImageView)
            
            let cloudHeight = initialCloudHeight - CGFloat(index) * 5
            let offsetX = CGFloat(arc4random_uniform(200)) - 100
            
            let alphaValue = (CGFloat(index) * 0.1)
            cloudImageView.alpha = alphaValue
            
            NSLayoutConstraint.activate([
                cloudImageView.widthAnchor.constraint(equalToConstant: screenWidth * 3),
                cloudImageView.heightAnchor.constraint(equalToConstant: cloudHeight),
                cloudImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: offsetX),
                cloudImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 30)
            ])
            
            animateCloud(cloudImageView, delay: Double(index) * 0.2)
        }
    }
    
    private func setupGradient() {
        gradientLayer.colors = [Constants.Colors.light, Constants.Colors.primary]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func animateCloud(_ cloud: UIImageView, delay: TimeInterval) {
        let screenWidth = UIScreen.main.bounds.width
        let initialX = (screenWidth - cloud.frame.width) / 2
        let finalX = initialX + 30
        let randomDuration = Double(arc4random_uniform(10) + 10)
        cloud.frame.origin.x = initialX
        
        UIView.animateKeyframes(withDuration: randomDuration, delay: delay, options: [.repeat, .autoreverse, .calculationModeLinear], animations: {
            cloud.frame.origin.x = finalX
        }, completion: nil)
    }
    
    private func animateWeatherIcon() {
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse, .curveEaseInOut], animations: {
            self.weatherIcon.transform = CGAffineTransform(translationX: 0, y: -10)
        }, completion: nil)
    }

    private func setupDoodles() {
        let doodle1 = UIImageView(image: UIImage(named: "doodle1"))
        let doodle2 = UIImageView(image: UIImage(named: "doodle2"))
        
        doodle1.alpha = 0.15
        doodle2.alpha = 0.15
        
        doodle1.contentMode = .scaleAspectFit
        doodle2.contentMode = .scaleAspectFit
        
        doodle1.translatesAutoresizingMaskIntoConstraints = false
        doodle2.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(doodle1)
        addSubview(doodle2)
        
        NSLayoutConstraint.activate([
            doodle1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -100),
            doodle1.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            doodle1.widthAnchor.constraint(equalToConstant: 580),
            doodle1.heightAnchor.constraint(equalToConstant: 380)
        ])
        
        doodle2.transform = CGAffineTransform(rotationAngle: .pi)
        NSLayoutConstraint.activate([
            doodle2.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            doodle2.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            doodle2.widthAnchor.constraint(equalToConstant: 1000),
            doodle2.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func updateWeatherInfo(weather: Weather) {
        UIView.transition(with: weatherIcon, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.weatherIcon.image = weather.icon
        }, completion: nil)
        
        UIView.transition(with: weatherLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.weatherLabel.text = weather.title
        }, completion: nil)
        
        UIView.transition(with: descriptionLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.descriptionLabel.text = weather.description
        }, completion: nil)
    }
}
