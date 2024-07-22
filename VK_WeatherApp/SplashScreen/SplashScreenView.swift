//
//  SplashScreenView.swift
//  VK_WeatherApp
//
//  Created by Ai Hawok on 22/07/2024.
//

import UIKit

class SplashView: UIView {
    
    let mainImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "sunClouds"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let mainText: UILabel = {
        var text = UILabel()
        text.text = "Weather showcase"
        text.font = Constants.Fonts.title
        text.textColor = .white
        text.textAlignment = .center
        return text
    }()
    
    let versionLabel: UILabel = {
        var text = UILabel()
        text.font = Constants.Fonts.body
        text.textColor = .white
        text.textAlignment = .center
        return text
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
        addSubview(mainImage)
        addSubview(mainText)
        addSubview(versionLabel)
        
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        mainText.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainImage.widthAnchor.constraint(equalToConstant: 200),
            mainImage.heightAnchor.constraint(equalToConstant: 200),
            
            mainText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainText.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 5),
            mainText.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainText.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            versionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.Padding.large),
            versionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLabel.text = "Version \(version)"
        }
    }
}
