//
//  MainView.swift
//  VK_WeatherApp
//
//  Created by Ai Hawok on 22/07/2024.
//
import UIKit

class MainView: UIView {
    private let animationView = WeatherAnimationView()
    private let gradientLayer = CAGradientLayer()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = Constants.Colors.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location:\nVK house"
        label.font = Constants.Fonts.body
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
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
        layout.minimumLineSpacing = 3
        layout.itemSize = CGSize(width: 85, height: 85)
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
        setupAnimation()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        backgroundColor = Constants.Colors.primary
        addSubview(collectionView)
        addSubview(locationLabel)
        addSubview(containerView)
        addSubview(animationView)
        containerView.addSubview(weatherIcon)
        containerView.addSubview(weatherLabel)
        containerView.addSubview(descriptionLabel)
        
        bringSubviewToFront(collectionView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingSmall = Constants.Padding.small
        let paddingMedium = Constants.Padding.medium
        let paddingLarge = Constants.Padding.large
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: paddingSmall),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            
            locationLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: paddingLarge),
            locationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: paddingMedium),
            locationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -paddingMedium),
            
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            containerView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            
            weatherIcon.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            weatherIcon.topAnchor.constraint(equalTo: containerView.topAnchor, constant: paddingLarge),
            weatherIcon.widthAnchor.constraint(equalToConstant: 150),
            weatherIcon.heightAnchor.constraint(equalToConstant: 150),
            
            weatherLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            weatherLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: paddingSmall),
            weatherLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: paddingMedium),
            weatherLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -paddingMedium),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: paddingSmall),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: paddingMedium),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -paddingMedium),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -paddingMedium),
            
            animationView.topAnchor.constraint(equalTo: self.topAnchor),
            animationView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.reuseIdentifier)
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
        
        updateGradientBackground(topColor: weather.topColor, bottomColor: weather.bottomColor)
        
        switch weather.title {
        case "Rain":
            animationView.startRainAnimation()
        case "Thunder":
            animationView.startLightningAnimation()
        case "Starry Night":
            animationView.startStarryNightAnimation()
        case "Cloudy Day":
            animationView.startCloudAnimation(cloudCount: 15)
        case "Less Cloudy":
            animationView.startCloudAnimation(cloudCount: 5)
        default:
            animationView.stopAllAnimations()
        }
    }
    
    private func updateGradientBackground(topColor: UIColor, bottomColor: UIColor) {
        let newColors = [topColor.cgColor, bottomColor.cgColor]
        
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = gradientLayer.colors
        animation.toValue = newColors
        animation.duration = 1.0
        gradientLayer.add(animation, forKey: "colors")
        
        gradientLayer.colors = newColors
    }
}

//MARK: - Background setup

extension MainView {
    private func setupBackground() {
        setupGradientBackground()
        setupClouds()
        setupDoodles()
    }
    
    private func setupGradientBackground() {
        gradientLayer.colors = [Constants.Colors.light.cgColor, Constants.Colors.primary.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
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
}

//MARK: - Animation setup

extension MainView {
    private func setupAnimation() {
        animateWeatherIcon()
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
}
