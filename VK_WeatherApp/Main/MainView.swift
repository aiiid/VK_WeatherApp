//
//  MainView.swift
//  VK_WeatherApp
//
//  Created by Ai Hawok on 22/07/2024.
//

import UIKit

class MainView: UIView {
    
    private let blurContainer: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.layer.cornerRadius = 16
        blurView.clipsToBounds = true
        blurView.translatesAutoresizingMaskIntoConstraints = false
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
        layout.minimumLineSpacing = 10
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
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            
            locationLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            locationLabel.heightAnchor.constraint(equalToConstant: 30),
            
            blurContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            blurContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            blurContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            blurContainer.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            
            weatherIcon.centerXAnchor.constraint(equalTo: blurContainer.contentView.centerXAnchor),
            weatherIcon.topAnchor.constraint(equalTo: blurContainer.contentView.topAnchor, constant: 20),
            weatherIcon.widthAnchor.constraint(equalToConstant: 150),
            weatherIcon.heightAnchor.constraint(equalToConstant: 150),
            
            weatherLabel.centerXAnchor.constraint(equalTo: blurContainer.contentView.centerXAnchor),
            weatherLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 10),
            weatherLabel.leadingAnchor.constraint(equalTo: blurContainer.contentView.leadingAnchor, constant: 20),
            weatherLabel.trailingAnchor.constraint(equalTo: blurContainer.contentView.trailingAnchor, constant: -20),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: blurContainer.contentView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: blurContainer.contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: blurContainer.contentView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: blurContainer.contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.reuseIdentifier)
    }
    
    func updateWeatherInfo(weather: Weather) {
        weatherIcon.image = weather.icon
        weatherLabel.text = weather.title
        descriptionLabel.text = weather.description
    }
}
