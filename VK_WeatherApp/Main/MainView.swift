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
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather description"
        label.font = Constants.Fonts.body
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        backgroundColor = Constants.Colors.primary
        addSubview(blurContainer)
        blurContainer.contentView.addSubview(locationLabel)
        blurContainer.contentView.addSubview(weatherIcon)
        blurContainer.contentView.addSubview(weatherLabel)
        blurContainer.contentView.addSubview(descriptionLabel)
        
        blurContainer.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blurContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            blurContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            blurContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            blurContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            
            locationLabel.centerXAnchor.constraint(equalTo: blurContainer.contentView.centerXAnchor),
            locationLabel.topAnchor.constraint(equalTo: blurContainer.contentView.topAnchor, constant: 20),
            locationLabel.leadingAnchor.constraint(equalTo: blurContainer.contentView.leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: blurContainer.contentView.trailingAnchor, constant: -20),
            
            weatherIcon.centerXAnchor.constraint(equalTo: blurContainer.contentView.centerXAnchor),
            weatherIcon.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            weatherIcon.widthAnchor.constraint(equalToConstant: 90),
            weatherIcon.heightAnchor.constraint(equalToConstant: 90),
            
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
}
